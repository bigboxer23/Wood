//
//  WoodImageDetailViewController.h
//  WoodTek
//
//  Created by matt on 2/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WoodImageDetailViewController : UIViewController {
	UIImageView *myDetailedWoodImage;
	NSString *myImageName;
}
@property (nonatomic, retain) IBOutlet UIImageView *myDetailedWoodImage;
@property (nonatomic, retain) NSString *myImageName;

- (void)setDetailedView:(NSString *)theImageName;

@end
