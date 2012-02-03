//
//  EMCCalculatorViewController.m
//  WoodTek
//
//  Created by matt on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EMCCalculatorViewController.h"

@implementation EMCCalculatorViewController

#pragma mark - View lifecycle

/**
 * Override so we don't move any of the inputs
 */
-(IBAction)inputTouched:(id)sender
{
	[[self navigationItem].rightBarButtonItem setTitle:@"Done"];
}

-(void) updateCalculations
{
   /* M = 1800/W [ KH/(1-KH) + (K1KH + 2K1K2K2H2) / (1 + K1KH + K1K2K2H2)] 
    
    =((M11*M10*M4)+(2*M11*M12*(M10^2)*(M4^2)))/(1+(M11*M10*M4)+(M11*M12*(M10^2)*(M4^2)))
Where:
    
    M = moisture content (%)
    T = temperature (oF)
    H = relative humidity (%) / 100
    W = 330 + 0.452T + 0.00415T2
    K = 0.791 + 0.000463T - 0.000000844T2
    K1 = 6.34 + 0.000775T - 0.0000935T2
    K2 = 1.09 + 0.0284T - 0.0000904T2*/
   	float aRelHumidity = [myIndoorTemp.text floatValue] / 100.0f;
	float aTemperature = [myBoardWidth.text floatValue];
	float aTempSquared = pow(aTemperature, 2);
    
    float aW = 330 + (0.452f * aTemperature) + (0.00415f * aTempSquared);
    float aK = 0.791f + 0.000463f * aTemperature - 0.000000844f * aTempSquared;
    float aK1 = 6.34f + 0.000775f * aTemperature - 0.0000935f * aTempSquared;
    float aK2 = 1.09f + 0.0284f * aTemperature - 0.0000904f * aTempSquared;
    float aPart1 = 1800.0f / aW;
    float aPart2 = (aK * aRelHumidity) / (1.0f - (aK * aRelHumidity));
    float aPart3 =  ((aK1 * aK * aRelHumidity) + 
                     2 * aK1 * aK2 * pow(aK, 2) * pow(aRelHumidity, 2)) /
                                                (1 + (aK1 * aK * aRelHumidity) + aK1 * aK2 * pow(aK, 2) * pow(aRelHumidity, 2));
    float aFinal = aPart1 * (aPart2 + aPart3);
//                                ((aK1 * aK * aRelHumidity) + 
  //                               2 * aK1 * aK2 * pow(aK, 2) * pow(aRelHumidity, 2)) /
    //                            (1 + (aK1 * aK * aRelHumidity) + aK1 * aK2 * pow(aK, 2) * pow(aRelHumidity, 2)));
    
	myGapSize.text = [NSString stringWithFormat:@"%.3f", aFinal];
}
@end
