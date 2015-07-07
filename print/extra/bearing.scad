include <configuration.scad>;

module bearing(inner_dia,outer_dia,height){
    
   color(boltcolor){
    
        
     difference(){   
     cylinder(d=outer_dia, h=height,$fn=16,center=true);
     cylinder(d=inner_dia, h=height+1,$fn=16,center=true); }  
        }
    }
   