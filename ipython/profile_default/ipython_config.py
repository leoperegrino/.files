import os

state = os.environ.get(
    'XDG_STATE_HOME',
    os.path.expanduser('~/.local/state')
)

c.TerminalIPythonApp.display_banner = False
c.TerminalInteractiveShell.confirm_exit = False
c.TerminalInteractiveShell.display_completions = 'column'
c.TerminalInteractiveShell.editing_mode = 'vi'
c.TerminalInteractiveShell.extra_open_editor_shortcuts = True
c.TerminalInteractiveShell.emacs_bindings_in_vi_insert_mode = False
c.TerminalInteractiveShell.space_for_menu = 20
c.TerminalInteractiveShell.debugger_history_file = f'{state}/ipython/pdbhistory'
c.HistoryAccessor.hist_file = f'{state}/ipython/history.sqlite'
c.Application.verbose_crash=True
c.InteractiveShell.autocall = 1
