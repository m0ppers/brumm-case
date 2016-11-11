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
//------------------------------------------------------------------------- SHARED PARAMETERS
$fn=100; // resolution

circleD = 21; // round corner circle diameter
roundR = circleD/2; // round corner circle radius
triangleH = (sqrt(3)*(circleD))/2; // triangle height to calculate other variables

layerHeight = 0.25; // some variariables are multiple of layer height and width
layerWidth = 0.5;

screwExt = 3.4; // screw through hole diameter
verConnectionHoleR = 1.2; // screw thread hole radius
screwHead = 6; // screw head hole diameter

gap = layerHeight/2;

floorHeight = 1.8; // 6*0.25 layer + 0.3 first layer

height = 30; // case height
innerHeight = height - floorHeight*2;

pillarSize = roundR-0.01; // corner pillar size

// dimensions of minkowski's inner square
// these are NOT case dimensions
// to calculate external case dimesions add 2 * roundR
// 55.3 + (2*10.5) = 76.3
width = 150.0;
wide = 80;

blockLockSize = 2; // middle connection lock size

// side cutting panels size
sidePanelXWidth = wide;
sidePanelYWidth = width;

// screw hole position from centre of the corner round circle
screwHoleRoundR = roundR - layerWidth*4 - (triangleH/2 - layerWidth*4)/2;

// prints dimensions of the case
echo("width", width + roundR*2); // total width
echo("wide", wide + roundR*2); // total wide

pcbHeight=1.64;
pcbHeightOffset = 2.5;
pcbGap = 4;

canPcbLength=43.0;
canPcbWidth=28.0;
canPcbPositionX = (width/2 + roundR - layerWidth*7 - gap*4) - canPcbWidth;
canPcbPositionY = 10;
canPcbHoles=[ [2.5, 2.3, 0], 				
              [canPcbLength - 2.5, 2.3, 0],
          		[2.5, canPcbWidth - 2.5, 0],
          		[canPcbLength - 2.5, canPcbWidth - 2.5, 0] ];

// UNO PCB dimensions
megaPcbLength=102.0;
megaPcbWidth=53.3;
megaPcbPositionX = canPcbPositionX - megaPcbLength - pcbGap*2;
megaPcbPositionY = -(wide/2 + roundR - layerWidth*7 - gap*4) + 2;

megaPcbHoles=[  [13.97, 2.54, 0], 				
                [15.24, 50.8, 0],
          		[66.04, 35.56, 0],
          		[66.04, 7.62, 0],
                [96.5, 2.54, 0],
                [90.0, 50.8, 0]
             ];



usbPcbLength=63.0;
usbPcbWidth=30.0;
usbHeight = 21.0; // including some offset for the usb cable
usbPcbPositionX = -usbPcbLength/2;
usbPcbPositionY = megaPcbPositionY + megaPcbWidth + pcbGap;
usbPcbHoles=[  [14.0, usbPcbWidth - 3.8, 0], 				
                [56.1, usbPcbWidth - 2.8, 0],
          		[28.5, 4.8, 0]
             ];