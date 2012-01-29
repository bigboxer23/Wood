//
//  SubSpeciesInformationTableViewController.m
//  WoodTek
//
//  Created by matt on 2/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SubSpeciesInformationTableViewController.h"


@implementation SubSpeciesInformationTableViewController

@synthesize mySubSpecies;
@synthesize myData;
@synthesize mySpecies;

#pragma mark -
#pragma mark View lifecycle
- (void)setSubSpeciesArray:(NSArray *)theSubSpecies
{
	self.mySubSpecies = [theSubSpecies sortedArrayUsingSelector:@selector(compare:)];
}

- (void)setData:(NSDictionary *)theData
{
	self.myData = theData;
}

-(void)setSpecies:(NSString *) theSpecies
{
	mySpecies = theSpecies;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.mySubSpecies count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];//UITableViewCellAccessoryDetailDisclosureButton];
    NSUInteger aRow = [indexPath row];
    [cell.textLabel setText: [[self.mySubSpecies sortedArrayUsingSelector:@selector(compare:)] objectAtIndex:aRow]];    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    DetailsViewController *aDetailViewController = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
	NSString *aSubSpecies = [self.mySubSpecies objectAtIndex:[indexPath row]];
	[aDetailViewController setSpecies:self.mySpecies];
	[aDetailViewController setSubSpecies:aSubSpecies];
	[aDetailViewController setData:self.myData];
	NSString *aTitle = nil;
	if([aSubSpecies isEqualToString:self.mySpecies])
	{
		aTitle = aSubSpecies;
	} else {
		aTitle = [[aSubSpecies stringByAppendingFormat:@" "] stringByAppendingFormat:self.mySpecies];
	}

	[aDetailViewController setTitle:aTitle];
    [self.navigationController pushViewController:aDetailViewController animated:YES];
    [aDetailViewController release];
    
}


#pragma mark -
#pragma mark Memory management

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[self.mySubSpecies release];
	[self.mySpecies release];
	[self.myData release];
    [super dealloc];
}


@end

