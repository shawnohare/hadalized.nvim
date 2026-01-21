gen:
    @echo "Generating templates"
    uv run --exact --directory=hadalized hadalized
    cp hadalized/build/neovim/* colors/

