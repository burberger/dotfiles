#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = [
#   "tomli-w",
# ]
# ///
import argparse
import tomllib
import tomli_w
from pathlib import Path


def parse_args():
    parser = argparse.ArgumentParser(
        description="Swaps the theme in the alacritty config file"
    )
    parser.add_argument(
        "theme", nargs="?", default="gruvbox_dark", help="The theme to load"
    )
    parser.add_argument(
        "--list-themes", action="store_true", help="Lists all available themes"
    )

    return parser.parse_args()


def load_themes(path: Path):
    """
    Loads all themes located at the supplied path.

    Args:
        path (str): The path to the theme config files, must be toml formatted.

    Returns:
        dict: Dictionary of themes. Key is the theme name, value is a dictionary of the color configs.
    """
    theme_paths = path.glob("*.toml")
    themes = {}
    for theme_path in theme_paths:
        with open(theme_path, "rb") as f:
            themes[theme_path.stem] = tomllib.load(f)

    return themes


def print_themes(themes: dict):
    """
    Prints all themes in the supplied dict.

    Args:
        themes (dict): Dictionary of all loaded themes.
    """
    for k in themes.keys():
        print(k)


def main():
    # dotfiles installer links the full alacritty directory
    base_path = Path.home() / ".config/alacritty"
    themes_path = base_path / "themes"
    base_config_path = base_path / "base_config.toml"
    output_path = base_path / "alacritty.toml"

    args = parse_args()
    themes = load_themes(themes_path)

    if args.list_themes:
        print_themes(themes)
        return

    if args.theme not in themes:
        print(f"{args.theme} not found. Available themes:")
        print_themes(themes)
        return 1

    with open(base_config_path, "rb") as f:
        config = tomllib.load(f)
        config = config | themes[args.theme]

    with open(output_path, "wb") as f:
        tomli_w.dump(config, f)

    print(f"Wrote out {output_path} with theme {args.theme}")


if __name__ == "__main__":
    main()
