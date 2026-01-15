from hadalized.base import BaseNode


class Node(BaseNode):
    x: int = 1


def test_replace():
    old = Node(x=1)
    new = old.replace(x=2)
    assert old.x == 1
    assert new.x == 2
