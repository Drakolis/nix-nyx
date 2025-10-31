from ignis import widgets

widgets.Window(
    namespace="some-window",  # the name of the window (not title!)
    child=widgets.Label(  # we set widgets.Label as the child widget of the window
        label="Hello world!"  # define text here
    ),
)
