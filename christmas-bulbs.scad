$fa = 2; $fs = 0.2;

count = 5;

seed = floor(rands(1, 10000, 1)[0]);
rnd = rands(40, 60, count, seed);

echo(seed = seed);

cols = [
    "MediumOrchid",
    "DeepPink",
    "DeepSkyBlue",
    "Crimson",
    "LimeGreen",
    "LemonChiffon",
    "DarkOrange"
];
col = rands(0, len(cols), count);

module christmasbulb(r, col) {
    r5 = r / 5;
    r30 = r / 30;
    h = r * 1.3;

    color(col) {
        sphere(r);
        cylinder(r = r5, h = h);
    }
    color("Silver") {
        translate([0, 0, h - r5])
            minkowski() { cylinder(r = r5, h = r5); sphere(r30); }
        translate([0, 0, h + r30]) rotate([0, 90, 0])
            rotate_extrude() translate([r5 / 2, 0, 0]) circle(1);
    }
}

module christmasbulbs() {
    for (a = [0:count - 1]) let(random = rnd[a], h = 1.4 * random) {
        translate([120 * (a - (count-1) / 2), 0, 200 + 50 * sin(180 + 180 / (count - 1) * a) - h])
            christmasbulb(random, cols[floor(col[a])]);
    }
}

christmasbulbs();

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