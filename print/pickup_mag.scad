coilheight=17;
coilwidth=20;
upperidlerheight=2;
loweridlerheight=5;
magdia=5.5;
wallthick=0.5;
cableholedia=2;
coilthreadwidth=4;
threaddepth=5;

module coil(){
difference(){
union(){
cylinder(d=magdia+wallthick*2,h=coilheight,center=true);
translate([0,0,coilheight/2-upperidlerheight/2]){
cylinder(d=coilwidth,h=upperidlerheight,center=true);}
translate([0,0,-(coilheight/2-loweridlerheight/2)]){
cylinder(d=coilwidth,h=loweridlerheight,center=true);}
}
translate([0,0,loweridlerheight]){
cylinder(d=magdia,h=coilheight,center=true);}
cylinder(d=coilthreadwidth,h=coilheight+1,center=true);
translate([coilwidth/2-cableholedia,0,-(coilheight/2-loweridlerheight/2)]){
cylinder(d=cableholedia,h=loweridlerheight+1,center=true);}
}}

module coilmount(){

height=9;
depth=roddia*2;
width=roddistance+roddia;
screwdia=4;
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
translate([jackmountoffset,-jackmountlength/2-depth/2,jackmountheight/2-height/2]){
cube([jackmountwidth,jackmountlength,jackmountheight],center=true);
translate([0,-jackmountlength/2,0]){
cylinder(d=jackmountwidth,h=jackmountheight,center=true);}}}
translate([jackmountoffset,-jackmountlength/2-depth/2,jackmountheight/2-height/2]){
translate([0,-jackmountwidth/2,0]){
cylinder(d=jackdia,h=jackmountheight+1,center=true);}}}

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
cylinder(d=screwdia,h=depth+1,center=true);}

translate([0,depth/2,0]){
cube([coilwidth+2,depth,roddia],center=true);}

translate([roddistance/2,roddia,0]){
cube([roddia,depth,roddia],center=true);}
translate([-roddistance/2,roddia,0]){
cube([roddia,depth,roddia],center=true);}


}

}
}