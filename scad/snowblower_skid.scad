/**
 * Snowblower skid with wheel.
 */
include <BOSL2/std.scad>
include <BOSL2/screws.scad>

// Width of skid
w = 1.5*INCH;
// Chamfer from corners
c = w - 5/8*INCH;
// Height/thickness of skid
h = 3/4*INCH;

// Nut track params
nl = 1*INCH;
nd = 17.17 + 1.5;
nh = h - 3/16*INCH;

// Stud params
sl = nl;
sd = 7.85 + 1;
sh = 1*INCH; // Arbitrary height, tall enough to cutout

// Stud spacing on snowblower
ss = 52;
ss_half = ss/2;

// Wheel offset
wo = 0.5*INCH;
wd = 2*(w - wo) + 5;

/**
 * Points and faces to create primary polyhedron for the skid.
 */
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
        // Nut and stud
        tag("remove") move([ss_half,0*INCH,0.01]) position(TOP) create_nut_track(nd,nl,nh,TOP);
        tag("remove") move([ss_half,0*INCH,-0.01]) position(BOTTOM) create_nut_track(sd,sl,sh,BOTTOM);

        tag("remove") move([-ss_half,0*INCH,0.01]) position(TOP) create_nut_track(nd,nl,nh,TOP);
        tag("remove") move([-ss_half,0*INCH,-0.01]) position(BOTTOM) create_nut_track(sd,sl,sh,BOTTOM);
        
        // Wheel standoff
        fwd(wo) position(TOP) cylinder(4,r1=10,r2=9);

        // Wheel stud
        tag("remove") move([0,-wo,-0.01]) screw("1/4-20,1.5",head="hex",head_undersize=-0.5,shaft_undersize=-1,thread_len=10,anchor=TOP,orient=DOWN);

        // Wheel
        #move([0,-wo,50]) cyl(l=3/4*INCH,d=wd,rounding=6);
    }
};