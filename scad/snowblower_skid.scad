/**
 * Snowblower skid with wheel.
 */
include <BOSL2/std.scad>
include <BOSL2/screws.scad>

ASM = "all"; // "all", "skid", "wheel", "bushing"

$fn = 50;

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
sh = 0.5*INCH;

// Stud spacing on snowblower
ss = 52;
ss_half = ss/2;

// Wheel params
wo = 0.5*INCH;
wd = 2*(w - wo) + 5;
wh = 3/4*INCH;

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

module wheel () {
    // bearing specs
    bd = 22.05+0.15; // Add circle tolerance
    bh = 7;

    // washer specs
    washerd = 18.59+0.2;
    washerh = 3;

    tag_scope()
    diff () {
        // Wheel
        cyl(l=wh,d=wd,rounding=6,anchor=BOTTOM) {
            // Bearing cutout
            tag("remove") down(0.01) position(BOTTOM) cyl(h=bh,d=bd,anchor=BOTTOM);
            // Washer cutout
            tag("remove") up(0.01) position(TOP) cyl(h=washerh,d=washerd,anchor=TOP);
            // Bolt cutout
            tag("remove") cyl(h=wh+1,d=6.25+0.35);
        };
    };
};

/**
 * Fills space between bolt and bearing
 */
module bushing() {
    // Bearing ID - 8.03
    // Bolt OD - 6.22
    bushh = 7.2;
    bushod = 8.07 + 0.2;
    bushid = 6.22 + 0.1;

    diff () {
        cyl(h=bushh,d=bushod) {
            tag("remove") cyl(h=bushh,d=bushid);
        };
    };
};

if (ASM == "all") {
    diff () {
        vnf_polyhedron(vnf) {
            // Nut and stud
            tag("remove") move([ss_half,0*INCH,0.01]) position(TOP) create_nut_track(nd,nl,nh,TOP);
            tag("remove") move([ss_half,0*INCH,-0.01]) position(BOTTOM) create_nut_track(sd,sl,sh,BOTTOM);

            tag("remove") move([-ss_half,0*INCH,0.01]) position(TOP) create_nut_track(nd,nl,nh,TOP);
            tag("remove") move([-ss_half,0*INCH,-0.01]) position(BOTTOM) create_nut_track(sd,sl,sh,BOTTOM);
            
            // Wheel and standoff
            // TODO use children()
            fwd(wo) position(TOP) cylinder(h=3,d1=13,d2=11.5);// position(TOP) wheel();
            
            // Wheel stud
            tag("remove") move([0,-wo,3]) screw("1/4-20,2",head="hex",head_undersize=-0.4,shaft_undersize=-0.3,thread_len=10,anchor=TOP,orient=DOWN);
            // Recess for bolt head
            tag("remove") move([0,-wo,-0.01]) cyl(h=3.5,d=15,anchor=BOTTOM);
        };
    };
};

if (ASM == "wheel") {
    $fn = 80;
    zflip() wheel();
};

if (ASM == "bushing") {
    $fn = 80;
    bushing();
};