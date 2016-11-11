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

upperConnectorWidth = 44.704 + 2.54*2;
upperConnectorXPos = 18.796 - 2.54;
upperConnectorYPos = 50.8 - 2.54*2;
lowerConnectorWidth = 35.56 + 2.54*2;
lowerConnectorXPos = 27.94 - 2.54;
lowerConnectorYPos = 2.54 - 2.54;

icspConnectorWidth = 5.08 + 2.54*2;
icspConnectorWide = 2.54 + 2.54*2;
icspConnectorXPos = 63.64 - 2.54;
icspConnectorYPos = 30.43 + 2.54;

ledHoleWidth = 2.54 + 1.27*2;
ledHoleWide = 9 + 2.54 + 1.27;
ledHoleXPos = 27.85 - 1.27 - 2.54;
ledHoleYPos = 42.30 + 2.54;

powerLedHoleWidth = 2.54 + 1.27*2;
powerLedHoleWide = 2.54 + 1.27*2;
powerLedHoleXPos = 58.5 - 1.27;
powerLedHoleYPos = 36.5 + powerLedHoleWide/2;

extraConnectorWidth = 10.82 + 2.54*2;
extraConnectorWide = 2.54 + 2.54*2;
extraConnectorXPos = 15.75 - 2.54;
extraConnectorYPos = 47.7 + 2.54;

buttonSize = 4;
buttonXPos = 6.15;
buttonYPos = 50;
buttonBaseHeight = 2;
buttonBaseR = buttonSize/2 + 0.25 + layerWidth*3;

screwHeight=5;

//------------------------------------------------------------------------- MODULES
module pcbLeg() {
	translate([0, 0, 0])
	difference() { 											
		cylinder(h = height - floorHeight - pcbHeightOffset - pcbHeight, r = 5.7/2);
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
        translate([canPcbPositionX, canPcbPositionY, 0])
        rotate([0, 0, -90])
        // Add pcb legs
		for(i=canPcbHoles)
		{
	    		translate(i)
	    		pcbLeg();
		}
        
        
        
	}
															
}

// halterung oben
difference()
{
    translate([-10,0,-10])
    linear_extrude(height = 10, convexity = 10)
    minkowski()
    {									
        square([5, 30], center = true);
        circle(roundR/2);
    }
    translate([-10,0,-3])
    cube([40, 25, 6], center=true);
}