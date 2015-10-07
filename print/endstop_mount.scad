include <configuration.scad>

module endstopmountA(){
height=6;
depth=roddia*2;
width=roddistance+roddia;
screwdia=3;
screwdistance=9.5;
screwoffset=3;
rotate([0,0,0]){
difference(){
union(){

//--------------------------
cube([width,depth,height],center=true);
translate([width/2,0,0]){
cylinder(d=depth,h=height,center=true);}
translate([-width/2,0,0]){
cylinder(d=depth,h=height,center=true);}
}
translate([roddistance/2,0,0]){
cylinder(d=roddia,h=height+1,center=true);}
translate([-roddistance/2,0,0]){
cylinder(d=roddia,h=height+1,center=true);}
rotate([90,0,0]){
translate([screwdistance/2+screwoffset,0,0]){
cylinder(d=screwdia,h=depth+1,center=true);}
translate([-screwdistance/2+screwoffset,0,0]){
cylinder(d=screwdia,h=depth+1,center=true);}
}


translate([roddistance/2,roddia,0]){
cube([roddia,depth,roddia],center=true);}
translate([-roddistance/2,roddia,0]){
cube([roddia,depth,roddia],center=true);}


}

}

}

module endstopmountB(){
mountZ=1.5;
mountAY=stiffroddia*2;
mountBY=25;
swX=20;

difference(){
cube([screedwidth,mountAY,mountZ],center=true);
translate([screedwidth/2-stiffroddia,0,0]){
cylinder(d=stiffroddia,h=mountZ,center=true);
}
translate([-screedwidth/2+stiffroddia,0,0]){
cylinder(d=stiffroddia,h=mountZ,center=true);}
}
translate([(screedwidth-swX)/2,mountBY/2+mountAY/2,0])cube([swX,mountBY,mountZ],center=true);

}
//endstopmountA();
//endstopmountB();