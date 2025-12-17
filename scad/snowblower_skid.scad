/**
 * Snowblower skid with wheel.
 */
include <BOSL2/std.scad>

// Nut spacing on snowblower is 2-1/8"
ns = 2.125*INCH;
ns_half = ns/2;

// Width
w = 2*INCH;
// Chamfer
c = w - 5/8*INCH;
// Height
h = 5/8*INCH;

// Nut track params
nl = 1.5*INCH;
nw = 3/4*INCH;
nh = h - 3/16*INCH;

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
    [0,7,6,5,4,3,2,1],          // Bottom
    [8,9,10,11,12,13,14,15],    // Top

    // Side walls, starting top right
    [9,8,0,1],
    [10,9,1,2],
    [11,10,2,3],
    [12,11,3,4],
    [13,12,4,5],
    [14,13,5,6],
    [15,14,6,7],
    [8,15,7,0],
];

vnf = [skid_points, skid_faces];

// Main body for the skid
diff () {
    vnf_polyhedron(vnf) {
        #tag("remove") move([ns_half,0.5*INCH,0]) position(TOP) cube([nw,nl,nh],anchor=TOP);
        #tag("remove") move([-ns_half,0.5*INCH,0]) position(TOP) cube([nw,nl,nh],anchor=TOP);
    }
};