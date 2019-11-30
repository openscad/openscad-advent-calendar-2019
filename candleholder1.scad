$fa = 4; $fs = 0.4;

height = 80;

function f(x) = 8 + 3 * sin(11 * x) + cos(28 * x);

module candle() {
    h = 40;
    color("white") cylinder(r = 5, h = h);
    color("black") translate([0, 0, h - 1]) cylinder(r = 0.4, h = 3);
}

module candleholder() {
    points = [
        [ 0, 0 ],
        for (a = [0:height]) [ f(a), a ],
        [ 0, height ]
    ];

    color("brown") rotate_extrude() polygon(points);
    translate([0, 0, height - 1]) candle();
}

translate([30, 30, 0]) candleholder();

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