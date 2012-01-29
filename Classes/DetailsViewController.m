//
//  DetailsViewController.m
//  WoodTek
//
//  Created by matt on 2/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailsViewController.h"


@implementation DetailsViewController

@synthesize myData;
@synthesize mySpecies;
@synthesize mySubSpecies;
@synthesize myScrollView;
@synthesize myImageView;

- (void)setData:(NSDictionary *)theData
{
	self.myData = theData;
}

- (void)setSpecies:(NSString *)theSpecies
{
	self.mySpecies = theSpecies;
}

- (void)setSubSpecies:(NSString *)theSubSpecies
{
	self.mySubSpecies = theSubSpecies;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	NSDictionary *anInformation = [[self.myData objectForKey:self.mySpecies] objectForKey:self.mySubSpecies];
	NSArray *aKeySet = [[anInformation allKeys] sortedArrayUsingSelector:@selector(compare:)];
	int aHeight = 0;
	//self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	//Set the common name, use our key in the dictionary if it isn't set.
	NSString *aCommonName = [anInformation objectForKey:@"Common Name"];
	if(aCommonName == nil)
	{
		aCommonName = [[self.mySubSpecies stringByAppendingString:@" "] stringByAppendingString:self.mySpecies];
	}
	UILabel *anInformationLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, aHeight, 310, 20)];
	anInformationLabel.adjustsFontSizeToFitWidth = YES;
	anInformationLabel.text = [@"Common Name: " stringByAppendingString:aCommonName];
	anInformationLabel.textColor = [UIColor colorWithWhite:1 alpha:1];
	anInformationLabel.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
	[myScrollView addSubview:anInformationLabel];
	[anInformationLabel release];
	aHeight += 20;
	for(int ai = 0; ai < [aKeySet count]; ai++)
	{
		NSString *aKey = [aKeySet objectAtIndex:ai];
		if([aKey isEqualToString:@"Common Name"] || [aKey isEqualToString:@"Resource"])
		{
			continue;
		}
		UILabel *anInformationLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, aHeight, 310, 20)];
		anInformationLabel.adjustsFontSizeToFitWidth = YES;
		anInformationLabel.text = [[aKey stringByAppendingString: @": "] stringByAppendingString:[anInformation objectForKey:aKey]];
		anInformationLabel.textColor = [UIColor colorWithWhite:1 alpha:1];
		anInformationLabel.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
		//[anInformationLabel minimumFontSize:1.0];
		//anInformationLabel.font = self.myCommonName.font;//[UIFont fontWithName:@"Helvetica" size:17]];//
		[self.myScrollView addSubview:anInformationLabel];
		[anInformationLabel release];
		aHeight += 20;
	}
	NSString *aResourceName = [anInformation objectForKey:@"Resource"];
	if(aResourceName != nil)
	{
		UITextView *aResource = [[UITextView alloc] initWithFrame:CGRectMake(-3, aHeight - 10, 310, 30)];
		aResource.text = [@"Resource: " stringByAppendingString:aResourceName];
		aResource.textColor = [UIColor colorWithWhite:1 alpha:1];
		aResource.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
		aResource.font = [UIFont fontWithName:@"Helvetica" size:17];
		aResource.editable = NO;
		aResource.dataDetectorTypes = UIDataDetectorTypeAll;
		[self.myScrollView addSubview:aResource];
		aHeight += 20;
	}
	self.myScrollView.contentSize = CGSizeMake(320, aHeight);
	UIImage *anImage = [UIImage imageNamed:[[self.mySubSpecies stringByAppendingString:self.mySpecies] stringByAppendingString:@".jpg"]];
	if(anImage != nil)
	{
		self.myImageView.image = anImage;
		self.myImageView.userInteractionEnabled = YES;
		UIGestureRecognizer *aRecognizer;
		aRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(woodImagePressed)];
		[(UITapGestureRecognizer *)aRecognizer setNumberOfTouchesRequired:1];
		aRecognizer.delegate = self;
		[self.myImageView addGestureRecognizer:aRecognizer];
		[aRecognizer release];
	}
	self.myImageView.layer.cornerRadius = 5.0;
	self.myImageView.layer.masksToBounds = YES;
	self.myImageView.layer.borderColor = [UIColor whiteColor].CGColor;
	self.myImageView.layer.borderWidth = 2.0;

}

- (void) woodImagePressed
{
	WoodImageDetailViewController *aDetailViewController = [[WoodImageDetailViewController alloc] initWithNibName:@"WoodImageDetailViewController" bundle:nil];
	NSString *aSpecies = [[self.mySubSpecies stringByAppendingString:self.mySpecies] stringByAppendingString:@".jpg"];
	[aDetailViewController setDetailedView:aSpecies];
	[aDetailViewController setTitle:aSpecies];
    [self.navigationController pushViewController:aDetailViewController animated:YES];
    [aDetailViewController release];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
}

- (void)dealloc {
    [super dealloc];
	[myScrollView release];
	[myImageView release];
}


@end
