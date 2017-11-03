Sname = part_system_create() 
particle1 = part_type_create();
part_type_shape(particle1,pt_shape_cloud);
part_type_size(particle1,0.10,0.33,0,0);
part_type_scale(particle1,2.45,2.37);
part_type_color3(particle1,7692629,9738148,8221889);
part_type_alpha3(particle1,0.64,0.41,0.04);
part_type_speed(particle1,1.44,2.79,-0.03,0);
part_type_direction(particle1,0,359,-1,0);
part_type_orientation(particle1,0,0,0,0,1);
part_type_blend(particle1,1);
part_type_life(particle1,34,39);
emitter1 = part_emitter_create(Sname);
part_emitter_region(Sname,emitter1,x,x,y,y,ps_shape_ellipse,1);
part_emitter_burst(Sname,emitter1,particle1,5);
