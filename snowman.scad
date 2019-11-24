$fa = 4; $fs = 0.4;

sizes = [[50, 5], [80, 60], [55, 45], [40, 35], [40, 20]];

module hat(r, h) {
    color("black") rotate([0, 5, 0]) {
        cylinder(d = 0.6 * r, h = h);
        cylinder(d = r, h = 2);
    }
}

module body(r, h) {
    s = h / r;
    translate([0, 0, s * r / 2]) scale([1, 1, s]) {
        color("white") sphere(r / 2);
        children();
    }
}

module face(r, h) {
    color("black") for (a = [-2:2]) {
        rotate([100 + 20 * cos(30 * a), 0, 14 * a]) {
            cylinder(r = 2, h = r / 2 + 1, $fn = 5);
        }
        if (abs(a) == 1) rotate([75 - 20 * abs(a), 0, 20 * a]) {
            cylinder(r = 3, h = r / 2 + 1, $fn = 7);
        }
    }
    color("orange") rotate([80, 0, 0]) cylinder(r1 = r/5, r2 = 0, h = r);
}

module base(r, h) {
    color("green") cylinder(r = r, h = h);
}

module snowman(idx = 0, height = 0) {
    r = sizes[idx][0];
    h = sizes[idx][1];
    translate([0, 0, height]) {
        if (idx == 0) {
            base(r, h);
        } else if (idx < 3) {
            body(r, h);
        } else if (idx == 3) {
            body(r, h) face(r, h);
        } else if (idx == 4) {
            hat(r, h);
        }
    }
    if (idx < 5) {
        snowman(idx + 1, height + h - 2);
    }
}

snowman();

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