$fa = 4; $fs = 0.4;

module candle() {
    h = 40;
    color("White") cylinder(r = 5, h = h);
    color("Black") translate([0, 0, h - 1]) cylinder(r = 0.4, h = 3);
}

module part(offset) {
    color("MistyRose") difference() {
        for (a = [0:4])
            translate([0, 0, offset * a])
                scale([1, 1, 0.5])
                    sphere(offset * (4 - a));
        translate([0, 0, -100]) cube(200, center = true);
    }
}

module candleholder() {
    translate([0, 0, 55]) {
        color("SlateGray") difference() {
            scale([1, 1, 0.6])
                rotate([90, 0, 0])
                    rotate_extrude()
                        translate([50, 0])
                            scale([0.6, 1.2])
                                circle(3);
            translate([0, 0, 100]) cube(200, center = true);
        }
        translate([50, 0, 12]) {
            candle();
            rotate([180, 0, 0]) part(4);
        }
        translate([-50, 0, 12]) {
            candle();
            rotate([180, 0, 0]) part(4);
        }
    }
    part(8);
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