//
//  DewPointCalculatorViewController.m
//  WoodTek
//
//  Created by matt on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DewPointCalculatorViewController.h"

@implementation DewPointCalculatorViewController

/**
 * Override so we don't move any of the inputs
 */
-(IBAction)inputTouched:(id)sender
{
	[[self navigationItem].rightBarButtonItem setTitle:@"Done"];
}

/*
 ((((-32)/1.8)-(14.55+0.114*((Tf-32)/1.8))*(1-(0.01*RH))-((2.5+0.007*((Tf-32)/1.8))*(1-(0.01*RH)))^3-(15.9+0.117*((Tf-32)/1.8))*(1-(0.01*RH))^14)*1.8)+32 
 */
-(void) updateCalculations
{
    float aRelHumidity = [myInstallMoistureCont.text floatValue];
	float aTemperature = [myBoardWidth.text floatValue];
    
    float aFirst = (aTemperature - 32.0f) / 1.8f;
    float aPrime = 0.01f * aRelHumidity;
    float aSecond = 14.55f + 0.114f * aFirst;
    float aThird = 1.0f - aPrime;
    float aFourth = 2.5f + 0.007f * aFirst;
    float aFifth = aFourth * (1.0f - aPrime);
    float aSixth = 15.9f + 0.117f * aFirst;
    float aDewPoint = aFirst - aSecond * aThird - pow(aFifth, 3) - aSixth * pow(aThird, 14);
    aDewPoint = aDewPoint * 1.8f;
    aDewPoint = aDewPoint + 32.0f;
	myGapSize.text = [NSString stringWithFormat:@"%.1f", aDewPoint];   
}
@end
