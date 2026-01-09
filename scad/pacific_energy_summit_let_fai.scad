/**
 * Fresh air intake adapter for Pacific Energy Summit LE.
 * @author Eric Karr
 */
include <BOSL2/std.scad>
include <BOSL2/screws.scad>

ASM = "none";

// Base width and height
bw = 5*INCH;
bh = 0.5*INCH;

// Collar parameters
ch = 1*INCH;
cod = 4*INCH;
cid = cod-0.5*INCH;

// TODO Magnet parameters
mh = 3;
md = 10;
mp = bw/2-0.5*INCH;

// Woodstove dimensions
oak_id = 104.4;

// Wall thickness
wt = (oak_id - cid)/2;

// TODO Current wall thickness is 1/4", perhaps thicken the walls
// if we want to use a captured nut? M3/M4 are too large.
diff ()
    // Collar for hose
    tube(h=ch,od=cod,id=cid,ochamfer1=2,ochamfer2=-4,$fn=100) {
        attach(TOP,BOTTOM) tube(h=2,od=oak_id,id=cid,$fn=100);
        arc_copies(3.2, d=oak_id-wt) down(10) position(TOP) #nut_trap_inline(5,"M2",$slop=0.1);
            //*attach(TOP,BOTTOM) tube(h=2,od1=oak_id+5,od2=oak_id,id=cid,$fn=100);
    };

if (ASM == "v1") {
    diff ()
        cuboid([bw,bw,bh],rounding=10,except=["X","Y"],anchor=CENTER) {
            // Holes for magnets
            tag("remove") for(x=[1,-1],y=[1,-1])
                move([mp*x,mp*y]) position(BOTTOM) cyl(h=mh,d=md,anchor=BOTTOM,extra1=0.1);

            // Collar for hose
            tag("keep") position(TOP) tube(h=ch,od=cod,id=cid,ochamfer1=-4,ochamfer2=4,anchor=BOTTOM,$fn=50);

            // TODO Cutout for air
        }
}
