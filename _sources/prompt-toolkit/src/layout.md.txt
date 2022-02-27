# layout

```{inheritance-diagram} prompt_toolkit.layout.containers.HSplit prompt_toolkit.layout.containers.VSplit
:private-bases:
:parts: 1
```

```{automodule} prompt_toolkit.layout.layout
:members:
:undoc-members:
:show-inheritance:
```

## Layout

`prompt_toolkit/layout/layout.py`

```py
class Layout:
    """
    The layout for a prompt_toolkit
    :class:`~prompt_toolkit.application.Application`.
    This also keeps track of which user control is focused.

    :param container: The "root" container for the layout.
    :param focused_element: element to be focused initially. (Can be anything
        the `focus` function accepts.)
    """

    def __init__(
        self,
        container: AnyContainer,
        focused_element: Optional[FocusableElement] = None,
    ) -> None:
```
