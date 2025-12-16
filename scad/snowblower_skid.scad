/**
 * Snowblower skid with wheel.
 */
include <BOSL2/std.scad>

// Bolt spacing on snowblower is 2-1/8"

// Width
w = 2*INCH;
// Chamfer
c = w - 5/8*INCH;

echo(c);

skid_points = [
    [c, w, 0],
    [w, c, 0],
    [w, -c, 0],
    [c, -w, 0],
    [-c, -w, 0],
    [-w, -c, 0],
    [-w, c, 0],
    [-c, w, 0],
];
skid_faces = [
    [0,1,2,3,4,5,6,7],
];

polyhedron(skid_points,skid_faces);