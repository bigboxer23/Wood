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
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.4];
	[UIView setAnimationDelegate:self];
	if(sender == myBoardWidth)
	{
		[myMainView setFrame:CGRectMake(0, 40, myMainView.frame.size.width, myMainView.frame.size.height)];
	}
	if(sender == myIndoorTemp)
	{
		[myMainView setFrame:CGRectMake(0, -80, myMainView.frame.size.width, myMainView.frame.size.height)];
	}
	if(sender == myRelativeHumidy)
	{
		[myMainView setFrame:CGRectMake(0, -40, myMainView.frame.size.width, myMainView.frame.size.height)];
	}
	if(sender == myInstallMoistureCont)
	{
		[myMainView setFrame:CGRectMake(0, 0, myMainView.frame.size.width, myMainView.frame.size.height)];
	}
	[UIView commitAnimations];

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
    
	myGapSize.text = [NSString stringWithFormat:@"%.3f", aInstallMC];
    myMoistureGain.text = [NSString stringWithFormat:@"%.2f", aMoisureGain];

}

- (void)dealloc {
	[self.myMoistureGain release];
    [super dealloc];
}


@end
