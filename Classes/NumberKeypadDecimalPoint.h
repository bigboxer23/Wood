//
//  DecimalPointButton.h
//  FlooringApp
//
//  Created by matt on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *	The UIButton that will have the decimal point on it
 */
@interface DecimalPointButton : UIButton {
	
}

+ (DecimalPointButton *) decimalPointButton;

@end


/**
 *	The class used to create the keypad
 */
@interface NumberKeypadDecimalPoint : NSObject {
	
	UITextField *currentTextField;
	
	DecimalPointButton *decimalPointButton;
	
	NSTimer *showDecimalPointTimer;
}

@property (nonatomic, retain) NSTimer *showDecimalPointTimer;
@property (nonatomic, retain) DecimalPointButton *decimalPointButton;

@property (assign) UITextField *currentTextField;

#pragma mark -
#pragma mark Show the keypad

+ (NumberKeypadDecimalPoint *) keypadForTextField:(UITextField *)textField; 

- (void) removeButtonFromKeyboard;

@end