//
//  InstallMoistureCalculatorViewController.m
//  WoodTek
//
//  Created by matt on 1/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InstallMoistureCalculatorViewController.h"

@implementation InstallMoistureCalculatorViewController

@synthesize myMoistureGain;

/**
 * Override so we don't move any of the inputs
 */
-(IBAction)inputTouched:(id)sender
{
	[[self navigationItem].rightBarButtonItem setTitle:@"Done"];
}


-(void) updateCalculations
{
    //Wood Flooring Moisture Gain =(GAP/Width)/Board Coef
    //Projected Moisture Content at Install =(GAP/Width)/Board Coef+Moisture Content
	//float anAverageBoardWidth = [myIndoorTemp.text floatValue];
	
    float aGap = [myRelativeHumidy.text floatValue];
	float aMoistureContent = [myInstallMoistureCont.text floatValue];
	float anAverageBoardWidth = [myBoardWidth.text floatValue];
	float aTotalWidth = aGap + anAverageBoardWidth;
    float aMoisureGain = (aGap / aTotalWidth) / myDimensionalChangeCoefficient;
    float aInstallMC = aMoisureGain +  aMoistureContent;
    
	myGapSize.text = [NSString stringWithFormat:@"%.1f", aInstallMC];
    myMoistureGain.text = [NSString stringWithFormat:@"%.2f", aMoisureGain];

}

- (void)dealloc {
	[self.myMoistureGain release];
    [super dealloc];
}


@end
