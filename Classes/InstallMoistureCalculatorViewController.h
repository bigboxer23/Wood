//
//  InstallMoistureCalculatorViewController.h
//  WoodTek
//
//  Created by matt on 1/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractCalculatorViewController.h"

@interface InstallMoistureCalculatorViewController : AbstractCalculatorViewController
{
    IBOutlet UILabel *myMoistureGain;
}
@property (nonatomic, retain) UILabel *myMoistureGain;

@end
