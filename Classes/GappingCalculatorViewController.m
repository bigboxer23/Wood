//
//  GappingCalculatorViewController.m
//  FlooringApp
//
//  Created by matt on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GappingCalculatorViewController.h"

@implementation GappingCalculatorViewController

/**
 *	Meat and potatoes, where all the display magic happens...
 **/
-(void) updateCalculations
{
	float aTemp = [self.myIndoorTemp.text floatValue];
	float aHumidity = [self.myRelativeHumidy.text floatValue];
	float aInstallMoistureContent = [self.myInstallMoistureCont.text floatValue];
	float aBoardWidth = [self.myBoardWidth.text floatValue];
	float aTempSquared = pow(aTemp, 2);
	
	float m9 = 330 + 0.452f * aTemp + 0.00415f * aTempSquared;
	float n9 = 0.791f + 0.000463f * aTemp - 0.000000844f * aTempSquared;
	float q9 = (0.791f + 0.000463f * aTemp - 0.000000844f * aTempSquared) * (aHumidity / 100);
	float r9 = q9 * (6.34f + 0.000775f * aTemp - 0.0000935f * aTempSquared);
	float p9 = 1.09f + 0.0284f * aTemp - 0.0000904f * aTempSquared;
	float s9 = (6.34f + 0.000775f * aTemp - 0.0000935f * aTempSquared) * p9 * pow(n9,2) * pow((aHumidity / 100), 2);
	
	float aCurrentMoisture = (1800 / m9) * ((q9 / (1 - q9)) + ((r9 + 2 * s9) / (1 + r9 + s9)));
	
	float aGap = (aInstallMoistureContent - aCurrentMoisture) * aBoardWidth * myDimensionalChangeCoefficient;
	
	self.myGapSize.text = [NSString stringWithFormat:@"%.4f", aGap];
	self.myCurMoistureCont.text = [NSString stringWithFormat:@"%.4f", aCurrentMoisture];
}

@end