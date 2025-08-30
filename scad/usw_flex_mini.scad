include <BOSL2/std.scad>
include <BOSL2/screws.scad>

version = 1;

$fn = 30;

/**
 * USW dimensions, as described looking into the switch ports.
 */
width = 107;
depth = 70;
height = 21;

/**
 * Flex Mini, with tolerances.
 */
tol = 1;
usw_dims = [width, depth+tol, height+tol];

/**
 * Holder dimensions.
 */
h_thickness = 2;
h_width = 1 * width + 2*h_thickness;
h_depth = 1 * depth + 2*h_thickness;
h_height = height + 2*h_thickness+tol;

/**
 * Ubiquiti logo dimensions.
 */
ul = 25;

screw_hole_offset = 0.3*h_width;

/**
 * Module for switch with parallel logo cutout.
 */
module flex_mini() {
    union () {
        // Flex Mini body
        cuboid(usw_dims, rounding=7);
        // Add a spot for the Ubiquiti logo ;)
        cuboid([ul,ul,height+50], rounding=5);
        // Add cutouts to access the screws for installation
        left(screw_hole_offset) position(TOP) cuboid([ul,ul,10], rounding=5);
        right(screw_hole_offset) position(TOP) cuboid([ul,ul,10], rounding=5);
        // Clearance front and back for ports and USB
        cuboid([92,100,20]);
    }
}

/**
 * Object for screw holes.
 */
module mount_hole() {
    down(h_height/2-h_thickness) 
        screw_hole("#8-32,1/2",
            head="flat",
            anchor=TOP,
            $slop=0.1,
            $fn=8);
            //teardrop=true);
}

diff () {
    // Holder dimensions
    cuboid([h_width, h_depth, h_height], chamfer=1) {
        // Flex mini
        tag("remove") flex_mini();

        // Mounting screw holes
        tag("remove") left(screw_hole_offset) mount_hole();
        tag("remove") right(screw_hole_offset) mount_hole();

        // Hole to slide the switch into
        tag("remove") position(RIGHT) cuboid([2*width,depth+tol,height], rounding=2);
    }
}
