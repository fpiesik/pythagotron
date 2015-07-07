include <configuration.scad>;

module bolt(dia, length){
    color(boltcolor){
    cylinder(d=dia, h=length,$fn=16);
    translate([0,0,length])cylinder(d=dia*2, h=dia/2,$fn=16);}
}

module nut(dia){
    color(boltcolor){
    
        
     difference(){   
     cylinder(d=dia*2, h=dia,$fn=6,center=true);
     cylinder(d=dia, h=dia+1,$fn=16,center=true); }  
        }
    
}
  
    
//bolt(4,50);
 //   nut(4);