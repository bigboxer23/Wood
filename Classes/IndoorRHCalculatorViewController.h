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

@property (nonatomic, retain) UITextField *myWaterVapor;

@end
