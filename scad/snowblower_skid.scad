/**
 * Snowblower skid with wheel.
 */
include <BOSL2/std.scad>

// Bolt spacing on snowblower is 2-1/8"

// Width
w = 2*INCH;
// Chamfer
c = w - 5/8*INCH;
// Height
h = 5/8*INCH;

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
    
    [c, w, h],
    [w, c, h],
    [w, -c, h],
    [c, -w, h],
    [-c, -w, h],
    [-w, -c, h],
    [-w, c, h],
    [-c, w, h],
];
skid_faces = [
    [0,1,2,3,4,5,6,7],          // Bottom
    [8,9,10,11,12,13,14,15],    // Top

    // Side walls
    [1,0,8,9],
    [2,1,9,10],
    [3,2,10,11],
    [4,3,11,12],
    [5,4,12,13],
    [6,5,13,14],
    [7,6,14,15],
    [0,7,15,8],
];

polyhedron(skid_points,skid_faces);