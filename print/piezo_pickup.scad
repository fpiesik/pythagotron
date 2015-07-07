include <configuration.scad>;
include <bolt_nut.scad>;

piezodia=27.5;
piezosupport=2;
piezosink=2;
plate_height=20;
screwdia=4.5;
screwsink=8;
ramp_balldia=20;

mount_height=12;

mount_depth=roddia*3;


module piezoplate(){

difference(){
cylinder(d2=piezodia+piezosupport*2,d1=piezodia/2,h=plate_height);
translate([0,0,plate_height-piezosink]){
cylinder(d=piezodia,h=plate_height);}
translate([0,0,-plate_height+screwsink]){
cylinder(d=screwdia,h=plate_height);}
}
}

module piezoramp(){

piezosupport=2;
piezosink=2;
screwsink=5;
width=10;
spread=6;


translate([0,spread/2,0]){
difference(){
sphere(d=ramp_balldia);
translate([0,0,-ramp_balldia/2]){
cube([ramp_balldia*2,ramp_balldia*2,ramp_balldia],center=true);}
translate([ramp_balldia/2+width/2,0,0]){
cube([ramp_balldia,ramp_balldia,ramp_balldia],center=true);}
translate([-ramp_balldia/2-width/2,0,0]){
cube([ramp_balldia,ramp_balldia,ramp_balldia],center=true);}
}}
translate([0,-spread/2,0]){
difference(){
sphere(d=ramp_balldia);
translate([0,0,-ramp_balldia/2]){
cube([ramp_balldia*2,ramp_balldia*2,ramp_balldia],center=true);}
translate([ramp_balldia/2+width/2,0,0]){
cube([ramp_balldia,ramp_balldia,ramp_balldia],center=true);}
translate([-ramp_balldia/2-width/2,0,0]){
cube([ramp_balldia,ramp_balldia,ramp_balldia],center=true);}
}}

}

module piezomount(){

height=mount_height;

width=roddistance+roddia;
screwdia=4;
nutdia=8.3;
nutsink=3;
piezowidth=15;
offset=7.5;
jackmountheight=3;
jackmountwidth=25;
jackmountlength=20;
jackmountoffset=width/2-jackmountwidth/2;
jackdia=10;
rotate([0,0,0]){
difference(){
union(){

//jackmount

difference(){
union(){
translate([jackmountoffset,-jackmountlength/2-mount_depth/2,jackmountheight/2-height/2]){
cube([jackmountwidth,jackmountlength,jackmountheight],center=true);
translate([0,-jackmountlength/2,0]){
cylinder(d=jackmountwidth,h=jackmountheight,center=true);}}}
translate([jackmountoffset,-jackmountlength/2-mount_depth/2,jackmountheight/2-height/2]){
translate([0,-jackmountwidth/2,0]){
cylinder(d=jackdia,h=jackmountheight+1,center=true);}}}

//--------------------------
cube([width,mount_depth,height],center=true);
translate([width/2,0,0]){
cylinder(d=mount_depth,h=height,center=true);}
translate([-width/2,0,0]){
cylinder(d=mount_depth,h=height,center=true);}
}
translate([roddistance/2,-roddia/2,0]){
cylinder(d=roddia,h=height+1,center=true);}
translate([-roddistance/2,-roddia/2,0]){
cylinder(d=roddia,h=height+1,center=true);}
rotate([90,0,0]){
cylinder(d=screwdia,h=mount_depth+1,center=true);
translate([0,0,-mount_depth+nutsink]){
cylinder(d=nutdia,h=mount_depth,center=true,$fn=6);}}

translate([0,-mount_depth/2+offset,0]){
cube([piezowidth+2,mount_depth,height+1],center=true);}

translate([roddistance/2,roddia,0]){
cube([roddia,mount_depth,height+1],center=true);}
translate([-roddistance/2,roddia,0]){
cube([roddia,mount_depth,height+1],center=true);}


}

}
}

module piezo_pickup(orientation){

if(orientation==1){    
translate([0,stringroddist/2-plate_height-ramp_balldia/2,0]){
rotate([-90,0,0]){
color(actcolor)piezoplate();
translate([0,0,plate_height]){
rotate([0,0,90]){
color(basecolor)piezoramp();}}}}
color(basecolor)piezomount();

translate([0,35,0])rotate([90,0,0])bolt(4,40);
translate([0,mount_depth/2,0])rotate([90,0,0])nut(4);
}

if(orientation==2){    

translate([0,40,0])color(actcolor)piezoplate();
translate([30,40,0])rotate([0,0,90])color(basecolor)piezoramp();
translate([0,0,mount_height/2])color(basecolor)piezomount();

translate([0,35,0])rotate([90,0,0])bolt(4,40);
translate([0,mount_depth/2,0])rotate([90,0,0])nut(4);
}

}

//piezo_pickup(2);