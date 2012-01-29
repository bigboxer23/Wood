//
//  CuppingCalculatorViewController.m
//  FlooringApp
//
//  Created by matt on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CuppingCalculatorViewController.h"


@implementation CuppingCalculatorViewController

@synthesize myBottomMoisture;

- (void)dealloc {
	[self.myBottomMoisture release];
	[super dealloc];
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
	if(sender == self.myBottomMoisture)
	{
		[myMainView setFrame:CGRectMake(0, -120, myMainView.frame.size.width, myMainView.frame.size.height)];
	}
	[UIView commitAnimations];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {	
	if(textField == self.myBottomMoisture)
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
	float aTopMoisureContent = [myIndoorTemp.text floatValue];
	float aBoardThickness = [myRelativeHumidy.text floatValue];
	float aInstallMoistureContent = [myInstallMoistureCont.text floatValue];
	float aBoardWidth = [myBoardWidth.text floatValue];
	float aBottomMoistureContent = [self.myBottomMoisture.text floatValue];
	//float aTempSquared = pow(aTemp, 2);
	
	/*$b4 	= $this->m_values['boardwidth'];
	$b5 	= $this->m_values['installmoisture'];
	$b6 	= $this->m_values['boardthickness'];
	$b7 	= $this->m_values['coefficient'];
	$b8 	= $this->m_values['topmoisture'];
	$b9 	= $this->m_values['bottommoisture'];
	
	 $b11 	= $b4-$b5*$b7*$b4;
	
	$b19	= $b11+($b7*$b8*$b11);
	$b20	= $b11+($b7*$b9*$b11);			
	$b21	= ($b19*$b6)/($b20-$b19);
	$b18  = $b19/$b21;			
	$b22	= $b21 * cos($b18 * 0.5);
	
	$b14	= $b21 - $b22;
	$this->m_values['cuppingfactor'] = sprintf("%0.3f",$b14);
	 
	 
	 $b11 	= boardwidth - installmoisture * coefficient * boardwidth;
	 $b19	= $b11+(coefficient * $topmoisture * $b11);
	 $b20	= $b11+(coefficient * bottommoisture * $b11);			
	 $b21	= ($b19*$boardthickness)/($b20-$b19);
	 $b18  = $b19/$b21;			
	 $b22	= $b21 * cos($b18 * 0.5);
	 
	 $b14	= $b21 - $b22;
	 $this->m_values['cuppingfactor'] = sprintf("%0.3f",$b14);
	 */
	
	float b11 = aBoardWidth - (aInstallMoistureContent * myDimensionalChangeCoefficient * aBoardWidth);
	float b19 = b11 + (myDimensionalChangeCoefficient * aTopMoisureContent * b11);
	float b20 = b11 + (myDimensionalChangeCoefficient * aBottomMoistureContent * b11);
	float b21 = (b19 * aBoardThickness) / (b20 - b19);
	float b18 = b19 / b21;
	float b22 = b21 * cosf(b18 / 2);
	
	float b14 = b21 - b22;
	myGapSize.text = [NSString stringWithFormat:@"%.4f", b14];
}

@end
