//
//  IndoorRHCalculatorViewController.m
//  WoodTek
//
//  Created by matt on 1/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IndoorRHCalculatorViewController.h"

/*  Option Explicit
 
 ' Atmospheric pressure in inches of Mercury
 Const P_ATM = 29.921
 
 Function HumidRatio(DBTemp As Single, RH As Single) As Single
 ' This function returns the Humidity ratio (lbs of water per lb of dry air)
 ' for air with a dry bulb temperature of Temp and a relative humidity of RH,
 ' expressed as a decimal fraction.  The Humidity ratio is returned for normal
 ' atmospheric pressure.
 ' The equations are from pages 161-164 of ASHRAE "Procedure for Determing
 ' Heating and Cooling Loads for Computerizing Energy Calculations."
 
 Dim VPSat As Single   ' Vapor Pressure of saturated air
 
 VPSat = VaporPresSat(DBTemp)
 
 HumidRatio = 0.622 * RH * VPSat / (P_ATM - RH * VPSat)
 
 End Function
 
 Function Log10(Arg As Single) As Single
 ' Computes the Log Base 10 of Arg.
 Log10 = Log(Arg) / 2.30258509
 End Function
 
 Function RHfromHumid(DBTemp As Single, HumidRatio As Single) As Single
 ' Returns the relative humidity as a decimal fraction, given the dry bulb
 ' temperature, Temp, in degrees F and the humidity ratio W (lbs of water per
 ' lb of dry air).
 
 Dim VPSat As Single       ' Vapor pressure of moisture saturated air.
 Dim RH As Single          ' Relative humidity
 VPSat = VaporPresSat(DBTemp)
 
 RH = HumidRatio * P_ATM / VPSat / (0.622 + HumidRatio)
 If RH > 1 Then RH = 1
 RHfromHumid = RH
 
 End Function
 
 Function VaporPresSat(DBTemp As Single) As Single
 ' This function returns the partial pressure of water vapor in saturated
 ' air with dry bulb temperature Temp degrees F.  The returned units are
 ' inches of mercury.
 ' The equations are from pages 161-164 of ASHRAE "Procedure for Determing
 ' Heating and Cooling Loads for Computerizing Energy Calculations."
 
 ' Curve fit constants
 Const A1 = -7.90298
 Const A2 = 5.02808
 Const A3 = -0.00000013816
 Const A4 = 11.344
 Const A5 = 0.0081328
 Const A6 = -3.49149
 
 Const B1 = -9.09718
 Const B2 = -3.56654
 Const B3 = 0.876793
 Const B4 = 0.0060273
 
 Dim AbsT As Single      ' Absolute Temperature in deg Kelvin
 
 ' Intermediate values in curve fit
 Dim P1 As Single, P2 As Single, P3 As Single, P4 As Single
 Dim z As Single
 
 AbsT = (DBTemp + 459.688) / 1.8
 
 ' Curve fit for vapor pressure depends on where AbsT falls w.r.t.
 ' 0 deg C.
 
 If AbsT >= 273.16 Then
 
 ' Above 0 degrees C
 z = 373.16 / AbsT
 P1 = A1 * (z - 1)
 P2 = A2 * Log10(z)
 P3 = A3 * (10 ^ (A4 * (1 - 1 / z)) - 1)
 P4 = A5 * (10 ^ (A6 * (z - 1)) - 1)
 
 Else
 
 ' Less than 0 degrees C
 z = 273.16 / AbsT
 P1 = B1 * (z - 1)
 P2 = B2 * Log10(z)
 P3 = B3 * (1 - 1 / z)
 P4 = Log10(B4)
 
 End If
 
 VaporPresSat = P_ATM * 10 ^ (P1 + P2 + P3 + P4)
 
 End Function
 
 Function VolAir(DBTemp As Single, RH As Single) As Single
 ' Returns the cubic feet of moist air per pound of dry air.
 
 Dim HumRat As Single
 
 HumRat = HumidRatio(DBTemp, RH)
 VolAir = 0.754 * (DBTemp + 459.7) * (1 + 7000 * HumRat / 4360) / P_ATM
 
 End Function
 
 Function IndoorRH(WaterGen As Single, cfm As Single, InDBTemp As
 Single, OutDBTemp As Single, OutRH As Single) As Single
 ' This function returns the indoor relative humidity when WaterGen pounds of
 ' water vapor are released within the house, cfm cubic feet per minute of
 ' air exchange is occurring (cfm is measured at the density of indoor
 ' temperature air), InDBTemp is the indoor dry bulb temperature, OutDBTemp
 ' is the outdoor dry bulb temperature, and OutRH is the outdoor relative
 ' humidity (expressed as a decimal).
 
 Dim OutHumid As Single            ' Outdoor humidity ratio.
 Dim InHumid As Single             ' Indoor humidity ratio
 Dim MassFlow As Single            ' Pounds per day of dry air flow
 Dim InRH As Single                ' Temporary storage for Indoor RH
 Dim i As Integer                  ' Loop counter
 
 OutHumid = HumidRatio(OutDBTemp, OutRH)
 
 ' Need to iterate the calculation because air density depends on Indoor
 ' RH, the value we are ultimately trying to calculate.  Guess initially
 ' that RH is 35%, but go back and redo the calculation once to improve
 ' accuracy.
 InRH = 0.35                        ' Initial guess at indoor RH
 For i = 0 To 1
 
 MassFlow = cfm * 1440 / VolAir(InDBTemp, InRH)
 
 InHumid = OutHumid + WaterGen / MassFlow
 
 InRH = RHfromHumid(InDBTemp, InHumid)
 
 Next i
 
 IndoorRH = InRH
 
 End Function
 
 Function MoistureGen(InRH As Single, InDBTemp As Single, cfm As
 Single, OutDBTemp As Single, OutRH As Single) As Single
 ' Returns the moisture generation rate in pounds per day, given indoor RH and
 ' Temp, outdoor RH and Temp, and air flow in CFM.
 
 Dim MassFlow As Single            ' Pounds per day of dry air flow
 MassFlow = cfm * 1440 / VolAir(InDBTemp, InRH)
 
 Dim OutHumid As Single            ' Outdoor humidity ratio.
 Dim InHumid As Single             ' Indoor humidity ratio
 OutHumid = HumidRatio(OutDBTemp, OutRH)
 InHumid = HumidRatio(InDBTemp, InRH)
 
 MoistureGen = (InHumid - OutHumid) * MassFlow
 
 End Function*/
@implementation IndoorRHCalculatorViewController

const float P_ATM = 29.921f;
const float A1 = -7.90298f;
const float A2 = 5.02808f;
const float A3 = -0.00000013816f;
const float A4 = 11.344f;
const float A5 = 0.0081328f;
const float A6 = -3.49149f;
const float B1 = -9.09718f;
const float B2 = -3.56654f;
const float B3 = 0.876793f;
const float B4 = 0.0060273f;

@synthesize myWaterVapor;

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.myWaterVapor addTarget:self
							  action:@selector(textFieldDoneEditing:)
					forControlEvents:UIControlEventEditingDidEndOnExit];	
}

- (IBAction) touchTopDone:(id)sender
{
	[self.myWaterVapor resignFirstResponder];
	[super touchTopDone:sender];
}

-(IBAction)inputTouched:(id)sender
{
	[[self navigationItem].rightBarButtonItem setTitle:@"Done"];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.4];
	[UIView setAnimationDelegate:self];
	if(sender == myRelativeHumidy)
	{
		[myMainView setFrame:CGRectMake(0, 70, myMainView.frame.size.width, myMainView.frame.size.height)];
	}
	if(sender == myInstallMoistureCont)
	{
		[myMainView setFrame:CGRectMake(0, 30, myMainView.frame.size.width, myMainView.frame.size.height)];
	}
	if(sender == myWaterVapor)
	{
		[myMainView setFrame:CGRectMake(0, -10, myMainView.frame.size.width, myMainView.frame.size.height)];
	}
	[UIView commitAnimations];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {	
	if(textField == myWaterVapor)
	{
		if (myNumberKeyPad) {
			myNumberKeyPad.currentTextField = textField;
		}
	}
    return [super textFieldShouldBeginEditing:textField] || textField == myWaterVapor;
}

- (void)dealloc {
	[super dealloc];
	[myWaterVapor release];
}

/*
 ' This function returns the Humidity ratio (lbs of water per lb of dry air)
 ' for air with a dry bulb temperature of Temp and a relative humidity of RH,
 ' expressed as a decimal fraction.  The Humidity ratio is returned for normal
 ' atmospheric pressure.
 ' The equations are from pages 161-164 of ASHRAE "Procedure for Determing
 ' Heating and Cooling Loads for Computerizing Energy Calculations."
 HumidRatio(DBTemp, RH)
 {
 Dim VPSat = VaporPresSat(DBTemp)
 return 0.622 * RH * VPSat / (P_ATM - RH * VPSat)
 }
 */
+(float) HumidRatio:(float) theDBTemp RH: (float) theRH
{
    theRH = theRH / 100.0f;
    float aVaporPressureSaturation = [self VaporPresSat:theDBTemp];
    return (0.622f * theRH * aVaporPressureSaturation) / (P_ATM - theRH * aVaporPressureSaturation);   
}

/*
 ' This function returns the partial pressure of water vapor in saturated
 ' air with dry bulb temperature Temp degrees F.  The returned units are
 ' inches of mercury.
 ' The equations are from pages 161-164 of ASHRAE "Procedure for Determing
 ' Heating and Cooling Loads for Computerizing Energy Calculations."
 
 VaporPresSat(DBTemp)
 {
 Const A1 = -7.90298
 Const A2 = 5.02808
 Const A3 = -0.00000013816
 Const A4 = 11.344
 Const A5 = 0.0081328
 Const A6 = -3.49149
 Const B1 = -9.09718
 Const B2 = -3.56654
 Const B3 = 0.876793
 Const B4 = 0.0060273
 
 AbsT = (DBTemp + 459.688) / 1.8
 if(AbsT >= 273.16)
 {     
 z = 373.16 / AbsT
 P1 = A1 * (z - 1)
 P2 = A2 * Log10(z)
 P3 = A3 * (10 ^ (A4 * (1 - 1 / z)) - 1)
 P4 = A5 * (10 ^ (A6 * (z - 1)) - 1)
 } 
 else
 {     
 z = 273.16 / AbsT
 P1 = B1 * (z - 1)
 P2 = B2 * Log10(z)
 P3 = B3 * (1 - 1 / z)
 P4 = Log10(B4)
 }
 return P_ATM * 10 ^ (P1 + P2 + P3 + P4)     
 }
 */
+(float) VaporPresSat:(float) theDBTemp
{
    float anAbsT = (theDBTemp + 459.688f) / 1.8f;
    float z;
    float P1;
    float P2;
    float P3;
    float P4;
    if(anAbsT >= 273.16f)
    {     
        z = 373.16f / anAbsT;
        P1 = A1 * (z - 1.0f);
        P2 = [self Log10:z];
        P2 = A2 * [self Log10:z];
        P3 = A3 * pow(10, ((A4 * (1.0f - 1.0f / z)) - 1.0f));
        P4 = A5 * pow(10, ((A6 * (z - 1.0f)) - 1.0f));
    } 
    else
    {     
        z = 273.16f / anAbsT;
        P1 = B1 * (z - 1.0f);
        P2 = B2 * [self Log10:z];
        P3 = B3 * (1.0f - 1.0f / z);
        P4 = [self Log10:B4];
    }
    return P_ATM * pow(10,(P1 + P2 + P3 + P4));
}

/*
 ' Computes the Log Base 10 of Arg.
 Log10(Arg As Single)
 {
 return Log(Arg) / 2.30258509
 }
 */
+(float) Log10:(float) theArg
{
    return logf(theArg) / 2.30258509f;
}

/*
 ' Returns the relative humidity as a decimal fraction, given the dry bulb
 ' temperature, Temp, in degrees F and the humidity ratio W (lbs of water per
 ' lb of dry air).
 RHfromHumid(DBTemp, HumidRatio)
 {
 VPSat = VaporPresSat(DBTemp)
 RH = HumidRatio * P_ATM / VPSat / (0.622 + HumidRatio)
 If (RH > 1)
 {
 RH = 1;
 }
 return RH
 }
 */
+(float) RHFromHumid:(float) theDBTemp Ratio:(float) theHumidRatio
{
    float aVPSat = [self VaporPresSat:theDBTemp];
    float aRH = theHumidRatio * P_ATM / aVPSat / (0.622f + theHumidRatio);
    if (aRH > 1)
    {
        aRH = 1.0f;
    }
    return aRH;
}

/*
 ' Returns the cubic feet of moist air per pound of dry air.
 VolAir(DBTemp, RH)
 {
 HumRat = HumidRatio(DBTemp, RH)
 return 0.754 * (DBTemp + 459.7) * (1 + 7000 * HumRat / 4360) / P_ATM
 }
 */
+(float) VolAir:(float) theDBTemp RH:(float) theRH
{
    float aHumRat = [self HumidRatio:theDBTemp RH:theRH];
    return 0.754f * (theDBTemp + 459.7f) * (1.0f + 7000.0f * aHumRat / 4360.0f) / P_ATM;
}

/*
 ' Returns the moisture generation rate in pounds per day, given indoor RH and
 ' Temp, outdoor RH and Temp, and air flow in CFM.
 MoistureGen(InRH, InDBTemp, cfm, OutDBTemp, OutRH)
 {
 MassFlow = cfm * 1440 / VolAir(InDBTemp, InRH)
 OutHumid = HumidRatio(OutDBTemp, OutRH)
 InHumid = HumidRatio(InDBTemp, InRH)
 return (InHumid - OutHumid) * MassFlow
 }
 */
+(float) MoistureGen:(float) theInRH DB:(float) theInDBTemp cfm:(float) theCfm ODB:(float) theOutDBTemp ORH:(float) theOutRH
{
    float aMassFlow = theCfm * 1440.0f / [self VolAir:theInDBTemp RH:theInRH];
    float anOutHumid = [self HumidRatio:theOutDBTemp RH:theOutRH];
    float anInHumid = [self HumidRatio:theInDBTemp RH:theInRH];
    return (anInHumid - anOutHumid) * aMassFlow;
}

/*
 ' This function returns the indoor relative humidity when WaterGen pounds of
 ' water vapor are released within the house, cfm cubic feet per minute of
 ' air exchange is occurring (cfm is measured at the density of indoor
 ' temperature air), InDBTemp is the indoor dry bulb temperature, OutDBTemp
 ' is the outdoor dry bulb temperature, and OutRH is the outdoor relative
 ' humidity (expressed as a decimal).
 IndoorRH(WaterGen, cfm, InDBTemp, OutDBTemp, OutRH)
 {
 OutHumid = HumidRatio(OutDBTemp, OutRH)
 InRH = 0.35                        ' Initial guess at indoor RH
 for(int ai = 0; ai < 1; ai++)
 {
 MassFlow = cfm * 1440 / VolAir(InDBTemp, InRH)
 InHumid = OutHumid + WaterGen / MassFlow
 InRH = RHfromHumid(InDBTemp, InHumid)
 }
 return InRH
 }
 */
+(float) IndoorRH:(float) theWaterGen cfm:(float) theCfm InDBTemp:(float) theInDBTemp OutDBTemp:(float) theOutDBTemp OutRH:(float) theOutRH
{
    float anOutHumid = [self HumidRatio:theOutDBTemp RH:theOutRH];
    float anInRH = 0.35f;//Initial guess at indoor RH
    for(int ai = 0; ai < 1; ai++)
    {
        float aMassFlow = theCfm * 1440.0f / [self VolAir:theInDBTemp RH:anInRH];
        float anInHumid = anOutHumid + theWaterGen / aMassFlow;
        anInRH = [self RHFromHumid:theInDBTemp Ratio:anInHumid];
    }
    return anInRH * 100.0f;
}

-(void) updateCalculations
{
    float aOutdoorRH = [myRelativeHumidy.text floatValue];
	float anAirflow = [myInstallMoistureCont.text floatValue];
	float anOutdoorTemp = [myBoardWidth.text floatValue];
    float anIndoorTemp = [myIndoorTemp.text floatValue];
    float aWaterVapor = [myWaterVapor.text floatValue];
    
	myGapSize.text = [NSString stringWithFormat:@"%.1f", 
                      [IndoorRHCalculatorViewController IndoorRH:aWaterVapor cfm:anAirflow InDBTemp:anIndoorTemp OutDBTemp:anOutdoorTemp OutRH:aOutdoorRH]];    
}

@end
