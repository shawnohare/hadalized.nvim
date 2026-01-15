from hadalized.config import Config, TerminalConfig


def test_config_methods():
    conf = Config()
    assert conf.builds
    assert conf.palettes
    assert conf.hex()
    assert conf.css()


# @pytest.mark.parametrize(
#         "idx",
#         list(range(1,17))
# )
def test_terminal_config_ansi():
    conf: TerminalConfig = TerminalConfig()
    for idx in range(1, 7):
        assert conf.ansi.get_name(idx)
        assert conf.ansi.get_name(idx + 8)
    assert len(conf.ansi.pairing) == 6
