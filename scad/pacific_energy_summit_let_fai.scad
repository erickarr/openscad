/**
 * Fresh air intake adapter for Pacific Energy Summit LE.
 * @author Eric Karr
 */
include <BOSL2/std.scad>

 // Square base
 // Recess for 4x magnets
 // Ring for hose adapter

// Base width and height
bw = 5*INCH;
bh = 0.5*INCH;

// Collar parameters
ch = 1*INCH;
cod = 4*INCH;
cid = cod-0.75*INCH;

// TODO Magnet parameters
mh = 3;
md = 10;
mp = bw/2-0.5*INCH;

diff ()
    cuboid([bw,bw,bh],rounding=10,except=["X","Y"],anchor=CENTER) {
        // Holes for magnets
        tag("remove") for(x=[1,-1],y=[1,-1])
            move([mp*x,mp*y]) position(BOTTOM) cyl(h=mh,d=md,anchor=BOTTOM,extra1=0.1);

        // Collar for hose
        tag("keep") position(TOP) tube(h=ch,od=cod,id=cid,ochamfer1=-4,ochamfer2=4,anchor=BOTTOM,$fn=50);

        // TODO Cutout for air
    }
