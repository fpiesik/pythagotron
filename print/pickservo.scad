include <configuration.scad>;

module pickservo_mount(){

height=6;
depth=roddia*3;
width=roddistance+roddia;
screwdia=3;
screwnumber=2; //one or two screws
screwdistance=10; //if two screws
servowidth=40.5;
servodepth=20.5;
servosupportX=8;
servosupportY=8;

cable_cutoutX=5;
cable_cutoutY=3;

offsetY=15;

rotate([0,0,0]){
difference(){
union(){


cube([width,depth,height],center=true);
translate([width/2,0,0]){
cylinder(d=depth,h=height,center=true);}
translate([-width/2,0,0]){
cylinder(d=depth,h=height,center=true);}
translate([0,offsetY,0]){
cube([servodepth+servosupportX*2,servowidth+servosupportY*2,height],center=true);
}}
translate([0,offsetY,0]){
cube([servodepth,servowidth,height+1],center=true);
cube([cable_cutoutX,servowidth+cable_cutoutY*2,height+1],center=true);

if (screwnumber==1){
translate([0,servowidth/2+servosupportY/2,0]){
cylinder(d=screwdia,h=height+1,center=true);}
translate([0,-(servowidth/2+servosupportY/2),0]){
cylinder(d=screwdia,h=height+1,center=true);}
}

if (screwnumber==2){
translate([screwdistance/2,0,0]){
translate([0,servowidth/2+servosupportY/2,0]){
cylinder(d=screwdia,h=height+1,center=true);}
translate([0,-(servowidth/2+servosupportY/2),0]){
cylinder(d=screwdia,h=height+1,center=true);}
}
translate([-screwdistance/2,0,0]){
translate([0,servowidth/2+servosupportY/2,0]){
cylinder(d=screwdia,h=height+1,center=true);}
translate([0,-(servowidth/2+servosupportY/2),0]){
cylinder(d=screwdia,h=height+1,center=true);}
}
}

}

translate([0,depth/2-roddia,0]){
translate([roddistance/2,0,0]){
cylinder(d=roddia,h=height+1,center=true);}
translate([-roddistance/2,0,0]){
cylinder(d=roddia,h=height+1,center=true);}

translate([roddistance/2,-depth/2,0]){
cube([roddia,depth,roddia],center=true);}
translate([-roddistance/2,-depth/2,0]){
cube([roddia,depth,roddia],center=true);}
}

}

}
}
//servo_mount();