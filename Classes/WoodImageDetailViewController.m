//
//  WoodImageDetailViewController.m
//  WoodTek
//
//  Created by matt on 2/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WoodImageDetailViewController.h"


@implementation WoodImageDetailViewController

@synthesize myDetailedWoodImage;
@synthesize myImageName;

- (void)viewDidLoad {
	[super viewDidLoad];
	UIImage *anImage = [UIImage imageNamed:myImageName];
	if(anImage != nil)
	{
		self.myDetailedWoodImage.image = anImage;
	}
}
- (void)setDetailedView:(NSString *)theImageName
{
	myImageName = theImageName;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
	[self.myDetailedWoodImage release];
    [super dealloc];
}


@end
