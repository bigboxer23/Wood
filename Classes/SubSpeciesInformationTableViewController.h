//
//  SubSpeciesInformationTableViewController.h
//  WoodTek
//
//  Created by matt on 2/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailsViewController.h"

@interface SubSpeciesInformationTableViewController : UITableViewController {
	NSArray *mySubSpecies;
	NSDictionary *myData;
	NSString *mySpecies;
}
@property (nonatomic, retain) NSArray *mySubSpecies;
@property (nonatomic, retain) NSDictionary *myData;
@property (nonatomic, retain) NSString *mySpecies;

-(void)setSpecies:(NSString *) theSpecies;
- (void)setSubSpeciesArray:(NSArray *)theSubSpecies;
- (void)setData:(NSDictionary *)theData;

@end
