from os.path import exists, expanduser
config.load_autoconfig()
config.source('qutebrowser-themes/themes/gruvbox.py')
LIGHT = exists(expanduser("~/.light"))
c.colors.webpage.preferred_color_scheme = 'light' if LIGHT else 'dark'

