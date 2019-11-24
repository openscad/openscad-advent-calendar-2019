$fa = 4; $fs = 0.4;

r = 20;
length = 50;

// edge length of a 8 sided polygon with outer radius r
function edge(r) = r * sqrt(2 - sqrt(2));

module base() {
    linear_extrude(edge(r), center = true) {
        rotate(22.5) polygon([for (a = [0:7]) r * [-sin(45 * a), cos(45 * a)] ]);
    }
}

module part(r) {
}

module quad(r) {
    l = r * cos(360/16);
    hull() {
        translate([0, 0, l - edge(r)/2]) cube(edge(r), center = true);
        translate([0, 0, l + length]) sphere(1);
    }
}

// https://en.wikipedia.org/wiki/Equilateral_triangle
module tri(r) {
    // radius of outer circle of equilateral triangle
    rt = edge(r) * sqrt(3) / 3;
    // radius of circumscribed circle of triangle with half the side length
    rc = edge(r) / 2 / sqrt(3);
    // https://en.wikipedia.org/wiki/Circular_segment
    h = r - 1/2 * sqrt(4 * pow(r, 2) - pow(rc, 2));
    hull() {
        translate([0, 0, r - h])
            linear_extrude(2, center = true)
                polygon([for (a = [0: 120 : 240]) rt * [ -sin(a), cos(a) ] ]);
*        translate([0, 0, l + length]) sphere(1);
    }
}

module star() {
    *sphere(r);
    %hull() {
        base();
        rotate([90, 0, 0]) base();
    }
    
    color("red") {
        for (rot = [0 : 45 : 315]) {
            rotate([rot, 0, 0]) quad(r);
        }
        for (rot = [0 : 90 : 270]) {
            rotate([rot, 0, 0]) {
                rotate([0, 45, 0]) quad(r);
                rotate([0, -45, 0]) quad(r);
            }
        }
    }
    
    rotate(45) rotate([54.7, 0, 0]) tri(r);
}

star();

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