//Setup all the global variables for the game...

globalvar
WOOD_DE, WOOD_RE, WOOD_LIMIT,           //Wood blocks
ROCK_DE, ROCK_RE, ROCK_LIMIT,           //Rock blocks
GLASS_DE, GLASS_RE, GLASS_LIMIT,        //Glass blocks
CAT_IS_BLACK;                           //Cat controller

/*
Now assign them some values following these rules:        
de is density
re is restitution (how bouncy)
limit is miminal speed of other object to cause damage
*/
   
GLASS_DE = 0.05;
GLASS_RE = 0.5;
GLASS_LIMIT = 0.5;    
    
WOOD_DE = 0.14;
WOOD_RE = 0.3;
WOOD_LIMIT = 0.7;

ROCK_DE = 1.5;
ROCK_RE = 0.01;
ROCK_LIMIT = 1;

//Initialise cat global var
CAT_IS_BLACK = false;
