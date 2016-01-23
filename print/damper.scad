
include <configuration.scad>;
include <extra/bolt_nut.scad>;
include <extra/bearing.scad>;
include <extra/nema.scad>;
include <extra/legopulley.scad>;

module damper(orientation){

height=10;
depth=roddia*3;
width=roddistance+roddia;

string_dist=stringroddist/2;


mount_holeX=3.5;
mount_holeY=125;

stepperwidth=35.5; //nema14=35.5 
plateY=70;

armX=17;

centerhole=24; //stepper mount
screwdia=3.5;
nutdia=6.5;
nutsink=2;
screwdistance=26; //nema14=26

socketZ=8;
socketY=9;
socketX_pos=17; //set the X offset off the arm socket
stepperX_pos=24; //set the X offset stepper
step_supportX=2.5;
step_supportYZ=4;
     
mount_width=stepperX_pos*2+armX*2;

servoY=14.5;
servoZ=28;
servoX=armX;

bearing_armX=7;
bearing_armY=30;
bearing_armZ=15;
bearing_arm_axis_dia=5.3;

cutoutX=stepperX_pos*2;
cutoutY=plateY+1;

dimX=servoX;
dimY=servoY;
dimZ=socketZ+bearing_armZ/2+1;
axis_dia=bearing_arm_axis_dia;


module base(){
rotate([0,0,0]){
difference(){
union(){


cube([width,depth,height],center=true);
translate([width/2,0,0]){
cylinder(d=depth,h=height,center=true);}
translate([-width/2,0,0]){
cylinder(d=depth,h=height,center=true);}
}


translate([0,depth/2-roddia,0]){
translate([roddistance/2,0,0]){
cylinder(d=roddia,h=height+1,center=true);}
translate([-roddistance/2,0,0]){
cylinder(d=roddia,h=height+1,center=true);}

translate([roddistance/2,-depth/2,0]){
cube([roddia,depth,height+1],center=true);}
translate([-roddistance/2,-depth/2,0]){
cube([roddia,depth,height+1],center=true);}
}

}

}

difference(){
translate([-socketX_pos,string_dist/2+plateY/2+depth/4,0])cube([armX,string_dist+plateY-depth/2,height],center=true);

translate([-socketX_pos,mount_holeY/2-mount_holeX-socketY/2,0])cube([mount_holeX,mount_holeY,height+1],center=true);
}   

difference(){
translate([stepperX_pos,string_dist/2+plateY/2+depth/4,0])cube([armX,string_dist+plateY-depth/2,height],center=true);      
translate([stepperX_pos,mount_holeY/2-mount_holeX-socketY/2,0])cube([mount_holeX,mount_holeY,height+1],center=true);
}  
    
    
}

module flag_step_mount(){


difference(){
    union(){
translate([0,0,step_supportYZ/2])cube([armX,stepperwidth+step_supportYZ*2,stepperwidth+step_supportYZ],center=true);
translate([0,0,-(stepperwidth-socketZ)/2])cube([armX,stepperwidth+step_supportYZ*2+socketY*2,socketZ],center=true);
    }
union(){
    translate([0,(stepperwidth+step_supportYZ*2+socketY)/2,-(stepperwidth+step_supportYZ)/2])cylinder(d=screwdia,h=socketZ+1);
    translate([0,(stepperwidth+step_supportYZ*2+socketY)/2,-(stepperwidth)/2+socketZ-nutsink])cylinder(d=nutdia,h=socketZ,$fn=6);  
   
    translate([0,-(stepperwidth+step_supportYZ*2+socketY)/2,-(stepperwidth+step_supportYZ)/2])cylinder(d=screwdia,h=socketZ+1); 
    translate([0,-(stepperwidth+step_supportYZ*2+socketY)/2,-(stepperwidth)/2+socketZ-nutsink])cylinder(d=nutdia,h=socketZ,$fn=6);  
translate([step_supportX,0,0]){

rotate([0,0,90]){


cube([stepperwidth,armX,stepperwidth+1],center=true);



translate([0,0,0]){
rotate([90,0,0]){
translate([screwdistance/2,screwdistance/2,0]){
cylinder(d=screwdia,h=depth*2,center=true);}
translate([-screwdistance/2,screwdistance/2,0]){
cylinder(d=screwdia,h=depth*2,center=true);}
translate([screwdistance/2,-screwdistance/2,0]){
cylinder(d=screwdia,h=depth*2,center=true);}
translate([-screwdistance/2,-screwdistance/2,0]){
cylinder(d=screwdia,h=depth*2,center=true);}
cylinder(d=centerhole,h=depth*2,center=true);
}
}

}
}
}
}
}




module flag_bearing_arm(){
height=bearing_armZ;
mountX=bearing_armX;
mountY=bearing_armY;
bolt_dia=8.3;
axis_dia=bearing_arm_axis_dia;
screwdia=3;
servo_shaft_dia=5.9;
bearing_shaftX=5;
bearing_spacer_dia=10;
bearing_spacerX=0.5;

rotate([90,0,0]){
translate([0,mountY/2,0]){

difference(){
union(){
cube([mountX,mountY,height],center=true);

translate([0,-mountY/2,0])rotate([0,90,0])cylinder(d=height,h=mountX,center=true);
translate([0,mountY/2,0])rotate([0,90,0])cylinder(d=height,h=mountX,center=true);
    



}
translate([0,-mountY/2,0])rotate([0,90,0])cylinder(d=axis_dia,h=bearing_shaftX*4,center=true);
translate([0,mountY/2,0])rotate([0,90,0])cylinder(d=bolt_dia,h=bearing_shaftX*4,center=true);

translate([-mountX/2,mountY/2-bolt_dia,0])rotate([0,90,0])cylinder(d=screwdia,h=mountX*2+1,center=true);

}
}

    
}
}
module flag_bearing_socket(){
    
    cutoutX=bearing_armX+0.5;
    

difference(){
    union(){
translate([0,0,0])cube([dimX,dimY,dimZ],center=true);
translate([0,0,-(dimZ-socketZ)/2])cube([dimX,dimY+socketY*2,socketZ],center=true);
translate([-dimX/2,0,dimZ/2])rotate([0,90,0])cylinder(d=dimY,h=dimX); 
         
    }
union(){
    translate([0,(dimY+socketY)/2,-(dimZ+step_supportYZ)/2])cylinder(d=screwdia,h=socketZ+1);
    translate([0,(dimY+socketY)/2,-(dimZ)/2+socketZ-nutsink])cylinder(d=nutdia,h=socketZ,$fn=6);  
   
    translate([0,-(dimY+socketY)/2,-(dimZ+step_supportYZ)/2])cylinder(d=screwdia,h=socketZ+1); 
    translate([0,-(dimY+socketY)/2,-(dimZ)/2+socketZ-nutsink])cylinder(d=nutdia,h=socketZ,$fn=6); 
  

translate([0,0,socketZ+dimX/4])cube([cutoutX,dimY,dimZ+dimX/2],center=true);

translate([-dimX/2-0.5,0,dimZ/2])rotate([0,90,0])cylinder(d=axis_dia,h=dimX+1); 




}

}

}


width_in_studs  = 1;
teeth=48;
length= 170;
brick_height=7;
pocketZ=3.5;
screw_dia=3.5;
screw_posX=165;
screw_dist=6;
wall_thickness= 2.5;

filz_mountX=18;
filz_dia=24;
filz_width=25;

  
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

module linear_gear(){


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
  translate([0,-brick_width/2,-brick_height/2]){
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



}

color(actcolor)rack();
   
}

module filz_mount(){
    
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

if(orientation==1){
color(basecolor)base();
translate([stepperX_pos,string_dist+plateY/2,stepperwidth/2+height/2])color(actcolor)flag_step_mount();
translate([stepperX_pos,string_dist+plateY/2,stepperwidth/2+height/2]){
translate([-20,0,0])rotate([0,0,90])nema14(30);
color(basecolor)translate([-7,0,0])rotate([0,-90,0])legopulley();
}    
translate([-socketX_pos,string_dist,dimZ/2+height/2]){
color(actcolor)flag_bearing_socket();

translate([0,0,dimZ-bearing_armZ/2]){
color(actcolor)rotate([-30,0,0])flag_bearing_arm();
translate([-12,0,0])rotate([0,90,0]) bolt(5,20);
rotate([-30,0,0])rotate([0,-90,0])translate([bearing_armY,0,0]){ 
 translate([0,0,-30])   bolt(8,30);
translate([0,0,-socketX_pos])bearing(8,22,7);
  
    }}}

//flag_servo_mount();
//flag_servo_bearing();
//flag_bearing_arm();

translate([0,string_dist+25,60])rotate([0,95,90]){
linear_gear();
color(basecolor)translate([screw_posX-wall_thickness,0,0 ])filz_mount(); 
}  
}


if(orientation==2){

color(basecolor)base();

}

if(orientation==3){
color(actcolor)translate([0,0,0])rotate([0,-90,0])flag_step_mount();
color(actcolor)translate([40,0,0])flag_bearing_socket();    
color(actcolor)translate([-40,0,0])rotate([0,90,90])flag_bearing_arm();
color(actcolor)translate([-20,55,0])rotate([0,0,0])filz_mount();
}
if(orientation==4){
rotate([90,0,0])linear_gear();
}
 }   
    
//damper(1);
