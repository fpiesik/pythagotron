width_in_studs  = 1;
teeth=48;
length= 170;
brick_height=7;
pocketZ=3.5;
screw_dia=3.5;
screw_posX=165;
screw_dist=6;

filz_mountX=18;
filz_dia=24;
filz_width=21;

  
  brick_width         = 12;
  stud_diameter       = 4.88;
 
  tooth_base_width    = 2.3;
  tooth_tip_width     = 0.87;
  tooth_height        = 2.06;
  tooth_top           = 5.79;
  tooth_tip_radius    = 0.15;
  teeth_per_brick     = 3.1;
  half_pegs_per_brick = 2;
  gap_width           = 0.884;



module tooth() {
  $fn = 20;
  

  //render()
  x_a = -((tooth_tip_width/2) - tooth_tip_radius);
  x_b = (tooth_tip_width/2) - tooth_tip_radius;
  translate([(gap_width+tooth_base_width)/2,0,-tooth_height+brick_height])
  rotate([0,0,180])
  translate([0,-(brick_width * width_in_studs)/2,tooth_height]) {
    difference() {
      hull() {
        translate([x_a,0,tooth_height]) rotate([90,0,0]) cylinder(r=tooth_tip_radius,   h=(brick_width * width_in_studs), center=true);
        translate([x_b,0,tooth_height]) rotate([90,0,0]) cylinder(r=tooth_tip_radius,   h=(brick_width * width_in_studs), center=true);
        translate([0,0,0])              rotate([90,0,0]) cylinder(r=tooth_base_width/2, h=(brick_width * width_in_studs), center=true);
      }
      translate([0,0,-1]) cube(size=[gap_width + tooth_base_width, brick_width * width_in_studs + 1, 1.9], center=true);
    }
  }
}

module rack() {
   wall_thickness      = 2;
difference(){
union(){
  tooth_width = tooth_base_width + gap_width;
  
 
  for ( i = [0 : teeth-1]) {
    translate([i * (tooth_base_width + gap_width), 0, 0]) tooth();
  }

  difference() {
    cube(size=[(length), (brick_width * width_in_studs), brick_height]);
    translate([wall_thickness,wall_thickness,0]) cube(size=[length - (wall_thickness*2), (brick_width * width_in_studs) - (wall_thickness*2), pocketZ]);
    // shave a bit off the beginning and end of the brick
    translate([-1.98,-1,0]) cube(size=[2, (brick_width * width_in_studs)+2, 10]);
    translate([length - 0.02,-1,0]) cube(size=[2,length+2, 10]);
  }

 }

translate([screw_posX,brick_width/2,0])cylinder(d=screw_dia, h=brick_height+1,$fn=16);
translate([screw_posX-screw_dist,brick_width/2,0])cylinder(d=screw_dia, h=brick_height+1,$fn=16);
}
}

module filz_mount(){
    wall_thickness      = 2.5;
    tolerance=0.3;
    height=brick_height+wall_thickness;
    block_rackY=filz_dia/2+3*wall_thickness+screw_dia;
    block_filzX=filz_dia/2+3*wall_thickness+screw_dia;
    block_filzY=filz_width+2*wall_thickness;
difference(){    
union(){
difference(){
cube([filz_mountX,brick_width+2*wall_thickness+tolerance,height],center=true);
translate([0,0,wall_thickness])cube([filz_mountX,brick_width+tolerance,height],center=true);    
}
difference(){
translate([filz_mountX/2+ block_filzX/2,0,0])cube([block_filzX,block_filzY,brick_height+wall_thickness],center=true); 
translate([filz_mountX/2+ block_filzX/2+wall_thickness,0,0])cube([block_filzX,filz_width,brick_height+wall_thickness],center=true); 
    }
}
translate([screw_dist/2,0,0])cylinder(d=screw_dia, h=brick_height+wall_thickness+1,$fn=16,center=true);
translate([-screw_dist/2,0,0])cylinder(d=screw_dia, h=brick_height+wall_thickness+1,$fn=16,center=true);
translate([filz_mountX/2+block_filzX-screw_dia/2-wall_thickness,0,0])rotate([90,0,0])cylinder(d=screw_dia, h=filz_width+2*wall_thickness+1,$fn=16,center=true);
}
}

//rack();
filz_mount();
