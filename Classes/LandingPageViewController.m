//
//  LandingPageViewController.m
//  WoodTek
//
//  Created by matt on 12/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LandingPageViewController.h"


@implementation LandingPageViewController
@synthesize myDisclaimerViewController;
@synthesize myInformationTableViewController;
@synthesize myCalculatorButton;
@synthesize myDisclaimerButton;
@synthesize myInformationButton;
@synthesize myCalculatorsTabController;
@synthesize myRightHandButton;

- (IBAction) buttonPressed:(id)sender
{
	if(myRightHandButton == NULL)
	{
		myRightHandButton = [[[UIBarButtonItem alloc]
							  initWithTitle:@"Help" style:UIBarButtonItemStylePlain target:self action:@selector(notifyToHideKeyboard)] autorelease];
		[[myCalculatorsTabController navigationItem] setRightBarButtonItem:myRightHandButton];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTitleToDone) name:@"setTitleToDone" object:nil]; 
	}
	if(sender == myCalculatorButton)
    {
		CalculatorTableViewController *aCalcTableController = [[CalculatorTableViewController alloc] initWithNibName:@"CalculatorTableViewController" bundle:nil];
		[aCalcTableController setTitle:@"Calculators"];
		[self.navigationController pushViewController:aCalcTableController animated:YES];
		[aCalcTableController release];
		//[[self navigationController] pushViewController:myCalculatorsTabController animated:YES];
    } else if(sender == myDisclaimerButton)
	{
		[[self navigationController] pushViewController:myDisclaimerViewController animated:YES];
	} else if(sender == myInformationButton)
	{
		[[self navigationController] pushViewController:myInformationTableViewController animated:YES];
	}
	[[self navigationController] setNavigationBarHidden:FALSE animated:NO];



}

-(void)notifyToHideKeyboard
{
	if([[myRightHandButton title]  isEqualToString:@"Done"])
	{
		[myRightHandButton setTitle:@"Help"];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"TopDoneTouched" object:nil];
		return;
	}
	[[NSNotificationCenter defaultCenter] postNotificationName:@"helpTouched" object:[myCalculatorsTabController selectedViewController]];
}

-(void)setTitleToDone
{
	[self.myRightHandButton setTitle:@"Done"];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[myCalculatorsTabController release];
	[myCalculatorButton release];
	[myDisclaimerButton release];
	[myInformationButton release];
	[myDisclaimerViewController release];
	[myRightHandButton release];
    [super dealloc];
}


@end
