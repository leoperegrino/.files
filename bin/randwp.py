import random
import os
#'/home/leop/pictures/wallpapers'

HOME = os.path.expandvars('$HOME')
FOLDER = os.path.join(HOME, 'pictures/wallpapers')
WPS = os.listdir(FOLDER)
wallpaper = random.choice(WPS)

os.system(f'feh --bg-fill  {FOLDER}/{wallpaper}')
