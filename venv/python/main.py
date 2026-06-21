import sys
from pathlib import Path

from base import BaseLanguage
from factory import LanguageFactory

DEBUG_FLAGS = ("-rd", "-dr")


def main(lang: BaseLanguage, root: str, src: str, mode: str):
    root_dir = Path(root)

    src_dir = root_dir / "src"
    template_dir = root_dir / "snippets"
    output_dir = root_dir / "target"
    input_file = root_dir / "in.txt"

    if lang.extension == 'rs':
        src_dir = src_dir / "bin"

    src_name = src_dir / f"{src}.{lang.extension}"
    output_name = output_dir / src

    if mode == "-c":
        lang.create(src_name, template_dir)
        return

    if mode == "-r":
        lang.compile(src_name, output_name)
    elif mode in DEBUG_FLAGS:
        lang.compile_debug(src_name, output_name)
    else:
        raise ValueError(
            f"Expected args: -c | -r | -rd | -dr. But got {mode}"
        )

    lang.run(output_name, input_file)


if __name__ == "__main__":
    argv = sys.argv[1:]
    if len(argv) != 4:
        raise ValueError(
            f"Got arguments (length: {len(argv)}): {' '.join(argv)}"
        )

    ext, root, mode, src = argv

    lang: BaseLanguage = LanguageFactory.create(ext)
    main(lang, root, src, mode)