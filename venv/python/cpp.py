#!/usr/bin/env python3

from pathlib import Path

from base import BaseLanguage


class CppLanguage(BaseLanguage):

    @property
    def extension(self):
        return "cpp"

    @property
    def template_name(self):
        return "Template.cpp"

    def compile(self, src: Path, output: Path):
        self._build(
            ["g++", "-std=c++17", "-Wall", "-Wextra", "-o", str(output), str(src)],
            output
        )

    def compile_debug(self, src: Path, output: Path):
        self._build(
            ["g++", "-std=c++17", "-g", "-DLOCAL", "-DDEBUG",
             "-fsanitize=address,undefined", "-o", str(output), str(src)],
            output
        )