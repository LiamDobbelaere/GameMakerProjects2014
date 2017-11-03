//draw_beam(x, y, width, height, outercol, innercol)
var rx, ry, rw, rh, ric, roc;
rx = argument0;
ry = argument1;
rw = argument2;
rh = argument3;
ric = argument5;
roc = argument4;

draw_rectangle_color(rx, ry-rh/2-4, rx+rw, ry+rh/2+4, ric, ric, ric, ric, false)
draw_rectangle_color(rx, ry-rh/2-3, rx+rw, ry+rh/2+3, c_white, c_white, c_white, c_white, false)
draw_rectangle_color(rx, ry-rh/2-1, rx+rw, ry+rh/2+1, ric, ric, ric, ric, false)
draw_rectangle_color(rx, ry-rh/2, rx+rw, ry, roc, roc, ric, ric, false)
draw_rectangle_color(rx, ry, rx+rw, ry+rh/2, ric, ric, roc, roc, false)
