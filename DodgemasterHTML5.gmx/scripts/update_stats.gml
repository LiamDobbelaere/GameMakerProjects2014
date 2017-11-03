ini_open("config.ini")
ini_write_real("Stats","hits",global.statsHits)
ini_write_real("Stats","games",global.statsGames)
ini_close();
