//
//  InformationTableViewController.h
//  WoodTek
//
//  Created by matt on 2/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubSpeciesInformationTableViewController.h"

@interface InformationTableViewController : UITableViewController  {
	NSDictionary *myData;
	NSDictionary *myBundleData;
	NSArray *mySortedSpeciesArray;
}

@property (nonatomic, retain) NSDictionary *myBundleData;
@property (nonatomic, retain) NSDictionary *myData;
@property (nonatomic, retain) NSArray *mySortedSpeciesArray;

@end
