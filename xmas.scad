$fa = 4; $fs = 0.4;

letter_h1 = 2;
letter_h2 = 14;

letters = [
    [ "X", [ -10, -10, 14], [85, -10,  60] ],
    [ "M", [  20,  30, 17], [80,  -8,   0] ],
    [ "A", [  50,  10, 17], [90,  11,  21] ],
    [ "S", [  90, -15, 12], [85,  -8, -20] ],
];

spheres = [
    [80, [-10, -30, -70]],
    [80, [ 30,  10, -60]],
    [60, [ 90,  20, -50]],
    [70, [ 80, -10, -60]],
];

module outline(h, o1, o2, o3) {
    linear_extrude(h, center = true) difference() {
        offset(o1) children();
        offset(o3) offset(o2) children();
    }
}

module letter() {
    color("Red") {
        translate([0, 0, -letter_h2 / 2])
            outline(letter_h1, 3, 1, -2)
                children();
        translate([0, 0, letter_h2 / 2])
            outline(letter_h1, 3, 1, -2)
                children();
    }
    color("White")
        translate([0, 0, 0])
            outline(letter_h1 + letter_h2 - 0.1, 1, 1, -1)
                children();
    color("Gold")
        translate([0, 0, 0])
            outline(1, 0.99, -10, 0)
                children();
}

module spheres() {
    difference() {
        for (s = [0 : len(spheres) - 1])
            translate(spheres[s][1])
                sphere(spheres[s][0]);
        translate([0, 0, -250]) cube([500, 500, 500], center = true);
    }
}

module xmas() {
    color("White")
        spheres();
    for (l = [0:3])
        translate(letters[l][1])
            rotate(letters[l][2])
                letter()
                    text(letters[l][0], 50, halign = "center");
}

xmas();

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
