//
//  LandingPageViewController.h
//  WoodTek
//
//  Created by matt on 12/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisclaimerViewController.h"
#import "InformationTableViewController.h"
#import "CalculatorTableViewController.h"

@interface LandingPageViewController : UIViewController {
	UIButton *myCalculatorButton;
	UIButton *myDisclaimerButton;
	UIButton *myInformationButton;
	UIBarButtonItem *myRightHandButton;
	UITabBarController *myCalculatorsTabController;
	InformationTableViewController *myInformationTableViewController;
	DisclaimerViewController *myDisclaimerViewController;

}
@property (nonatomic, retain) IBOutlet UIButton *myCalculatorButton;
@property (nonatomic, retain) IBOutlet UIButton *myDisclaimerButton;
@property (nonatomic, retain) IBOutlet UIButton *myInformationButton;

@property (nonatomic, retain) IBOutlet DisclaimerViewController *myDisclaimerViewController;
@property (nonatomic, retain) IBOutlet InformationTableViewController *myInformationTableViewController;
@property (nonatomic, retain) UIBarButtonItem *myRightHandButton;

@property (nonatomic, retain) IBOutlet UITabBarController *myCalculatorsTabController;

- (IBAction) buttonPressed:(id)sender;

@end
