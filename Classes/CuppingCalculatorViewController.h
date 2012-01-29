//
//  CuppingCalculatorViewController.h
//  FlooringApp
//
//  Created by matt on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractCalculatorViewController.h"


@interface CuppingCalculatorViewController : AbstractCalculatorViewController {
	IBOutlet UITextField *myBottomMoisture;
}

@property (nonatomic, retain) UITextField *myBottomMoisture;

@end
