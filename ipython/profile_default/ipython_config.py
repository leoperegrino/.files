import os
cache = os.environ.get('XDG_CACHE_HOME', os.path.expanduser('~/.cache'))

c.TerminalIPythonApp.display_banner = False
c.TerminalInteractiveShell.confirm_exit = False
c.TerminalInteractiveShell.display_completions = 'column'
c.TerminalInteractiveShell.editing_mode = 'vi'
c.TerminalInteractiveShell.extra_open_editor_shortcuts = True
c.TerminalInteractiveShell.emacs_bindings_in_vi_insert_mode = False
c.TerminalInteractiveShell.space_for_menu = 20
c.TerminalInteractiveShell.debugger_history_file = f'{cache}/ipython/pdbhistory'
c.HistoryAccessor.hist_file = f'{cache}/ipython/history.sqlite'
c.Application.verbose_crash=True
c.InteractiveShell.autocall = 1
