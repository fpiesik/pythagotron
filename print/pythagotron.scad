include <configuration.scad>;

include <spacer.scad>;
include <damper.scad>;
include <endmounts.scad>;
include <pickup_mag.scad>;
include <pickservo.scad>;
include <kickup.scad>;
include <pcb_mount.scad>;
include <stepper_mount.scad>;
include <pulley_mount.scad>;
include <rail_mount.scad>;
include <stringshorter.scad>;
include <endstop_mount.scad>;
include <piezo_pickup.scad>;
include <pick.scad>;
include <stand.scad>;



module rods(){
    
color([0.5,0.5,0.5]){
    translate([roddistance/2,0,0])cylinder(d=roddia, h=height);
    translate([-roddistance/2,0,0])cylinder(d=roddia, h=height);
    translate([0,-stringroddist/2,0])cylinder(d=tuneroddia, h=height);
    translate([0,stringroddist/2,0])cylinder(d=stringdia, h=height);
    }
}



module rails(){
    
  color([0.8,0.8,0.8]){
    translate([0,0,0])cylinder(d=raildia, h=railZ);
    translate([0,-raildistance,0])cylinder(d=raildia, h=railZ);
  }  
}

color(basecolor){
screed(2);
translate([0,0,150])pickservo_mount();
translate([0,0,300])pcb_mount(1);
translate([0,0,450])steppermountA();
translate([0,0,750])pulleymount();
translate([0,0,height-50])screed(1);


translate([0,0,355])spacer();

    }
rods();
translate([0,0,100])kickup(1);
translate([0,0,40])piezo_pickup(1);
  color(actcolor){
translate([0,0,height-50-pivotdia/4])pivot();
translate([0,-stringroddist/2,height-50+screedheight+pivotdia/4])rotate([180,0,0])tunerodfix();



}


translate([0,0,480]){
color(basecolor){
rail_mount();
translate([0,0,railZ])rotate([0,180,0])rail_mount();}
color(railcolor)rails();}


translate([0,0,250])damper(1);

translate([0,-raildistance/2,550])stringshorter(1);

color([0.5,0.5,0.5])stand();


/*
screed(2);

spacer();
tunerodfix();
coil();
coilmount();
servomount();
kickupmount();
pcbmountA();
pcbmountB();
steppermountA();
steppermountB();
!pulleymount();
railmount();
carriage();
bottleneck();
stringshorterA();
stringshorterB();
endstopmount();
piezomount();
piezoramp();
piezoplate();
pick();

*/
