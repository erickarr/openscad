/**
 * Fresh air intake adapter for Pacific Energy Summit LE.
 * @author Eric Karr
 */
include <BOSL2/std.scad>
include <BOSL2/screws.scad>

ASM = "v1";

$fn=100;

/**
 * Woodstove dimensions
 * Outside Air Kit (OAK)
 */
oak_id = 104.4;
oak_cl = 12; // Clearance from opening to pedastal base

// Base width and height
bw = 4.75*INCH; // or oak_id + oak_cl*2;
bh = 0.25*INCH;

// Collar parameters
ch = 1.75*INCH;
cod = 4*INCH;
cid = cod-0.5*INCH;

// Magnet parameters
mh = 1.8;
md = 6.5;
mp = bw/2-0.4*INCH;

// Wall thickness
wt = (oak_id - cid)/2;

if (ASM == "v2") {
    diff ()
        // Collar for hose
        tube(h=ch,od=cod,id=cid,ochamfer1=2,ochamfer2=-4,$fn=100) {
            attach(TOP,BOTTOM) tube(h=2,od=oak_id,id=cid,$fn=100);
                //attach(TOP,BOTTOM) tube(h=4,od1=oak_id+5,od2=oak_id,id=cid,$fn=100);
            // TODO if we want to use a captured nut? M3/M4 are too large.
            //arc_copies(3.2, d=oak_id-wt) down(10) position(TOP) #nut_trap_inline(5,"M2",$slop=0.1);
        };
}

if (ASM == "v1") {
    diff ()
        cuboid([bw,bw,bh],rounding=10,except=["X","Y"],anchor=CENTER) {
            // Holes for magnets
            #tag("remove") for(x=[1,-1,0.5,-0.5,0],y=[1,-1,0.5,-0.5,0])
                move([mp*x,mp*y]) position(BOTTOM) cyl(h=mh,d=md,anchor=BOTTOM,extra1=0.1);

            // Collar for hose
            tag("keep") position(TOP) tube(h=ch,od=cod,id=cid,ochamfer1=-3,ochamfer2=2,anchor=BOTTOM);

            // Cutout for air
            tag("remove") cyl(h=100,d=cid);
        }
}
