draw_set_alpha(1)
draw_set_color(c_white)
draw_sprite(sprXPText, 0, 8*argument0+1+argument4, 8*argument1-1+argument5)
draw_sprite(sprXPText, 1, 8*(argument0+1)+1+argument4, 8*argument1-1+argument5)

for(i=0; i<=19; i+=1)
{
    draw_sprite(sprXPBack, 0, 8*(argument0+2)+1+2*i+argument4, 8*argument1+1+argument5)
}
draw_set_color(make_color_rgb(0,164,210))
draw_set_alpha(0.8)
if argument2>0 then draw_rectangle(8*(argument0+2)+1+argument4, 8*argument1+1+argument5, (8*(argument0+2)+1)+argument2/argument3*39+argument4, 8*argument1+4+argument5,false)
draw_set_color(c_black)

draw_set_alpha(0.2)
draw_rectangle_color(8*(argument0+2)+1+argument4, 8*argument1+1+argument5, 8*(argument0+7)+argument4, 8*argument1+2+argument5, c_black, c_black, c_gray, c_gray, false)
draw_set_alpha(1)
