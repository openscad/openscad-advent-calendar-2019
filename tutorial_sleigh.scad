// Get the OpenSCAD tutorial at https://en.wikibooks.org/wiki/OpenSCAD_Tutorial
 
module sleigh_basket() {
    color("burlywood")
        cube([sleigh_length, sleigh_width, sleigh_height], center=true);
}
 
module left_blinking_lights() {
    for (i=[0:1:$children-1])
        if (i%2==0)
            color(get_blinking_color_1())
                children(i);
        else
            color(get_blinking_color_2())
                children(i);
}
 
module left_sleigh_rail() {
    color("snow") {
        translate([(rail_length-sleigh_length)/2,-sleigh_width/2,-sleigh_height/2-rail_diameter])
            rotate([0,90,0])
            cylinder(h=rail_length, d=rail_diameter, center=true);
        translate([-sleigh_length/2,-sleigh_width/2,-sleigh_height/2])
            rotate([-90,90,0])
            rotate_extrude(angle=135)
            translate([rail_diameter,0,0])
            circle(d=rail_diameter);
        translate([-sleigh_length/2+rail_diameter*2,-sleigh_width/2,-sleigh_height/2])
            sphere(r=rail_diameter);
        translate([sleigh_length/2-rail_diameter,-sleigh_width/2,-sleigh_height/2])
            sphere(r=rail_diameter);
    }
}
 
module gift() {
    color(get_blinking_color_1())
        translate([0,5,0])
        linear_extrude(height=10)
        text("Tutorial", size=32);
    color("snow")
        translate([0,-1,-1])
        cube([140,36,6]);
}
 
module spoked_wheel(radius=12, width=5, thickness=5, number_of_spokes=7, spoke_radius=1.5) {
   
    rotate([90,0,0]) {
        // Ring
        inner_radius = radius - thickness/2;
        color("snow")
            difference() {
                cylinder(h=width,r=radius,center=true);
                cylinder(h=width + 1,r=inner_radius,center=true);
            }
       
        // Spokes
        spoke_length = radius - thickness/4;
        step = 360/number_of_spokes;
        for (i=[0:step:359]) {
            angle = i;
            color("darkred")
                rotate([0,90,angle])
                cylinder(h=spoke_length,r=spoke_radius);
        }
    }
}
 
module axle(track=35, radius=2) {
    color("snow")
    rotate([90,0,0])
        cylinder(h=track,r=2,center=true);
}
 
module car() {
    // Round car body
    color("darkred")
        resize([90,20,12])
        sphere(r=10);
    color("snow")
        translate([10,0,5])
        resize([50,15,15])
        sphere(r=10);
 
    // Wheels
    translate([-wheelbase/2,-front_track/2,0])
        spoked_wheel(radius=front_wheels_radius, width=front_wheels_width, thickness=front_wheels_thickness, spoke_radius=front_spoke_radius);
    translate([-wheelbase/2,front_track/2,0])
        spoked_wheel(radius=front_wheels_radius, width=front_wheels_width, thickness=front_wheels_thickness, spoke_radius=front_spoke_radius);
    translate([wheelbase/2,-rear_track/2,0])
        spoked_wheel();
    translate([wheelbase/2,rear_track/2,0])
        spoked_wheel();
 
    // Axles
    translate([-wheelbase/2,0,0])
        axle(track=front_track, radius=front_axle_radius);
    translate([wheelbase/2,0,0])
        axle(track=rear_track);
}
 
module left_and_right() {
    for (i=[0:1:$children-1]) {
        children(i);
        translate([0,sleigh_width,0])
            children(i);
    }
}
 
function get_blinking_color_1() =
    ($t<0.5) ? "chocolate" : "darkgreen";
 
function get_blinking_color_2() =
    ($t<0.5) ? "darkgreen" : "chocolate";
 
// Resolution
$fa = 1;
$fs = 0.4;
 
// Car variables
front_track = 24;
rear_track = 34;
wheelbase = 60;
front_wheels_radius = 10;
front_wheels_width = 4;
front_wheels_thickness = 3;
front_spoke_radius = 1;
front_axle_radius = 1.5;
 
// Sleigh variables
sleigh_length = 140;
sleigh_height = 50;
sleigh_width = 60;
sleigh_thickness = 5;
rail_diameter = 10;
rail_length = 150;
light_diameter = 10;
 
// Cars
translate([-150,-rear_track/2-10,0])
    car();
translate([-150,rear_track/2+10,0])
    car();
translate([-250,-rear_track/2-10,10])
    car();
translate([-250,rear_track/2+10,10])
    car();
translate([-350,-rear_track/2-10,20])
    car();
translate([-350,rear_track/2+10,20])
    car();
translate([-450,0,30])
    car();
 
// Sleigh and gift
sleigh_basket();
translate([-sleigh_length/2,0,sleigh_height/2-0.01])
    rotate([90,0,0])
    gift();
left_and_right() {
    left_sleigh_rail();
    left_blinking_lights() {
        translate([-sleigh_length/2,-sleigh_width/2,-sleigh_height/2])
            sphere(d=light_diameter);
        translate([-sleigh_length/2,-sleigh_width/2,-sleigh_height/4])
            sphere(d=light_diameter);
        translate([-sleigh_length/2,-sleigh_width/2,0])
            sphere(d=light_diameter);
        translate([-sleigh_length/2,-sleigh_width/2,sleigh_height/4])
            sphere(d=light_diameter);
   
        translate([-sleigh_length/2,-sleigh_width/2,sleigh_height/2])
            sphere(d=light_diameter);
        translate([-sleigh_length*3/8,-sleigh_width/2,sleigh_height/2])
            sphere(d=light_diameter);
        translate([-sleigh_length/4,-sleigh_width/2,sleigh_height/2])
            sphere(d=light_diameter);
        translate([-sleigh_length/8,-sleigh_width/2,sleigh_height/2])
            sphere(d=light_diameter);
        translate([0,-sleigh_width/2,sleigh_height/2])
            sphere(d=light_diameter);
        translate([sleigh_length/8,-sleigh_width/2,sleigh_height/2])
            sphere(d=light_diameter);
        translate([sleigh_length/4,-sleigh_width/2,sleigh_height/2])
            sphere(d=light_diameter);
        translate([sleigh_length*3/8,-sleigh_width/2,sleigh_height/2])
            sphere(d=light_diameter);
   
        translate([sleigh_length/2,-sleigh_width/2,sleigh_height/2])
            sphere(d=light_diameter);
        translate([sleigh_length/2,-sleigh_width/2,sleigh_height/4])
            sphere(d=light_diameter);
        translate([sleigh_length/2,-sleigh_width/2,0])
            sphere(d=light_diameter);
        translate([sleigh_length/2,-sleigh_width/2,-sleigh_height/4])
            sphere(d=light_diameter);
        translate([sleigh_length/2,-sleigh_width/2,-sleigh_height/2])
            sphere(d=light_diameter);
    }
}
 
// Written in 2019 by Themistoklis Spanoudis
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

