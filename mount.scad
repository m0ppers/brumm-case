//  ----------------------------------------------------------------------- LICENSE
//  This "brumm-case" by Andreas Streichardt is licensed
//  under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
//  To view a copy of this license, visit
//  http://creativecommons.org/licenses/by-sa/3.0/
//  or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
//
//  Originally (and still heavily) based on work by Zygmunt Wojcik
//  https://github.com/zygmuntw/3D-Printed-Case-for-Arduino
//

include <params.scad>

// halterung oben
difference()
{
    linear_extrude(height = 10, convexity = 10)
    minkowski()
    {									
        square([5, 30], center = true);
        circle(roundR/2);
    }
    //translate([0,0,-3])
    cube([40, 25, 10], center=true);
}