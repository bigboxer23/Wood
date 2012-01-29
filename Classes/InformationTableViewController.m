//
//  InformationTableViewController.m
//  WoodTek
//
//  Created by matt on 2/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InformationTableViewController.h"


@implementation InformationTableViewController

@synthesize myData;
@synthesize mySortedSpeciesArray;
@synthesize myBundleData;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	NSBundle *aBundle = [NSBundle mainBundle];
	NSString *aPlistPath = [aBundle pathForResource:@"data" ofType:@"plist"];
	self.myBundleData =[[NSDictionary alloc] initWithContentsOfFile:aPlistPath];
	self.mySortedSpeciesArray = [NSArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I",
								 @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V",
								 @"W", @"X", @"Y", @"Z", nil];
	NSMutableDictionary *anIndexedDictionary = [NSMutableDictionary dictionaryWithCapacity:[self.mySortedSpeciesArray count]];
	for(NSString *anIndex in self.mySortedSpeciesArray)
	{
		NSMutableArray *aSubArray = [NSMutableArray arrayWithCapacity:0];
		for(NSString *aSpecies in [self.myBundleData allKeys])
		{
			if([aSpecies hasPrefix:anIndex])
			{
				[aSubArray addObject:aSpecies];
			}
		}
		[anIndexedDictionary setObject:aSubArray forKey:anIndex];
	}
	self.myData = anIndexedDictionary;
	//self.myData = [[NSDictionary alloc] initWithContentsOfFile:aPlistPath];
	//self.mySortedSpeciesArray = [[self.myData allKeys] sortedArrayUsingSelector:@selector(compare:)];
	[aBundle release];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.mySortedSpeciesArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSString *aKey = [self.mySortedSpeciesArray objectAtIndex:section];
	return [[self.myData objectForKey:aKey] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger aSection = [indexPath section];
	NSUInteger aRow = [indexPath row];
	NSString *aKey = [self.mySortedSpeciesArray objectAtIndex:aSection];
	NSArray *aNameSection = [self.myData objectForKey:aKey];
	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	//[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [cell.textLabel setText:[aNameSection objectAtIndex:aRow]];
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
	return self.mySortedSpeciesArray;
}

/**
 * Gives us the index
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return [self.mySortedSpeciesArray objectAtIndex:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger aSection = [indexPath section];
	NSUInteger aRow = [indexPath row];
	NSString *aKey = [self.mySortedSpeciesArray objectAtIndex:aSection];
	NSArray *aNameSection = [self.myData objectForKey:aKey];
	NSString *aSpecies = [aNameSection objectAtIndex:aRow];
    
    SubSpeciesInformationTableViewController *aSubViewController = [[SubSpeciesInformationTableViewController alloc] initWithNibName:@"SubSpeciesInformationTableViewController" bundle:nil];
	[aSubViewController setTitle:aSpecies];
	[aSubViewController setSpecies:aSpecies];
	[aSubViewController setData:self.myBundleData];
	[aSubViewController setSubSpeciesArray:[[self.myBundleData objectForKey:aSpecies] allKeys]];
    [self.navigationController pushViewController:aSubViewController animated:YES];
    [aSubViewController release];
    
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[self.myData release];
	[self.myBundleData release];
	[self.mySortedSpeciesArray release];
    [super dealloc];
}
@end

