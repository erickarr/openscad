/**
 * Design cable holder for network cables.
 */
include <BOSL2/std.scad>

version = 0;

$fn=10;

l = 2*INCH;
w = 1*INCH;
h = 3/8*INCH;

cable_dia = 5.8;

/**
 * Cable cutout.
 */
module cable() {
    union () {
        ycyl(l=w,d=cable_dia);
        cube([cable_dia,w,cable_dia], anchor=TOP);
    }
}

/**
 * Torus for cable grip.
 */
id = 5.3;
od = 6;
module ridge() {
    torus(id=id,od=od,orient=FRONT);
}

*cable();

diff () {
    cuboid([l,w,h],chamfer=1,anchor=BOTTOM) {
        tag("remove") xdistribute(8) {
            up(2) position(BOTTOM) {
                tag("remove") cable();
                tag("keep") ydistribute(8) {
                    ridge();
                    ridge();
                    ridge();
                    ridge();
                }
            }
            up(2) position(BOTTOM) cable();
            up(2) position(BOTTOM) cable();
            up(2) position(BOTTOM) cable();
        }
        *tag("keep") position(BOTTOM) torus(id=5,od=6,orient=FRONT);
        // TODO screw holes
    }
}