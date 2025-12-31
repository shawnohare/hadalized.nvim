gen:
    uv run hadalized

wezterm:
    echo "Copying wezterm files."
    cp wezterm/* ~/.config/wezterm/colors/

ed:
    source .venv/bin/activate && nvim src/hadalized/config.py
