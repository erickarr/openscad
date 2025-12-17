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

/**
 * Module for a cut out for a nut.
 * @param d[in] diameter of the nut
 * @param l[in] length of the cutout
 * @param h[in] height of the cutout
 */
module create_nut_track (d,l,h,anchor=CENTER) {
    cube([d,l,h],anchor=anchor) {
        position(FRONT) cylinder(h,d=d,anchor=CENTER);
        position(BACK) cylinder(h,d=d,anchor=CENTER);
    };
};

// Main body for the skid
diff () {
    vnf_polyhedron(vnf) {
        tag("remove") move([ns_half,0.5*INCH,0.01]) position(TOP) create_nut_track(nw,nl,nh,TOP);
        tag("remove") move([-ns_half,0.5*INCH,0.01]) position(TOP) create_nut_track(nw,nl,nh,TOP);
    }
};