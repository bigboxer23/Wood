//
//  CalculatorTableViewController.h
//  WoodTek
//
//  Created by matt on 2/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CuppingCalculatorViewController.h"
#import "GappingCalculatorViewController.h"
#import "CrowningCalculatorViewController.h"
#import "MoistureGainCalculatorViewController.h"
#import	"RoomExpansionViewController.h"
#import "EMCCalculatorViewController.h"
#import "InstallMoistureCalculatorViewController.h"

@interface CalculatorTableViewController : UITableViewController {
	NSArray *myCalculatorViewControllers;
}
@property (nonatomic, retain) NSArray *myCalculatorViewControllers;

@end
