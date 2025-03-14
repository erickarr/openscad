include <BOSL2/std.scad>
include <BOSL2/screws.scad>

version = 0;

/**
 * USW dimensions, as described looking into the switch ports.
 */
width = 107;
depth = 70;
height = 21;

/**
 * Flex Mini, with tolerances.
 */
height_tol = 1.5;
usw_dims = [width, depth, height+height_tol];

/**
 * Holder dimensions.
 */
h_thickness = 2;
h_width = 0.95 * width;
h_depth = 1 * depth + h_thickness*2;
h_height = height + 2*h_thickness+height_tol;

/**
 * Ubiquiti logo dimensions.
 */
ul = 25;

/**
 * Module for switch with parallel logo cutout.
 */
module flex_mini() {
    union () {
        // Flex Mini body
        cuboid(usw_dims, rounding=7);
        // Add a spot for the Ubiquiti logo ;)
        cuboid([ul,ul,height+50], rounding=5);
    }
}

/**
 * Object for vent holes.
 */
module vent() {
    left(h_width*0.30) up(height/2) cuboid([h_depth*0.65, h_depth*0.65, 20], rounding=5);
}

/**
 * Object for screw holes.
 */
module mount_hole() {
    down(h_height/2-h_thickness) screw_hole("#8-32,1/2",head="flat",counterbore=0,anchor=TOP,$slop=0.1);
}

diff () {
    // Holder dimensions
    cuboid([h_width, h_depth, h_height], chamfer=1) {
        // Add two squares in the top of the holder, for air movement
        *tag("remove") vent();
        *tag("remove") xflip() vent();

        // Remove the Flex Mini body and logo
        #tag("remove") right((width-h_width)/2+h_thickness) flex_mini();

        // Mounting screw holes
        tag("remove") left(h_width*0.30) mount_hole();
        tag("remove") right(h_width*0.30) mount_hole();

        // Remove a hole for the USB
        *tag("remove") down(2.5) position(BACK) cuboid([16,10,15], rounding=1);
    }
}
