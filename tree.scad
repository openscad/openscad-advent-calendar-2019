$fa = 4; $fs = 0.4;

lights = 7;
colors = [ "red", "magenta", "blue", "yellow", "white", "cyan" ];

module tree(idx = 0, height = 0) {
    rnd = rands(0, 1, lights);
    r = 10 * (1 - log(idx + 1));
    translate([0, 0, 10 + height]) {
        color("green")
            cylinder(r1 = r, r2 = 0, h = r);
        translate([0, 0, -r / 10])
            for (a = [0:lights - 1])
                color(colors[floor(len(colors) * rnd[a])])
                    rotate(360 / lights * (a + 0.6 * rnd[a]))
                        translate([r, 0, 0])
                            sphere(r / 10);
    }
    
    if (idx < 5) {
        tree(idx + 1, height + 0.7 * r);
    } else {
        color("brown") cylinder(r1 = 2, r2 = 1.5, h = height);
    }
}

tree();

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