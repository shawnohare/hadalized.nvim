gen:
    @echo "Generating templates"
    uv run hadalized
    cp ./build/neovim/* colors/

venv:
    source .venv/bin/activate


wezterm:
    @echo "Copying wezterm files."
    cp ./build/wezterm/* ~/.config/wezterm/colors/

ed:
    source .venv/bin/activate && nvim src/hadalized/config.py

fmt:
    uv run ruff format src/ tests/
    uv run ruff check --fix src/ tests/
    # uv run ruff check --ignore=S --fix tests/

check:
    uv run ruff check src/ tests/
    uv run ty check src/ tests/

test:
    uv run pytest

clear_cache:
    uv run python bin/clear_cache.py
