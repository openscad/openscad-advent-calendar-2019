$fa = 4; $fs = 0.4;

module wheel() {
    color("DimGray")
        rotate_extrude()
            translate([15, 0])
                offset(2)
                    square([3, 12], center = true);
    color("Silver")
        for (a = [0:20:179])
            rotate([90, 0, a])
                scale([0.2, 1, 1])
                    cylinder(r = 4, h = 30, center = true);
}

module train() {
    color("Black") linear_extrude(10, center = true) offset(5) square([40, 200], center = true);
    for (x = [-80, -40, 40, 80]) translate([30, x, 0]) rotate([90, 0, 90]) wheel();
    for (x = [-80, -40, 40, 80]) translate([-30, x, 0]) rotate([90, 0, 90]) wheel();
    translate([0, 0, 22]) {
        color("Red") {
            hull() {
                scale([1, 0.3, 1]) sphere(20);
                translate([0, -100, 0]) scale([1, 0.3, 1]) sphere(20);
            }
            translate([0, -50, 0]) cylinder(r = 6, h = 25);
            translate([0, -50, 25]) sphere(6);
            translate([0, -80, 0]) cylinder(r = 6, h = 40);
            translate([0, -80, 50]) difference() {
                sphere(r = 13);
                translate([0, 0, 25]) cube(50, center = true);
            }
            difference() {
                translate([0, 40, 30]) cube([42, 70, 100], center = true);
                translate([0, 40, 50]) cube([44, 40, 40], center = true);
                translate([0, 55, 25]) cube([36, 90, 100], center = true);
            }
            translate([0, 50, 80]) linear_extrude(8, scale = 1.1) square([42, 90], center = true);
        }
        color("Black") for(x = [-92, -62, -32, -2])
            translate([0, x, 0]) rotate([90, 0, 0]) cylinder(r = 20.2, h = 5);
    }
}

train();

// Written in 2019 by Torsten Paul <Torsten.Paul@gmx.de>
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.