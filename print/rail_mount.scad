include <configuration.scad>;

module rail_mount(){

height=9;
depth=roddia*2;
width=roddistance+roddia;



supportX=12;
supportY=8;

cutoutX=45;
cutoutY=15;


offsetY=0;

rotate([0,0,0]){
difference(){
union(){

//--------------------------
cube([width,depth,height],center=true);
translate([width/2,0,0]){
cylinder(d=depth,h=height,center=true);}
translate([-width/2,0,0]){
cylinder(d=depth,h=height,center=true);}

translate([0,-raildistance/2,0]){
cube([cutoutX+supportX*2,raildistance+supportY,height],center=true);
translate([0,-raildistance/2,0]){
cylinder(d=raildia*2,h=height,center=true);}
}}
translate([0,-raildistance,height/2]){
cylinder(d=raildia,h=height,center=true);}


translate([0,0,height/2]){
cylinder(d=raildia,h=height,center=true);}

translate([0,-cutoutY/2-depth/2,0]){
cube([cutoutX,cutoutY,height+1],center=true);}

translate([roddistance/2,0,0]){
cylinder(d=roddia,h=height+1,center=true);}
translate([-roddistance/2,0,0]){
cylinder(d=roddia,h=height+1,center=true);}

translate([roddistance/2,roddia,0]){
cube([roddia,depth,roddia],center=true);}
translate([-roddistance/2,roddia,0]){
cube([roddia,depth,roddia],center=true);}


}

}
}
//rail_mount();