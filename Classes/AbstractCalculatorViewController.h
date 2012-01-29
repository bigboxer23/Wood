//
//  AbstractCalculatorViewController.h
//  FlooringApp
//
//  Created by matt on 9/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#import "NumberKeypadDecimalPoint.h"

#define kBoardCategory	0
#define	kBoardSpecies	1
#define kSawn			2

@interface AbstractCalculatorViewController : UIViewController<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
	IBOutlet UIScrollView *myMainView;
	IBOutlet UITextField *myBoardCategory;
	IBOutlet UITextField *myBoardSpecies;
	IBOutlet UITextField *mySawn;
	IBOutlet UITextField *myBoardWidth;
	IBOutlet UITextField *myIndoorTemp;
	IBOutlet UITextField *myRelativeHumidy;
	IBOutlet UITextField *myInstallMoistureCont;
	IBOutlet UILabel *myGapSize;
	IBOutlet UILabel *myCurMoistureCont;
	IBOutlet UIPickerView *myBoardCategoryPicker;
	IBOutlet UIViewController *myHelpViewController;
	NumberKeypadDecimalPoint *myNumberKeyPad;
	IBOutlet UIImageView *myImageView;

	
	NSDictionary *myData;
	NSMutableArray *myBoardCategoryData;
	int myState;
	float myDimensionalChangeCoefficient;
	BOOL myIsHidden;

}

@property (nonatomic, retain) UIViewController *myHelpViewController;
@property (nonatomic, retain) NumberKeypadDecimalPoint *myNumberKeyPad;
@property (nonatomic, retain) UIScrollView *myMainView;
@property (nonatomic, retain) UITextField *myBoardCategory;
@property (nonatomic, retain) UITextField *myBoardSpecies;
@property (nonatomic, retain) UITextField *mySawn;
@property (nonatomic, retain) UITextField *myBoardWidth;
@property (nonatomic, retain) UITextField *myIndoorTemp;
@property (nonatomic, retain) UITextField *myRelativeHumidy;
@property (nonatomic, retain) UITextField *myInstallMoistureCont;
@property (nonatomic, retain) UILabel *myGapSize;
@property (nonatomic, retain) UILabel *myCurMoistureCont;
@property (nonatomic, retain) UIImageView *myImageView;
@property (nonatomic, retain) UIPickerView *myBoardCategoryPicker;
@property (nonatomic, retain) NSMutableArray *myBoardCategoryData;
@property (nonatomic, retain) NSDictionary *myData;

//- (IBAction) textFieldDoneEditing:(id)sender;
- (IBAction) boardCategoryTouch:(id)sender;
- (IBAction) touchTopDone:(id)sender;
- (IBAction) inputTouched:(id)sender;

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
-(BOOL)hasValidCut:(NSArray *)theArray;
-(void)loadDependantCategories;

@end
