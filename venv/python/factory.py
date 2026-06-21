from base import BaseLanguage
from cpp import CppLanguage
from kotlin import KotlinLanguage
from rust import RustLanguage


class LanguageFactory:

    @classmethod
    def create(clc, ext: str) -> BaseLanguage:
        match ext:
            case "cpp":
                return CppLanguage()
            case "rs":
                return RustLanguage()
            case "kt":
                return KotlinLanguage()
            case _:
                raise ValueError(f"Excepted Languages are: cpp|kt|rs. But got {ext}")