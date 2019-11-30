$fa = 6; $fs = .8;

height = 12;

module heart(w = 30) {
    translate([0, w * sqrt(2) / 2]) {
        rotate(-135) {
            square(w);
            translate([w / 2, 0]) circle(d = w);
            translate([0, w / 2]) circle(d = w);
        }
    }
}

module star(n = 5, r1 = 22, r2 = 40) {
    function r(a) = a % 2 == 0 ? r2 : r1;
    function p(a) = [ -sin(a), cos(a) ];

    assert(n >= 3);
    points = [ for (a = [0 : 2 * n - 1]) r(a) * p(180 / n * a) ];
    polygon(points);
}

module outline() {
    difference() {
        offset(0.01) children();
        children();
    }
}

module cut(height, base_height, r1, r2) {
    translate([0, 0, -base_height]) cylinder(r = 2 * r1, h = base_height);
    translate([0, 0, -0.01]) cylinder(r1 = r1, r2 = r2, h = height);
}

module cookie_cutter(height = 12, base_height = 1, r1 = 0.8, r2 = 0.2) {
    minkowski() {
        linear_extrude(0.01) outline() children();
        cut(height, base_height, r1, r2);
    }
}

translate([-42, 0, 0]) cookie_cutter() star(5, 22, 40);
translate([36, 0, 0]) cookie_cutter() heart(35);

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
