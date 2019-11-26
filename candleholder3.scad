$fa = 4; $fs = 0.4;

module candle() {
    h = 40;
    color("White") cylinder(r = 5, h = h);
    color("Black") translate([0, 0, h - 1]) cylinder(r = 0.4, h = 3);
}

module treepart() {
    offset(1) polygon([
        for (x = [-20:0.1:20]) [ x, 11 - sqrt(8 * abs(x)) ],
        for (x = [20:-0.1:-20]) [ x, -11 * cos(4*x) ]
    ]);
}

module tree() {
    color("DarkGreen")
        linear_extrude(2.2, center = true)
            for (a = [0:2])
                translate([0, -13 * a + 60])
                    scale(1 + 0.4 * a)
                        treepart();
    color("SaddleBrown")
        linear_extrude(2, center = true)
            translate([0, 10])
                square([10, 22], center = true);
}

module snowman() {
    color("White") linear_extrude(2, center = true) {
        translate([0, 28]) circle(30);
        translate([0, 75]) circle(20);
        translate([0, 105]) circle(12);
    }
    color("Black") linear_extrude(2.2, center = true) {
        translate([0, 116]) square([20, 2], center = true);
        translate([0, 122]) square([12, 12], center = true);
    }
}

module holder() {
    color("BurlyWood") rotate_extrude() difference() {
        offset(2) difference() {
            scale([1, 0.5]) circle(10);
            translate([0, 8]) square(16, center = true);
        }
        translate([-50, 0]) square(100, center = true);
    }
    candle();
}

module outline() {
    difference() {
        offset(10) children();
        offset(5) children();
    }
}

module candleholder() {
    for (pos = [[-60, 0, 22], [0, 0, 55], [60, 0, 22]])
        translate(pos) holder();
    color("BurlyWood") translate([0, 0, 10]) rotate([90, 0, 0]) difference() {
        linear_extrude(30, center = true) {
            outline() polygon([[0, 30], [-50, 0], [50, 0]]);
        }
    }
    translate([-20, 0, 5]) rotate([90, 0, 0]) scale(0.32) tree();
    translate([25, 0, 5]) rotate([90, 0, 0]) scale(0.2) tree();
    translate([6, 0, 5]) rotate([90, 0, 0]) scale(0.24) snowman();
}

candleholder();

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