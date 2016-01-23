include <configuration.scad>;



module stand(type){
height=4;
distX=200;
distY=250;
Yoffset=30;
screw_dia=8.3;
thickfactor=2;

    tunerodholelength=pivotdia;
    screedholelength=15;
translate([0,0,-height/2]){
difference(){
union(){
hull(){
translate([roddistance/2,0,0]){
cylinder(d=screedholelength+roddia*2*thickfactor,h=height,center=true);}
translate([distX/2,distY/2+Yoffset,0]){
cylinder(d=screedholelength+screw_dia,h=height,center=true);}
}
hull(){
translate([roddistance/2,0,0]){
cylinder(d=screedholelength+roddia*2*thickfactor,h=height,center=true);}
translate([distX/2,-distY/2+Yoffset,0]){
cylinder(d=screedholelength+screw_dia,h=height,center=true);}
}
hull(){
translate([-roddistance/2,0,0]){
cylinder(d=screedholelength+roddia*2*thickfactor,h=height,center=true);}
translate([-distX/2,distY/2+Yoffset,0]){
cylinder(d=screedholelength++screw_dia,h=height,center=true);}
}
hull(){
translate([-roddistance/2,0,0]){
cylinder(d=screedholelength+roddia*2*thickfactor,h=height,center=true);}
translate([-distX/2,-distY/2+Yoffset,0]){
cylinder(d=screedholelength+screw_dia,h=height,center=true);}
}
hull(){
translate([roddistance/2,0,0]){
cylinder(d=screedholelength+roddia*2,h=height,center=true);}
translate([-roddistance/2,0,0]){
cylinder(d=screedholelength+roddia*2,h=height,center=true);}
}
}
//translate([-roddistance/2,0,0]){
//cylinder(d=screedholelength+roddia*2,h=height,center=true);}


translate([roddistance/2,0,0]){
cylinder(d=roddia,h=height,center=true);}
translate([-roddistance/2,0,0]){
cylinder(d=roddia,h=height,center=true);}

translate([distX/2,distY/2+Yoffset,0]){
cylinder(d=screw_dia,h=height,center=true);}
translate([-distX/2,distY/2+Yoffset,0]){
cylinder(d=screw_dia,h=height,center=true);}
translate([-distX/2,-distY/2+Yoffset,0]){
cylinder(d=screw_dia,h=height,center=true);}
translate([distX/2,-distY/2+Yoffset,0]){
cylinder(d=screw_dia,h=height,center=true);}

}




}
}



stand();

