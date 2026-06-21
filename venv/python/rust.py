#!/usr/bin/env python3

from pathlib import Path

from base import BaseLanguage


class RustLanguage(BaseLanguage):

    @property
    def extension(self):
        return "rs"

    @property
    def template_name(self):
        return "Template.rs"

    def compile(self, src: Path, output: Path):
        self._build(["rustc", "-o", str(output), str(src)], output)