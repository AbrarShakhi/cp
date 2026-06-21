#!/usr/bin/env python3

import subprocess
from abc import ABC, abstractmethod
from pathlib import Path

class ILanguage(ABC):

    @property
    @abstractmethod
    def extension(self) -> str: pass

    @property
    @abstractmethod
    def template_name(self) -> str: pass

    def create(self, src: Path, template_dir: Path) -> None:
        src.parent.mkdir(parents=True, exist_ok=True)
        template = template_dir / self.template_name

        if not template.exists():
            raise FileNotFoundError(
                f"Template not found: {template}"
            )
        src.write_text(template.read_text())

    @abstractmethod
    def compile(self, src: Path, output: Path) -> None: pass

    @abstractmethod
    def compile_debug(self, src: Path, output: Path) -> None: pass

    @abstractmethod
    def run(self, executable: Path, input_file: Path) -> None: pass


class BaseLanguage(ILanguage, ABC):

    def compile_debug(self, src: Path, output: Path):
        self.compile(src, output)

    def run(self, executable: Path, input_file: Path) -> None:
        """Default run step: just execute the compiled binary directly,
        feeding it in.txt on stdin. Cpp/Rust use this as-is. Kotlin
        overrides it since it has to go through `java -jar` and inject
        an env var on debug runs."""
        print("========== output ==========")
        self._execute([str(executable)], input_file)

    def _build(self, command: list, output: Path) -> None:
        """Shared compile-step plumbing: every language was doing
        'mkdir output dir -> run compiler -> check_returncode' with only
        the command list differing, so that part now lives here once."""
        output.parent.mkdir(parents=True, exist_ok=True)
        subprocess.run(command, check=True).check_returncode()

    def _execute(self, command: list, input_file: Path, env: dict = None) -> None:
        """Shared run-step plumbing: open in.txt, pipe it to stdin,
        check_returncode. `env=None` makes subprocess.run inherit the
        normal environment, same as not passing env at all."""
        with open(input_file) as fin:
            subprocess.run(command, stdin=fin, env=env, check=True).check_returncode()