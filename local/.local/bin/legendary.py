#!/bin/python

import os
games = os.popen("legendary list-installed")

games = games.read().replace("\n", "").split("*")
del games[0]

games_dict = {k.split("(")[0][1:-1]:
              n.replace(" ", "").replace("Appname:", "|").split("|")[:][1]
              for n, k in zip(games, games)}


keys = str(list(games_dict.keys())).replace("'", "")\
                                   .replace("[", "")\
                                   .replace("]", "")\
                                   .replace(", ", "\n")
cmd = "echo '"+keys+"' | dmenu -i -p 'Which game to launch?'"
game = games_dict[os.popen(cmd).read().replace('\n', '')]

os.system(f"legendary launch {game}")
