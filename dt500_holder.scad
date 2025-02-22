include <BOSL2/std.scad>

// TODO Play with chamfer and rounded corners
// TODO Cutout further at the top for the dials, cut it all out?
// TODO Mounting holes in the back
// TODO KVR Text

/**
* Controller dimensions, without tolerances.
*/
cont_width = 2.5 * INCH;
cont_height = 6 * INCH;
cont_depth = 1 * INCH;

buttons_from_bottom = 1 * INCH;

/**
 * Holder dimensions, based off controller
 */
holder_thickness = 0.25 * INCH;

module dt500_controller () {
    union () {
        up(cont_depth/2)
            cube([cont_width, cont_height, cont_depth], center = true);

        /**
        * Buttons, on the face of the controller.
        */
        butt_width = 1.5 * INCH;
        butt_height = cont_height;
        butt_depth = 1 * INCH;

        // TODO Potentially update the shape of the buttons
        back (buttons_from_bottom) up(cont_depth)
            cube([butt_width, butt_height, butt_depth], center = true);
    }
}

difference() {
    // Create the holder
    up(cont_depth/2)
        cuboid([cont_width + holder_thickness*2, cont_height, cont_depth + holder_thickness*2],
            rounding=4);

    // Subtract the controller
    back(holder_thickness)
        dt500_controller();
}

