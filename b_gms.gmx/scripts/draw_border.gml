//draw_border(sprite, x, y, width, height, alpha)

/* /-\ */
draw_sprite_ext(argument0, 0, x+argument1*8, y+argument2*8, 1, 1, 0, c_white, argument5)
for(i=1; i<=argument3; i+=1)
{
    draw_sprite_ext(argument0, 4, x+i*8+argument1*8, y+argument2*8, 1, 1, 0, c_white, argument5)
    lasti = i+1
}
draw_sprite_ext(argument0, 1, x+lasti*8+argument1*8, y+argument2*8, 1, 1, 0, c_white, argument5)

/* |-| */
for(j=1; j<=argument4; j+=1)
{
    draw_sprite_ext(argument0, 6, x+argument1*8, y+j*8+argument2*8, 1, 1, 0, c_white, argument5)
    for(i=1; i<=argument3; i+=1)
    {
        draw_sprite_ext(argument0, 8, x+i*8+argument1*8, y+j*8+argument2*8, 1, 1, 0, c_white, argument5)
        lasti = i+1
    }
    draw_sprite_ext(argument0, 7, x+lasti*8+argument1*8, y+j*8+argument2*8, 1, 1, 0, c_white, argument5)
    lastj = j+1
}

/* \-/ */
draw_sprite_ext(argument0, 2, x+argument1*8, y+lastj*8+argument2*8, 1, 1, 0, c_white, argument5)
for(i=1; i<=argument3; i+=1)
{
    draw_sprite_ext(argument0, 5, x+i*8+argument1*8, y+lastj*8+argument2*8, 1, 1, 0, c_white, argument5)
    lasti = i+1
}
draw_sprite_ext(argument0, 3, x+lasti*8+argument1*8, y+lastj*8+argument2*8, 1, 1, 0, c_white, argument5)
