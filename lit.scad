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

//------------------------------------------------------------------------- PARAMETERS
// lid holes dimensions
connectorRoundR = 2.54/2;
connectorWide = 2.54*3;

screwHeight=5;

//------------------------------------------------------------------------- MODULES
module pcbLeg() {
	translate([0, 0, 0.501])
	difference() { 											
		cylinder(h = height - floorHeight - pcbHeightOffset - pcbHeight -0.5, r = 5/2);
	}
}

//------------------------------------------------------------------------- MAIN BLOCK
difference()
{
																		// ADD
	union()
	{
		// Add Base
        translate([-10,0,0])
		linear_extrude(height = screwHeight + blockLockSize, convexity = 10)
		minkowski()
		{									
			square([width + 20, wide], center = true);
			circle(roundR);
		}

	}
    union()
    {
        translate([0,0,screwHeight])
        linear_extrude(height = blockLockSize+gap*4, convexity = 10)
        minkowski() {
            square([width, wide], center=true);
            circle(roundR - layerWidth*4);
        }
        translate([0, 0, screwHeight])
        {
    		// Cut x panels 
			for (i = [0 : 180 : 180])				
			rotate([0, 0, i])
			translate([width/2 + roundR - pillarSize/2 - layerWidth*7, 0, 0])
			{
                
				// Cut X, Y srew holes
				for (i = [wide/2, -wide/2])
				{
					translate([-(roundR - pillarSize/2 - layerWidth*7), i, - screwHeight])
					if (i>0) 
					{
						rotate([0, 0, 45])
						translate([screwHoleRoundR, 0, 0])
						{
                            cylinder(h = height + 0.001, r=screwExt/2);
                            cylinder(h = 5,
                                    r1 = (screwHead + (screwHead - screwExt))/2,
                                    r2 = screwExt/2, center=true);
						}
					}
					else
					{
						rotate([0, 0, -45])
						translate([screwHoleRoundR, 0, 0])
						{
                            cylinder(h = height + 0.001, r=screwExt/2);
                            							cylinder(h = 5,
                                    r1 = (screwHead + (screwHead - screwExt))/2,
                                    r2 = screwExt/2, center=true);
						}
					}
				}
                
			}
        }
        // halterung oben
        difference()
        {
            translate([-10,0,-9.5])
            linear_extrude(height = 10, convexity = 10)
            minkowski()
            {									
                square([5, 30], center = true);
                circle(roundR/2);
            }

        }
    }
    
}

//------------------------------------------------------------------------- ADD PCB LEGS
// Rotate due to panel upside down
mirror([0, 1 , 0])



difference()
{
																		// ADD
	union()
	{
		// Add pcb legs
        translate([megaPcbPositionX, megaPcbPositionY, 0])
		for(i=megaPcbHoles)
		{
	    		translate(i)
	    		pcbLeg();
		}
        translate([usbPcbPositionX, usbPcbPositionY, 0])
        // Add pcb legs
		for(i=usbPcbHoles)
		{
	    		translate(i)
	    		pcbLeg();
		}
        translate([convPcbPositionX, convPcbPositionY, 0])
        // Add pcb legs
		for(i=convPcbHoles)
		{
	    		translate(i)
	    		pcbLeg();
		}
        translate([canPcbPositionX, canPcbPositionY, 0])
        // Add pcb legs
		for(i=canPcbHoles)
		{
	    		translate(i)
	    		pcbLeg();
		}
        
        
        
	}
															
}

