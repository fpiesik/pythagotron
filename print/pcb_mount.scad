include <configuration.scad>

pcbX=95;
pcbY=50;
pcbZ=4;


module pcb_mount(orientation){

module pcb_mountA(){

height=pcbX/3;
depth=roddia*1;
width=pcbY;
screwdia=4;
roddia=tuneroddia;

support=3;


rotate([0,0,0]){
difference(){
union(){

if(orientation==1){
translate([(pcbY/2-roddia+support),0,0]){
difference(){ 
union(){
translate([0,-roddia/2,0])cube([roddia*2,roddia,height],center=true);
cylinder(d=roddia*2,h=height,center=true);
 }
cylinder(d=roddia,h=height+1,center=true);
 }
}
}

if(orientation==2){
translate([-(pcbY/2-roddia+support),0,0]){
difference(){ 
union(){
translate([0,-roddia/2,0])cube([roddia*2,roddia,height],center=true);
cylinder(d=roddia*2,h=height,center=true);
 }
cylinder(d=roddia,h=height+1,center=true);
 }
}
}

translate([0,-depth/2-(pcbZ+support*2)/2,0]){
cube([pcbY+support*2,pcbZ+support*2,height],center=true);}



}

if(orientation==1){
translate([-support/2,-depth/2-(pcbZ+support*2),support*2]){
cube([pcbY+support,(pcbZ+support*2),height],center=true);}
translate([-support/2,-depth/2-pcbZ/2-support,support]){
cube([pcbY+support,pcbZ,height],center=true);}
}

if(orientation==2){
translate([support/2,-depth/2-(pcbZ+support*2),support*2]){
cube([pcbY+support,(pcbZ+support*2),height],center=true);}
translate([support/2,-depth/2-pcbZ/2-support,support]){
cube([pcbY+support,pcbZ,height],center=true);}
}


translate([0,0,0]){
}






}

}

}



pcb_mountA();

}


//pcb_mount(2);