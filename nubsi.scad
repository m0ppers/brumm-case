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

module nubsi() {
    union() {
        translate([0,0,-0.5])
        cylinder(h = 0.5, r=19/2);
		cylinder(h = 10, r1=19/2, r2 = 17/2);
        translate([0,0,10])
        {
            cylinder(h = 11, r=8/2);
            translate([0,0,11])
            {
                cylinder(h = 1, r=3);
                translate([0,0,1])
                {
                    cylinder(h = 1, r=4);
                    translate([0,0,1])
                    {
                        cylinder(h = 1, r1=4, r2=3);
                    }
                }
                
            }
        }
        
	}

}

nubsi();