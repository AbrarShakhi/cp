#!/usr/bin/env python3

import os
from pathlib import Path

from base import BaseLanguage


class KotlinLanguage(BaseLanguage):

    @property
    def extension(self):
        return "kt"

    @property
    def template_name(self):
        return "Template.kts"

    def compile(self, src: Path, output: Path):
        self._build(
            ["kotlinc", str(src), "-include-runtime", "-d", str(output)],
            output
        )
        self.debug = False

    def compile_debug(self, src: Path, output: Path):
        self.compile(src, output)
        self.debug = True

    def run(self, executable: Path, input_file: Path):
        env = os.environ.copy() if self.debug else None
        if self.debug:
            env["LOCAL"] = "1"
        self._execute(["java", "-jar", str(executable)], input_file, env=env)