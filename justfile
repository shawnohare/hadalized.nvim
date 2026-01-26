gen:
    @echo "Generating templates"
    uv run --exact --directory=hadalized hadalized build neovim --out="../colors"

