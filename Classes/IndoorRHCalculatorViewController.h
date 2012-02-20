//
//  IndoorRHCalculatorViewController.h
//  WoodTek
//
//  Created by matt on 1/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractCalculatorViewController.h"

@interface IndoorRHCalculatorViewController : AbstractCalculatorViewController
{
    IBOutlet UITextField *myWaterVapor;
}

extern const float P_ATM;
extern const float A1;
extern const float A2;
extern const float A3;
extern const float A4;
extern const float A5;
extern const float A6;
extern const float B1;
extern const float B2;
extern const float B3;
extern const float B4;

@property (nonatomic, retain) UITextField *myWaterVapor;
+(float) HumidRatio:(float) theDBTemp RH: (float) theRH;
+(float) VaporPresSat:(float) theDBTemp;
+(float) Log10:(float) theArg;
+(float) RHFromHumid:(float) theDBTemp Ratio:(float) theHumidRatio;
+(float) VolAir:(float) theDBTemp RH:(float) theRH;
+(float) MoistureGen:(float) theInRH DB:(float) theInDBTemp cfm:(float) theCfm ODB:(float) theOutDBTemp ORH:(float) theOutRH;


@end
