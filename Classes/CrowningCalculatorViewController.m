//
//  CrowningCalculatorViewController.m
//  FlooringApp
//
//  Created by matt on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CrowningCalculatorViewController.h"


@implementation CrowningCalculatorViewController

@synthesize myBottomMoisture;

- (void)dealloc {
	[super dealloc];
	[myBottomMoisture release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.myBottomMoisture addTarget:self
							  action:@selector(textFieldDoneEditing:)
					forControlEvents:UIControlEventEditingDidEndOnExit];
	
}

- (IBAction) touchTopDone:(id)sender
{
	[self.myBottomMoisture resignFirstResponder];
	[super touchTopDone:sender];
}

-(IBAction)inputTouched:(id)sender
{
	[[self navigationItem].rightBarButtonItem setTitle:@"Done"];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.4];
	[UIView setAnimationDelegate:self];
	if(sender == myBoardWidth)
	{
		[myMainView setFrame:CGRectMake(0, 40, myMainView.frame.size.width, myMainView.frame.size.height)];
	}
	if(sender == myIndoorTemp)
	{
		[myMainView setFrame:CGRectMake(0, -80, myMainView.frame.size.width, myMainView.frame.size.height)];
	}
	if(sender == myRelativeHumidy)
	{
		[myMainView setFrame:CGRectMake(0, -40, myMainView.frame.size.width, myMainView.frame.size.height)];
	}
	if(sender == myInstallMoistureCont)
	{
		[myMainView setFrame:CGRectMake(0, 0, myMainView.frame.size.width, myMainView.frame.size.height)];
	}
	if(sender == myBottomMoisture)
	{
		[myMainView setFrame:CGRectMake(0, -120, myMainView.frame.size.width, myMainView.frame.size.height)];
	}
	[UIView commitAnimations];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {	
	if(textField == myBottomMoisture)
	{
		if (myNumberKeyPad) {
			myNumberKeyPad.currentTextField = textField;
		}
	}
    return [super textFieldShouldBeginEditing:textField] || textField == myBottomMoisture;
}

-(void) updateCalculations
{
	
	// B4		= boardwidth
	// B5 	= installmoisture
	// B6		= boardthickness
	// B7		= coefficiant
	// B8		= topboardthickness
	// B9 	= bottomboardthickness
	// B11	=	B4-B5*B7*B4
	// B14 	= B21-B22 = crowningfactor
	// B18 	=	B19/B21
	// B19 	= B11+(B7*B8*B11)
	// B20 	= B11+(B7*B9*B11)
	// B21 	= (B20*B6)/(B19-B20)
	// B22 	= B21*COS(B18*0.5)
	
	float aTopMoisureContent = [myIndoorTemp.text floatValue];
	float aBoardThickness = [myRelativeHumidy.text floatValue];
	float aInstallMoistureContent = [myInstallMoistureCont.text floatValue];
	float aBoardWidth = [myBoardWidth.text floatValue];
	float aBottomMoistureContent = [myBottomMoisture.text floatValue];
	
	float b11 = aBoardWidth - (aInstallMoistureContent * myDimensionalChangeCoefficient * aBoardWidth);
	float b19 = b11 + (myDimensionalChangeCoefficient * aTopMoisureContent * b11);
	float b20 = b11 + (myDimensionalChangeCoefficient * aBottomMoistureContent * b11);
	float b21 = (b20 * aBoardThickness) / (b19 - b20);
	float b18 = b19 / b21;
	float b22 = b21 * cosf(b18 / 2);
	
	float b14 = b21 - b22;
	myGapSize.text = [NSString stringWithFormat:@"%.4f", b14];
}
@end
