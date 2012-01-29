//
//  FlooringAppAppDelegate.m
//  FlooringApp
//
//  Created by matt on 7/26/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "FlooringAppAppDelegate.h"
#import "LandingPageViewController.h"

@implementation FlooringAppAppDelegate

@synthesize myMainWindow;
@synthesize myNavController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[myMainWindow addSubview:myNavController.view];
	//[myNavController setNavigationBarHidden:TRUE animated:NO];
    [myMainWindow makeKeyAndVisible];
	return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	if ([viewController class] == [LandingPageViewController class])
	{
		//[myNavController setNavigationBarHidden:TRUE animated:NO];
	}

}

- (void)dealloc {
    [myMainWindow release];
	[myNavController release];
    [super dealloc];
}


@end
