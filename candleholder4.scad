$fa = 4; $fs = 0.4;

module candle() {
    h = 40;
    color("white") cylinder(r = 5, h = h);
    color("black") translate([0, 0, h - 1]) cylinder(r = 0.4, h = 3);
}

module candleholder() {
    color("DarkRed")
        rotate_extrude()
            translate([40, 0, 0])
                scale([1, 0.4])
                    circle(10);

    for (a = [0:3]) rotate(90 * a) translate([40, 0, 0]) {
        candle();
        color("DarkRed")
        rotate_extrude()
            translate([5, 0])
                offset(1)
                    polygon([[0, 3], [0, -8], [8, 6]]);
        
    }
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