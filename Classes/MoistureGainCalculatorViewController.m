//
//  MoistureGainCalculatorViewController.m
//  FlooringApp
//
//  Created by matt on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MoistureGainCalculatorViewController.h"


@implementation MoistureGainCalculatorViewController

@synthesize myBottomMoisture;
@synthesize myProjectedMoistureContent;
@synthesize myProjectedGapAtNormal;

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.myBottomMoisture addTarget:self
							  action:@selector(textFieldDoneEditing:)
					forControlEvents:UIControlEventEditingDidEndOnExit];
}

- (void)dealloc {
	[super dealloc];
	[myBottomMoisture release];
	[myProjectedMoistureContent release];
	[myProjectedGapAtNormal release];
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
	/*	 
	$M9			= 330 + 0.452 * aIndoorTemp + 0.00415 * pow(aIndoorTemp, 2);
	$N9			= 0.791 + 0.000463 * aIndoorTemp - 0.000000844 * pow(aIndoorTemp, 2);
	$O9			= 6.34 + 0.000775 * aIndoorTemp - 0.0000935 * pow(aIndoorTemp, 2);
	$P9			= 1.09 + 0.0284 * aIndoorTemp - 0.0000904 * pow(aIndoorTemp, 2);
	$V9			=	(aRelativeHumidity) / 100;				
	$S9 		= $O9*$P9*pow($N9,2)*pow($V9,2);
	$Q9			= $N9*$V9;
	$R9			= $O9*$Q9;
	$M6 		= 1800/$M9*(($Q9/(1-$Q9))+(($R9+2*$S9)/(1+$R9+$S9)));				
		
	$O16		= $I11;
	
	if(aExposure < 31)
	{
		$O18 = 1.6 / 30 * aExposure + aInstallMoistureContent;
	}
	else if(aExposure < 61)
	{
		$O18 = aInstallMoistureContent+ 1.6 +0.5 / 30 * (aExposure - 30);
	}
	else if(aInstallMoistureContent + 2.1 + 3.8 / 20 * (aExposure - 60) < $O16)
	{
		$O18 = aInstallMoistureContent + 2.1 + 3.8 / 20 * (aExposure - 60);
	}
	else
	{
		$O18 = $O16;
	}
	
	$I14 		= $O18 > $M6 ? $M6 : $O18;
		
	$S_B21 	= ($I14 - aInstallMoistureContent) * (aMoistureCoef);
	$S_B22	=	$S_B21 * (($S_B4*12) + $S_B5);				
	$S_B23	= $S_B21 * aBoardWidth;
	$S_B12	= abs($S_B23);
	
	$I15	= $S_B12;
	
	$this->m_values['pmme'] 							= sprintf("%0.2f",$I11);
	$this->m_values['projectedmoisture'] 	= sprintf("%0.2f",$I14);				
	$this->m_values['projectedgap']				= sprintf("%0.3f",$I15);*/
	
	float aRelativeHumidity = [myIndoorTemp.text floatValue];
	float aIndoorTemp = [myRelativeHumidy.text floatValue];
	float aInstallMoistureContent = [myInstallMoistureCont.text floatValue];
	float aBoardWidth = [myBoardWidth.text floatValue];
	float aExposure = [myBottomMoisture.text floatValue];

	float M9 = 330.0f + 0.452f * aIndoorTemp + 0.00415f * pow(aIndoorTemp, 2);
	
	float N9	= 0.791f + 0.000463f * aIndoorTemp - 0.000000844f * pow(aIndoorTemp, 2);
	float O9	= 6.34f + 0.000775f * aIndoorTemp - 0.0000935f * pow(aIndoorTemp, 2);
	float P9	= 1.09f + 0.0284f * aIndoorTemp - 0.0000904f * pow(aIndoorTemp, 2);
	float V9	=	(aRelativeHumidity) / 100.0f;				
	float S9 = O9 * P9 * pow(N9, 2) * pow(V9, 2);
	float Q9	= N9 * V9;
	float R9	= O9 * Q9;
	float M6 = 1800.0f / M9 * ((Q9 / (1 - Q9)) + ((R9 + 2 * S9) / (1 + R9 + S9)));
	
	myGapSize.text = [NSString stringWithFormat:@"%.2f", M6];
	float O18 = -0.0011f;
	
	if(aExposure < 31)
	{
		O18 = 1.6 / 30 * aExposure + aInstallMoistureContent;
	}
	else if(aExposure < 61)
	{
		O18 = myDimensionalChangeCoefficient + 1.6 +0.5 / 30 * (aExposure - 30);
	}
	/*else if(aInstallMoistureContent + 2.1 + 3.8 / 20 * (aExposure - 60) < O16)
	{
		O18 = aInstallMoistureContent + 2.1 + 3.8 / 20 * (aExposure - 60);
	}
	else
	{
		O18 = O16;
	}*/
	float I14 = O18 > M6 ? M6 : O18;
	myProjectedMoistureContent.text = [NSString stringWithFormat:@"%.2f", I14];
	float S_B21 	= (I14 - aInstallMoistureContent) * (myDimensionalChangeCoefficient);
	//float S_B22	=	S_B21 * ((S_B4 * 12) + S_B5);				
	float S_B23	= S_B21 * aBoardWidth;
	float S_B12	= fabs(S_B23);
	myProjectedGapAtNormal.text = [NSString stringWithFormat:@"%.3f", S_B12];

}

@end
