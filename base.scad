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

//------------------------------------------------------------------------- MODULES
module pcbLeg() {		
	translate([0, 0, 0])
	difference() { 											
		cylinder(h = floorHeight + pcbHeightOffset, r1=5.5/2, r2 = 4.5/2);
	}
}

module nubsi() {
    rotate([0, 180, 0])  
    union() {
      
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


//------------------------------------------------------------------------- MAIN BLOCK
difference()
{
																		// ADD
	union()
	{
		// Add Base
		linear_extrude(height = height, convexity = 10)
		minkowski()
		{									
			square([width, wide], center = true);
			circle(roundR);
		}
	}
	// SUBSTRACT
	union()
	{
										// Lift floor height
		translate([0, 0, floorHeight])
		{
			// Cut Base hole
			linear_extrude(height = height, convexity = 10)
			minkowski()
			{
				square([width, wide], center = true);
				circle(roundR - pillarSize);
			}
			// Cut upper block lock
			difference() {
				translate([0, 0, height - floorHeight - blockLockSize]) {
					cylinder(h = blockLockSize+gap, r=width);
				}
				translate([0, 0, height - floorHeight - blockLockSize - gap*2]) {
					linear_extrude(height = blockLockSize+gap*4, convexity = 10)
					minkowski() {
						square([width, wide], center=true);
						circle(roundR - layerWidth*4);
					}
				}
			}
			// Cut x panels 
			for (i = [0 : 180 : 180])				
			rotate([0, 0, i])
			translate([width/2 + roundR - pillarSize/2 - layerWidth*7, 0, 0])
			{
				// Cut X panel hole
				translate([0, 0, height])
				cube([pillarSize, sidePanelXWidth, height*2], center=true);
                
				// Cut X, Y srew holes
				for (i = [wide/2, -wide/2])
				{
					translate([-(roundR - pillarSize/2 - layerWidth*7), i, - floorHeight])
					if (i>0) 
					{
						rotate([0, 0, 45])
						translate([screwHoleRoundR, 0, 5])
						{
							cylinder(h = height + 0.001, r=screwExt/2);
						}
					}
					else
					{
						rotate([0, 0, -45])
						translate([screwHoleRoundR, 0, 5])
						{
							cylinder(h = height + 0.001, r=screwExt/2);
                        }
					}
				}
                
			}
			// Cut Y panels 
			for (i = [90 : 180 : 270])
			rotate([0, 0, i])
			translate([wide/2 + roundR - pillarSize/2 - layerWidth*7, 0, 0])
			{
				// Cut Y panel hole
				translate([0, 0, height])
				cube([pillarSize, sidePanelYWidth, height*2], center=true);
			}
		}
	}
}

//------------------------------------------------------------------------- ADD PCB LEGS
// Translate to pcbPositionX	
translate([megaPcbPositionX, megaPcbPositionY, 0])

difference()
{
																		// ADD
	union()
	{
		// Add pcb legs
		for(i=megaPcbHoles)
		{
	    		translate(i)
	    		pcbLeg();
                translate(i)
                cylinder(h=floorHeight+pcbHeightOffset+1.5, r=1.2);
		}
	}

}

// Translate to pcbPositionX	
translate([usbPcbPositionX, usbPcbPositionY, 0])
difference()
{
																		// ADD
	union()
	{
		// Add pcb legs
		for(i=usbPcbHoles)
		{
	    		translate(i)
	    		pcbLeg();
                translate(i)
                cylinder(h=floorHeight+pcbHeightOffset+1.5, r=1.2);
		}
	}

}

//translate
//
// Translate to pcbPositionX	
translate([canPcbPositionX, canPcbPositionY, 0])
rotate([0, 0, -90])

difference()
{
																		// ADD
	union()
	{
		// Add pcb legs
		for(i=canPcbHoles)
		{
	    		translate(i)
	    		pcbLeg();
                translate(i)
                cylinder(h=floorHeight+pcbHeightOffset+1.5, r=1.2);
		}
	}

}

translate([width/2-10,-wide/2+20,0])
nubsi();

translate([width/2-10-72,-wide/2+20-8,0])
nubsi();

translate([width/2-10-72,-wide/2+20-8+44,0])
nubsi();