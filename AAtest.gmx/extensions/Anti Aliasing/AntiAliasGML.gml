#define aa_init
/*
Initializes the anti-aliasing sprites. Call before using any AA script.
*/

globalvar aa_on, aa_surf, aa_width, aa_sprite,
    aa_arrow_ang, aa_arrow_sec, aa_arrow_tan,
    aa_circle_prec, aa_circle_x, aa_circle_y, aa_circle_dist, aa_circle_angle;

aa_on = 1;
aa_width = 10;

aa_set_arrow_angle(20);
aa_draw_set_circle_precision(32);

var i;
aa_surf = surface_create(4,2+aa_width);
surface_set_target(aa_surf);
draw_clear(c_black);

i = 0;
repeat aa_width {
    draw_point_color(0,1+i,c_white);
    draw_point_color(2,1+i,c_white);
    
    aa_sprite[i+1,0] = sprite_create_from_surface(aa_surf,0,0,1,3+i,false,true,false,true,0,1+i/2);
    aa_sprite[i+1,1] = sprite_create_from_surface(aa_surf,1,0,2,3+i,false,true,false,true,0,1+i/2);
    aa_sprite[i+1,2] = sprite_create_from_surface(aa_surf,0,0,2,3+i,false,true,false,true,0,1+i/2);   
    aa_sprite[i+1,3] = sprite_create_from_surface(aa_surf,0,0,3,3+i,false,true,false,true,0,1+i/2);
    aa_sprite[i+1,4] = sprite_create_from_surface(aa_surf,1,0,3,3+i,false,true,false,true,0,1+i/2);
    
    i += 1;
    }

surface_reset_target();

texture_set_interpolation(true);
#define aa_surf_ext
/*
Internal. Adds more range to the sprite widths.

args:
0 new max width
*/

var surf, i;
surf = surface_create(4,2+argument0);
surface_set_target(surf);
draw_clear(c_black);
surface_copy_part(surf,0,0,aa_surf,0,0,4,2+aa_width);
surface_free(aa_surf);

i = aa_width;
repeat argument0-aa_width {
    draw_point_color(0,1+i,c_white);
    draw_point_color(2,1+i,c_white);
    
    aa_sprite[i+1,0] = sprite_create_from_surface(surf,0,0,1,3+i,false,true,false,true,0,1+i/2);
    aa_sprite[i+1,1] = sprite_create_from_surface(surf,1,0,2,3+i,false,true,false,true,0,1+i/2);
    aa_sprite[i+1,2] = sprite_create_from_surface(surf,0,0,2,3+i,false,true,false,true,0,1+i/2);   
    aa_sprite[i+1,3] = sprite_create_from_surface(surf,0,0,3,3+i,false,true,false,true,0,1+i/2);
    aa_sprite[i+1,4] = sprite_create_from_surface(surf,1,0,3,3+i,false,true,false,true,0,1+i/2);
    
    i += 1;
    }
    
surface_reset_target();

aa_surf = surf;
aa_width = argument0;
#define aa_set_on
/*
Sets whether to use anti aliasing.

args:
0 on or off
*/

aa_on = argument0;
#define aa_flip_on
/*
Flips whether to use anti aliasing.
*/

if aa_on
    aa_on = 0;
else
    aa_on = 1;
#define aa_set_arrow_angle
/*
Converts a new angle of the arrow point to usable form.

args:
0 angle
*/
var ang;

aa_arrow_ang = max(0.1,min(89.9,argument0));
ang = degtorad(aa_arrow_ang);
aa_arrow_sec = 1/cos(ang);
aa_arrow_tan = tan(ang);
#define aa_draw_set_circle_precision
/*
Sets the precision, or number or segments, with which circles are drawn. Must be between 4 and 64 and divisible by 4. Low precision looks bad with large circles.

args:
0 precision
*/

var i, ang;

aa_circle_prec = ceil(max(4,min(64,argument0))/4)*4;
    
aa_circle_angle = 360/aa_circle_prec;
aa_circle_dist = 2*sin(degtorad(aa_circle_angle/2));    

i = 0;
ang = 360/aa_circle_prec;

repeat aa_circle_prec+1 {
    aa_circle_x[i] = lengthdir_x(1,(i+0.5)*ang);
    aa_circle_y[i] = lengthdir_y(1,(i+0.5)*ang);
    i += 1;
    }
    
draw_set_circle_precision(aa_circle_prec*4);
#define aa_draw_line
/*
Draw an anti-aliased line between two points.

args:
0 x0
1 y0
2 x1
3 y1
*/

if aa_on
    draw_sprite_ext(aa_sprite[1,0],0,argument0,argument1,
        point_distance(argument0,argument1,argument2,argument3),1,
        point_direction(argument0,argument1,argument2,argument3),
        draw_get_color(),draw_get_alpha());    
else
    draw_line(argument0,argument1,argument2,argument3);
#define aa_draw_line_color
/*
Draw an anti-aliased, colored line between two points.

args:
0 x0
1 y0
2 x1
3 y1
4 c0
5 c1
*/

if aa_on {
    var dir;
    dir = point_direction(argument0,argument1,argument2,argument3);
    
    draw_sprite_general(aa_sprite[1,0],0,0,0,1,3,
        argument0+lengthdir_x(1,dir+90),
        argument1+lengthdir_y(1,dir+90),
        point_distance(argument0,argument1,argument2,argument3),1,dir,
        argument4,argument5,argument5,argument4,draw_get_alpha());
    }   
else
    draw_line_color(argument0,argument1,argument2,argument3,argument4,argument5);
#define aa_draw_line_width
/*
Draw an anti-aliased line between two points with width.

args:
0 x0
1 y0
2 x1
3 y1
4 width
*/

if aa_on {
    var w, dir;
    
    w = ceil(argument4);
    if w > aa_width
        aa_surf_ext(w);
    
    dir = point_direction(argument0,argument1,argument2,argument3);

    draw_sprite_ext(aa_sprite[w,0],0,
        argument0+lengthdir_x(0.5*argument4/w,dir+90),
        argument1+lengthdir_y(0.5*argument4/w,dir+90),
        point_distance(argument0,argument1,argument2,argument3),
        argument4/w,dir,draw_get_color(),draw_get_alpha());
    }
else 
    draw_line_width(argument0,argument1,argument2,argument3,argument6);


#define aa_draw_line_width_color
/*
Draw an anti-aliased, colored line between two points with width.

args:
0 x0
1 y0
2 x1
3 y1
4 w
5 c0
6 c1
*/

if aa_on {
    var w, dir;
    
    w = ceil(argument4);
    if w > aa_width
        aa_surf_ext(w);
        
    dir = point_direction(argument0,argument1,argument2,argument3);
    
    draw_sprite_general(aa_sprite[w,0],0,0,0,1,2+w,
        argument0+lengthdir_x(0.5*argument4,dir+90),
        argument1+lengthdir_y(0.5*argument4,dir+90),
        point_distance(argument0,argument1,argument2,argument3),argument4/w,dir,
        argument5,argument6,argument6,argument5,draw_get_alpha());
    }   
else
    draw_line_color(argument0,argument1,argument2,argument3,argument4,argument5);
#define aa_draw_line_ext
/*
Draw an anti-aliased line between two points, with optional feathering % and fading.

args:
0 x0
1 y0
2 x1
3 y1
4 color
5 alpha
6 width
7 feather % (optional)
8 line fade type (optional)
*/

if aa_on {
    var w, dir;
    
    w = min(ceil(argument6),1/max(0.01,argument7));
    if w > aa_width
        aa_surf_ext(w);
    
    dir = point_direction(argument0,argument1,argument2,argument3);

    draw_sprite_ext(aa_sprite[w,argument8],0,
        argument0+lengthdir_x(0.5*argument6/w,dir+90),
        argument1+lengthdir_y(0.5*argument6/w,dir+90),
        point_distance(argument0,argument1,argument2,argument3),
        argument6/w,
        dir,
        argument4,argument5);
    }
else 
    draw_line_width_color(argument0,argument1,argument2,argument3,argument6,argument4,argument4);


#define aa_draw_line_polar
/*
Draw an anti-aliased line between of the given length and direction.

args:
0 x
1 y
2 length
3 direction
*/

if aa_on
    draw_sprite_ext(aa_sprite[1,0],0,argument0,argument1,argument2,1,argument3,draw_get_color(),draw_get_alpha());    
else
    draw_line(argument0,argument1,argument0+lengthdir_x(argument2,argument3),argument1+lengthdir_y(argument2,argument3));
#define aa_draw_line_polar_color
/*
Draw an anti-aliased, colored line of given length and direction.

args:
0 x
1 y
2 length
3 direction
5 c0
6 c1
*/

if aa_on   
    draw_sprite_general(aa_sprite[1,0],0,0,0,1,2+1,
        argument0+lengthdir_x(1,argument3+90),
        argument1+lengthdir_y(1,argument3+90),
        argument2,1,argument3,
        argument4,argument5,argument5,argument4,draw_get_alpha());
else 
    draw_line_color(argument0,argument1,argument0+lengthdir_x(argument2,argument3),argument1+lengthdir_y(argument2,argument3),argument4,argument5);


#define aa_draw_line_polar_width
/*
Draw an anti-aliased line of a given length, width, and direction.

args:
0 x
1 y
2 length
3 direction
4 width
*/

if aa_on {
    var w;
    
    w = ceil(argument4);
    if w > aa_width
        aa_surf_ext(w);

    draw_sprite_ext(aa_sprite[w,0],0,
        argument0+lengthdir_x(0.5*argument4/w,argument3+90),
        argument1+lengthdir_y(0.5*argument4/w,argument3+90),
        argument2,argument4/w,argument3,draw_get_color(),draw_get_alpha());
    }
else 
    draw_line_width(argument0,argument1,argument0+lengthdir_x(argument2,argument3),argument1+lengthdir_y(argument2,argument3),argument4);


#define aa_draw_line_polar_width_color
/*
Draw an anti-aliased, colored line of a given length, width, and direction.

args:
0 x
1 y
2 length
3 direction
4 width
5 c0
6 c1
*/

if aa_on {
    var w;
    
    w = ceil(argument4);
    if w > aa_width
        aa_surf_ext(w);
        
    draw_sprite_general(aa_sprite[w,0],0,0,0,1,2+w,
        argument0+lengthdir_x(0.5*argument4,argument3+90),
        argument1+lengthdir_y(0.5*argument4,argument3+90),
        argument2,argument4/w,argument3,
        argument5,argument6,argument6,argument5,draw_get_alpha());
    }
else 
    draw_line_width_color(argument0,argument1,argument0+lengthdir_x(argument2,argument3),argument1+lengthdir_y(argument2,argument3),argument4,argument5,argument6);


#define aa_draw_line_polar_ext
/*
Draw an anti-aliased line between of the given length and direction, with optional feathering % and fading.

args:
0 x
1 y
2 length
3 direction
4 color
5 alpha
6 width
7 feather % (optional)
8 line fade type (optional)
*/

if aa_on {
    var w;
    
    w = min(ceil(argument6),1/max(0.01,argument7));
    if w > aa_width
        aa_surf_ext(w);

    draw_sprite_ext(aa_sprite[w,argument8],0,
        argument0+lengthdir_x(0.5*argument6/w,argument3+90),
        argument1+lengthdir_y(0.5*argument6/w,argument3+90),
        argument2,argument6/w,argument3,argument4,argument5);
    }
else 
    draw_line_width_color(argument0,argument1,argument0+lengthdir_x(argument2,argument3),argument1+lengthdir_y(argument2,argument3),argument6,argument4,argument4);


#define aa_draw_arrow
/*
Draw an anti-aliased arrow between two points of a given size, optionally outlined.

args:
0 x0
1 y0
2 x1
3 y1
4 size
5 outline
*/

if aa_on {
    var dir, d, d2, d3, xA, yA, col, alp;
    
    dir = point_direction(argument0,argument1,argument2,argument3);
    d = point_distance(argument0,argument1,argument2,argument3);
    d2 = min(d,argument4);
    d3 = d2*aa_arrow_tan;
    
    col = draw_get_color();
    alp = draw_get_alpha();
    
    d3d_transform_stack_push();
    d3d_transform_set_rotation_z(dir);
    d3d_transform_add_translation(argument0,argument1,0);
    
    if !argument5 {
        draw_triangle(d,0,d-d2,d3,d-d2,-d3,false);
        draw_sprite_ext(aa_sprite[1,0],0,d-d2,d3,d3*2,1,90,col,alp);
        
        if d != d2
            draw_sprite_ext(aa_sprite[1,0],0,0,0,d-d2,1,0,col,alp);
        }
    else
        draw_sprite_ext(aa_sprite[1,0],0,0,0,d,1,0,col,alp);
        
    draw_sprite_ext(aa_sprite[1,0],0,d,0,d2*aa_arrow_sec,1,180+aa_arrow_ang,col,alp);
    draw_sprite_ext(aa_sprite[1,0],0,d,0,d2*aa_arrow_sec,1,180-aa_arrow_ang,col,alp);
    
    d3d_transform_stack_pop();
    }
else
    draw_arrow(argument0,argument1,argument2,argument3,argument4);
#define aa_draw_arrow_polar
/*
Draw an anti-aliased arrow of a given size, length, and direction, optionally outlined.

args:
0 x
1 y
2 length
3 direction
4 size
5 outline
*/

if aa_on {
    var d, d2, d3, xA, yA, col, alp;
    
    d = argument2;
    d2 = min(d,argument4);
    d3 = d2*aa_arrow_tan;
    
    col = draw_get_color();
    alp = draw_get_alpha();
    
    d3d_transform_stack_push();
    d3d_transform_set_rotation_z(argument3);
    d3d_transform_add_translation(argument0,argument1,0);
    
    if !argument5 {
        draw_triangle(d,0,d-d2,d3,d-d2,-d3,false);
        draw_sprite_ext(aa_sprite[1,0],0,d-d2,d3,d3*2,1,90,col,alp);
        
        if d != d2
            draw_sprite_ext(aa_sprite[1,0],0,0,0,d-d2,1,0,col,alp);
        }
    else
        draw_sprite_ext(aa_sprite[1,0],0,0,0,d,1,0,col,alp);
        
    draw_sprite_ext(aa_sprite[1,0],0,d,0,d2*aa_arrow_sec,1,180+aa_arrow_ang,col,alp);
    draw_sprite_ext(aa_sprite[1,0],0,d,0,d2*aa_arrow_sec,1,180-aa_arrow_ang,col,alp);
    
    d3d_transform_stack_pop();
    }
else
    draw_arrow(argument0,argument1,argument0+lengthdir_x(argument2,argument3),argument1+lengthdir_y(argument2,argument3),argument4);
#define aa_draw_triangle
/*
Draw an anti-aliased triangle between three points.

args:
0 x0
1 y0
2 x1
3 y1
4 x2
5 y2
6 outline
*/

if aa_on {
    var col, alp;
    col = draw_get_color();
    alp = draw_get_alpha();
    
    if !argument6
        draw_triangle(argument0,argument1,argument2,argument3,argument4,argument5,0);
        
    draw_sprite_ext(aa_sprite[1,0],0,argument0,argument1,
        point_distance(argument0,argument1,argument2,argument3),1,
        point_direction(argument0,argument1,argument2,argument3),
        col,alp);
        
    draw_sprite_ext(aa_sprite[1,0],0,argument2,argument3,
        point_distance(argument2,argument3,argument4,argument5),1,
        point_direction(argument2,argument3,argument4,argument5),
        col,alp);
        
    draw_sprite_ext(aa_sprite[1,0],0,argument0,argument1,
        point_distance(argument0,argument1,argument4,argument5),1,
        point_direction(argument0,argument1,argument4,argument5),
        col,alp);
        
    }
    
else
    draw_triangle(argument0,argument1,argument2,argument3,argument4,argument5,argument6);
#define aa_draw_circle
/*
Draw an anti-aliased circle with a given center and radius, optionally outlined.

args:
0 x
1 y
2 radius
3 outline
*/

if aa_on {
    var i, col, alp;
    col = draw_get_color();
    alp = draw_get_alpha();
    
    if !argument3
        draw_circle(argument0,argument1,argument2,0);
    
    i = 0;
    repeat aa_circle_prec {
        draw_sprite_ext(aa_sprite[1,0],0,argument0+aa_circle_x[i]*argument2,argument1+aa_circle_y[i]*argument2,argument2*aa_circle_dist,1,(i+1)*aa_circle_angle+90,col,alp);

        i += 1;
        }
    }   
else
    draw_circle(argument0,argument1,argument2,argument3);
#define aa_draw_rectangle_ext
/*
Draw an anti-aliased rectangle with a given center, width, length, and rotation, and optionally outlined.

args:
0 x
1 y
2 width
3 height
4 outline
5 rotation
*/

var x1, y1;
x1 = -argument2/2;
y1 = -argument3/2;

d3d_transform_stack_push();
d3d_transform_set_rotation_z(argument5);
d3d_transform_add_translation(argument0,argument1,0);

if aa_on {
    var col, alp;
    col = draw_get_color();
    alp = draw_get_alpha();
    
    if !argument4
        draw_rectangle(x1,y1,x1+argument2,y1+argument3,0);
        
    draw_sprite_ext(aa_sprite[1,0],0,x1,y1,argument2,1,0,col,alp);
    draw_sprite_ext(aa_sprite[1,0],0,x1,-y1,argument2,1,0,col,alp);
    draw_sprite_ext(aa_sprite[1,0],0,x1,y1,argument3,1,270,col,alp);
    draw_sprite_ext(aa_sprite[1,0],0,-x1,y1,argument3,1,270,col,alp);
    
    }
else
    draw_rectangle(x1,y1,x1+argument2,y1+argument3,argument4);
    
d3d_transform_stack_pop();
#define aa_draw_path
/*
Draws an antialiased path.

args:
0 path
1 x
2 y
3 absolute
*/

if aa_on {
    var i, num, col, alp, x0, y0, x1, y1;
    col = draw_get_color();
    alp = draw_get_alpha();
    i = 0;
    x1 = path_get_point_x(argument0,0);
    y1 = path_get_point_y(argument0,0);
    
    num = path_get_number(argument0)-1;
    
    d3d_transform_stack_push();
    if !argument3
        d3d_transform_set_translation(-x1+argument1,-y1+argument2,0); 
        
    if path_get_kind(argument0) {
        inc = 1/round(num*path_get_precision(argument0) + 1);
        
        repeat 1/inc {
            i += inc;
            x0 = x1;
            y0 = y1;
            x1 = path_get_x(argument0,i);
            y1 = path_get_y(argument0,i);
            draw_sprite_ext(aa_sprite[1,0],0,x0,y0,
                point_distance(x0,y0,x1,y1),1,
                point_direction(x0,y0,x1,y1),
                col,alp);
            }
        }
    else {
        repeat num {
            i += 1;
            x0 = x1;
            y0 = y1;
            x1 = path_get_point_x(argument0,i);
            y1 = path_get_point_y(argument0,i);
            draw_sprite_ext(aa_sprite[1,0],0,x0,y0,
                point_distance(x0,y0,x1,y1),1,
                point_direction(x0,y0,x1,y1),
                col,alp);
            }
        }
        
    d3d_transform_stack_pop();
    }
else
    draw_path(argument0,argument1,argument2,argument3);
