//
//  RoomExpansionViewController.m
//  FlooringApp
//
//  Created by matt on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RoomExpansionViewController.h"


@implementation RoomExpansionViewController

@synthesize myBottomMoisture;
@synthesize myBoardDimensionalChange;

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.myBottomMoisture addTarget:self
							  action:@selector(textFieldDoneEditing:)
					forControlEvents:UIControlEventEditingDidEndOnExit];
}

- (void)dealloc {
	[super dealloc];
	[myBottomMoisture release];
	[myBoardDimensionalChange release];
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
		return YES;
	}
    return [super textFieldShouldBeginEditing:textField];
}

-(void) updateCalculations
{
	//$roomWidth 	= $this->m_values['roomwidthfeet'] * 12 + $this->m_values['roomwidthinches'];
	//$b21 				= ($this->m_values['maxmoisture'] - $this->m_values['minmoisture']) * $this->m_values['coefficient'];
	//$b23 				= $b21 * $this->m_values['boardwidth'];
	
	//$this->m_values['projectedexpansion'] 		= sprintf("%0.3f",($roomWidth * $b21));
	//$this->m_values['boarddimensionalchange'] = sprintf("%0.3f",$b23);		
	//$this->m_values['boarddimensionalchange'] = $b23;	
	float aCurrentMoistureContent = [myIndoorTemp.text floatValue];
	float aRoomWidthIn = [myRelativeHumidy.text floatValue];
	float aRoomWidthFt = [myInstallMoistureCont.text floatValue];
	float aBoardWidth = [myBoardWidth.text floatValue];
	float aProjMaxMoisture = [myBottomMoisture.text floatValue];
	
	float aRoomWidth = aRoomWidthIn + (aRoomWidthFt * 12);
	float b21 = (aProjMaxMoisture - aCurrentMoistureContent) * myDimensionalChangeCoefficient;
	float b23 = b21 * aBoardWidth;
	
	myGapSize.text = [NSString stringWithFormat:@"%.3f", (aRoomWidth * b21)];
	myBoardDimensionalChange.text = [NSString stringWithFormat:@"%.3f", b23];
}
@end
