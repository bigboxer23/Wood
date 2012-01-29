//
//  MoistureGainCalculatorViewController.h
//  FlooringApp
//
//  Created by matt on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractCalculatorViewController.h"


@interface MoistureGainCalculatorViewController : AbstractCalculatorViewController 
{
	IBOutlet UITextField *myBottomMoisture;
	IBOutlet UILabel *myProjectedMoistureContent;
	IBOutlet UILabel *myProjectedGapAtNormal;
}

@property (nonatomic, retain) UITextField *myBottomMoisture;
@property (nonatomic, retain) UILabel *myProjectedMoistureContent;
@property (nonatomic, retain) UILabel *myProjectedGapAtNormal;

@end
