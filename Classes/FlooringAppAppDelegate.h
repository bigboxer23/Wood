//
//  FlooringAppAppDelegate.h
//  FlooringApp
//
//  Created by matt on 7/26/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlooringAppAppDelegate : NSObject <UIApplicationDelegate, UINavigationControllerDelegate> {
    UIWindow *myMainWindow;
	UINavigationController *myNavController;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *myMainWindow;
@property (nonatomic, retain) IBOutlet UINavigationController *myNavController;

@end

