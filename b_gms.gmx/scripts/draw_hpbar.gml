hp_color = 0
hp_percent = round(argument2/argument3*100)

if hp_percent<=20 then hp_color = 2
else if hp_percent<=50 then hp_color = 1
else hp_color = 0

draw_set_alpha(1)
draw_set_color(c_white)
draw_sprite(sprHPText, 0, 8*argument0+argument4, 8*argument1-1+argument5)
draw_sprite(sprHPText, 1, 8*(argument0+1)+argument4, 8*argument1-1+argument5)

draw_sprite(sprHPBar, 3, 8*(argument0+2)+1+argument4, 8*argument1+1+argument5)
if hp_percent>0 then draw_sprite_part(sprHPBar, hp_color, 0, 0, hp_percent/100*42, 8, 8*(argument0+2)+1+argument4, 8*argument1+1+argument5)
draw_set_color(c_black)
draw_set_alpha(1)
