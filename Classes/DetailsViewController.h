//
//  DetailsViewController.h
//  WoodTek
//
//  Created by matt on 2/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "WoodImageDetailViewController.h"

@interface DetailsViewController : UIViewController<UIGestureRecognizerDelegate> {
	NSDictionary *myData;
	NSString *mySpecies;
	NSString *mySubSpecies;
	UIScrollView *myScrollView;
	UIImageView *myImageView;
}

@property (nonatomic, retain) NSString *mySpecies;
@property (nonatomic, retain) NSString *mySubSpecies;
@property (nonatomic, retain) NSDictionary *myData;
@property (nonatomic, retain) IBOutlet UIScrollView *myScrollView;
@property (nonatomic, retain) IBOutlet UIImageView *myImageView;

- (void)setData:(NSDictionary *)theData;
- (void)setSpecies:(NSString *)theSpecies;
- (void)setSubSpecies:(NSString *)theSubSpecies;
- (void) woodImagePressed;

@end
