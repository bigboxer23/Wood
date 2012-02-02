//
//  CalculatorTableViewController.m
//  WoodTek
//
//  Created by matt on 2/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorTableViewController.h"


@implementation CalculatorTableViewController

@synthesize myCalculatorViewControllers;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	self.myCalculatorViewControllers = [[[NSArray alloc] initWithObjects:
										@"Cupping Calculator",
										@"Gapping Calculator",
										@"Crowning Calculator",
										@"Moisture Gain Calculator",
										@"Room Expansion Calculator",
                                         @"Equilibrium Moisture Content Calculator",
                                         @"Install Moisture Calculator",
                                         @"Indoor Relative Humidity Calculator",
										nil] sortedArrayUsingSelector:@selector(compare:)];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.myCalculatorViewControllers count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    NSUInteger aRow = [indexPath row];
	[cell.textLabel setText: [self.myCalculatorViewControllers objectAtIndex:aRow]];
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger aRow = [indexPath row];
	NSString *aControllerName = [self.myCalculatorViewControllers objectAtIndex:aRow];
	UIViewController *aController = [self getViewController:aControllerName];
	[aController setTitle:aControllerName];
	[self.navigationController pushViewController:aController animated:YES];
	[aController release];
}

- (UIViewController *) getViewController:(NSString *)theViewController
{
	if([theViewController isEqual:@"Cupping Calculator"])
	{
		return [[CuppingCalculatorViewController alloc] initWithNibName:@"CuppingCalculatorView" bundle:nil];
	} else if([theViewController isEqual:@"Gapping Calculator"])
	{
		return [[GappingCalculatorViewController alloc] initWithNibName:@"GappingCalculatorView" bundle:nil];
	} else if([theViewController isEqual:@"Crowning Calculator"])
	{
		return [[CrowningCalculatorViewController alloc] initWithNibName:@"CrowningCalculatorView" bundle:nil];
	} else if([theViewController isEqual:@"Moisture Gain Calculator"])
	{
		return [[MoistureGainCalculatorViewController alloc] initWithNibName:@"MoistureGainCalculator" bundle:nil];
	} else if([theViewController isEqual:@"Room Expansion Calculator"])
	{
		return [[RoomExpansionViewController alloc] initWithNibName:@"RoomExpansionView" bundle:nil];
	} else if([theViewController isEqual:@"Equilibrium Moisture Content Calculator"])
    {
        return [[EMCCalculatorViewController alloc] initWithNibName:@"EMCCalculatorView" bundle:nil];
    } else if([theViewController isEqual:@"Install Moisture Calculator"])
    {
        return [[InstallMoistureCalculatorViewController alloc] initWithNibName:@"InstallMoistureCalculatorView" bundle:nil];
    } else if([theViewController isEqual: @"Indoor Relative Humidity Calculator"])
    {
        return [[IndoorRHCalculatorViewController alloc] initWithNibName:@"IndoorRHCalculatorView" bundle:nil];
    }
	return NULL;
}
#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[myCalculatorViewControllers release];
    [super dealloc];
}


@end

