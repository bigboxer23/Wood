//
//  AbstractCalculatorViewController.m
//  FlooringApp
//
//  Created by matt on 9/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AbstractCalculatorViewController.h"


@implementation AbstractCalculatorViewController

@synthesize myHelpViewController;
@synthesize myNumberKeyPad;
@synthesize myMainView;
@synthesize myBoardCategory;
@synthesize myBoardCategoryPicker;
@synthesize myBoardCategoryData;
@synthesize myBoardSpecies;
@synthesize mySawn;
@synthesize myBoardWidth;
@synthesize myIndoorTemp;
@synthesize myRelativeHumidy;
@synthesize myInstallMoistureCont;
@synthesize myGapSize;
@synthesize myCurMoistureCont;
@synthesize myData;
@synthesize myImageView;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	myIsHidden = TRUE;
	UIBarButtonItem *aRight = [[[UIBarButtonItem alloc]
						  initWithTitle:@"Help" style:UIBarButtonItemStylePlain target:self action:@selector(notifyToHideKeyboard)] autorelease];
	[[self navigationItem] setRightBarButtonItem:aRight];
	NSBundle *aBundle = [NSBundle mainBundle];
	NSString *aPlistPath = [aBundle pathForResource:@"data" ofType:@"plist"];
	self.myData = [[NSDictionary alloc] initWithContentsOfFile:aPlistPath];
	self.myBoardCategoryData = [NSMutableArray arrayWithCapacity:1];
	[self.myBoardCategoryData addObjectsFromArray:[[self.myData allKeys] sortedArrayUsingSelector:@selector(compare:)]];
	[self loadDependantCategories];
	
	//Set what we do when the done button is pressed...
	[self.myBoardWidth addTarget:self
						  action:@selector(textFieldDoneEditing:)
				forControlEvents:UIControlEventEditingDidEndOnExit];
	[self.myIndoorTemp addTarget:self
						  action:@selector(textFieldDoneEditing:)
				forControlEvents:UIControlEventEditingDidEndOnExit];
	[self.myRelativeHumidy addTarget:self
							  action:@selector(textFieldDoneEditing:)
					forControlEvents:UIControlEventEditingDidEndOnExit];
	[self.myInstallMoistureCont addTarget:self
								   action:@selector(textFieldDoneEditing:)
						 forControlEvents:UIControlEventEditingDidEndOnExit];
	self.myImageView.layer.cornerRadius = 5.0;
	self.myImageView.layer.masksToBounds = YES;
	self.myImageView.layer.borderColor = [UIColor whiteColor].CGColor;
	self.myImageView.layer.borderWidth = 2.0;
}

-(void)notifyToHideKeyboard
{
	if([[[self navigationItem].rightBarButtonItem title]  isEqualToString:@"Done"])
	{
		[self touchTopDone:NULL];
		[[self navigationItem].rightBarButtonItem setTitle:@"Help"]; 
		return;
	}
	[[self navigationController] pushViewController:self.myHelpViewController animated:YES];
}

/**
 *  Push the help view onto the nav controller
 */
-(void)helpTouched:(NSNotification*) theNotification
{	
	UIViewController* aView = theNotification.object;
	if(aView == self)
	{
		[[self navigationController] pushViewController:self.myHelpViewController animated:YES];
	}
}

/**
 *  Function controls the sliding up and down of the view to accomodate an input being touched.
 */
-(IBAction)inputTouched:(id)sender
{
	[[self navigationItem].rightBarButtonItem setTitle:@"Done"];
	if(sender == self.myBoardWidth || sender == self.myIndoorTemp || sender == self.myRelativeHumidy || sender == self.myInstallMoistureCont)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.4];
		[UIView setAnimationDelegate:self];
		if(sender == self.myBoardWidth)
		{
			[self.myMainView setFrame:CGRectMake(0, 40, self.myMainView.frame.size.width, self.myMainView.frame.size.height)];
		}
		if(sender == self.myIndoorTemp)
		{
			[self.myMainView setFrame:CGRectMake(0, 0, self.myMainView.frame.size.width, self.myMainView.frame.size.height)];
		}
		if(sender == self.myRelativeHumidy)
		{
			[self.myMainView setFrame:CGRectMake(0, -40, self.myMainView.frame.size.width, self.myMainView.frame.size.height)];
		}
		if(sender == self.myInstallMoistureCont)
		{
			[self.myMainView setFrame:CGRectMake(0, -80, self.myMainView.frame.size.width, self.myMainView.frame.size.height)];
		}
		[UIView commitAnimations];
	}
}

/*
 When touching board category, shows the picker
 */
-(IBAction)boardCategoryTouch:(id)sender
{
	if(sender == self.myBoardCategory || sender == self.myBoardSpecies || sender == self.mySawn)
	{
		[self.myBoardCategoryData removeAllObjects];
		if(sender == self.myBoardCategory)
		{
			myState = kBoardCategory;
			NSMutableArray *aSetToReturn = [NSMutableArray arrayWithCapacity:1];
			NSArray *aUnsortedWood = [self.myData allKeys];
			for(int aj = 0; aj < [aUnsortedWood count]; aj++)
			{
				NSString *aSpecie = [aUnsortedWood objectAtIndex:aj];
				NSArray *aSpecies = [[self.myData objectForKey:[aUnsortedWood objectAtIndex:aj]] allKeys];
				for(int ai = 0; ai < [aSpecies count]; ai++)
				{
					NSArray *aPotentialCuts = [[[self.myData objectForKey:aSpecie] objectForKey:[aSpecies objectAtIndex:ai]] allKeys];
					if([self hasValidCut:aPotentialCuts] && ![aSetToReturn containsObject:aSpecie])
					{
						[aSetToReturn addObject:aSpecie];
					}
				}
			}
			[self.myBoardCategoryData addObjectsFromArray:[aSetToReturn sortedArrayUsingSelector:@selector(compare:)]];
			[self.myBoardCategoryPicker selectRow:0 inComponent:0 animated:YES];
			[self.myBoardCategoryPicker reloadComponent:0];
		}
		if(sender == myBoardSpecies)
		{
			myState = kBoardSpecies;
			NSArray *aSpecies = [[self.myData objectForKey:self.myBoardCategory.text] allKeys];
			for(int ai = 0; ai < [aSpecies count]; ai++)
			{
				NSArray *aPotentialCuts = [[[myData objectForKey:self.myBoardCategory.text] objectForKey:[aSpecies objectAtIndex:ai]] allKeys];
				if([self hasValidCut:aPotentialCuts])
				{
					[self.myBoardCategoryData addObject:[aSpecies objectAtIndex:ai]];
				}
			}
			[self.myBoardCategoryPicker selectRow:0 inComponent:0 animated:YES];
			[self.myBoardCategoryPicker reloadComponent:0];
		}
		if(sender == self.mySawn)
		{
			myState = kSawn;
			NSDictionary *aSpecies = [self.myData objectForKey:self.myBoardCategory.text];
			NSDictionary *aCuts = [aSpecies objectForKey:self.myBoardSpecies.text];
			NSArray *aCutsKey = [aCuts allKeys];
			for(int ai = 0; ai < [aCutsKey count]; ai++)
			{
				NSString *aCut = [aCutsKey objectAtIndex:ai];
				if([aCut isEqualToString:@"Plain Sawn"] || [aCut isEqualToString:@"Quarter Sawn"])
				{
					[self.myBoardCategoryData addObject:aCut];
				}
			}
			[self.myBoardCategoryPicker selectRow:0 inComponent:0 animated:YES];
			[self.myBoardCategoryPicker reloadComponent:0];
		}	
		[self touchTopDone:sender];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.4];
		[UIView setAnimationDelegate:self];
		[self.myBoardCategoryPicker setFrame:CGRectMake(0, 200, 320, self.myBoardCategoryPicker.frame.size.height)];
		[UIView commitAnimations];
		myIsHidden = FALSE;
	}
}

-(BOOL)hasValidCut:(NSArray *)theArray
{
	for(int ai = 0; ai < [theArray count]; ai++)
	{
		NSString *aCut = [theArray objectAtIndex:ai];
		if([aCut isEqualToString:@"Plain Sawn"] || [aCut isEqualToString:@"Quarter Sawn"])
		{
			return TRUE;
		}
	}
	return FALSE;
}

/**
 *	Hides the number pad, animates a slide down, and updates the calculations
 */
- (IBAction) touchTopDone:(id)sender
{
	if(!myIsHidden)
	{
		NSInteger aRow = [self.myBoardCategoryPicker selectedRowInComponent:0];
		NSString *aValue = [self.myBoardCategoryData objectAtIndex:aRow];
		if(myState == kBoardCategory)
		{
			self.myBoardCategory.text = aValue;
			self.myBoardSpecies.text = nil;
			self.mySawn.text = nil;
		}
		if(myState == kBoardSpecies)
		{
			self.myBoardSpecies.text = aValue;
			self.mySawn.text = nil;
		}
		if(myState == kSawn)
		{
			self.mySawn.text = aValue;
		}
		[self loadDependantCategories];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.4];
		[UIView setAnimationDelegate:self];
		[self.myBoardCategoryPicker setFrame:CGRectMake(0, 415, 320, self.myBoardCategoryPicker.frame.size.height)];
		[UIView commitAnimations];
		[self updateCalculations];
		myIsHidden = TRUE;
		return;
	}
	[self.myInstallMoistureCont resignFirstResponder];
	[self.myBoardWidth resignFirstResponder];
	[self.myIndoorTemp resignFirstResponder];
	[self.myRelativeHumidy resignFirstResponder];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.4];
	[UIView setAnimationDelegate:self];
	
	[self.myMainView setFrame:CGRectMake(0, 84, self.myMainView.frame.size.width, self.myMainView.frame.size.height)];
	[UIView commitAnimations];
	[self updateCalculations];
}

/*
 Method looks at board category, then loads species, then loads Sawn
 */
-(void) loadDependantCategories
{
	if([self.myBoardCategory.text length] == 0)
	{
		self.myBoardCategory.text = [self.myBoardCategoryData objectAtIndex:0];
	}
	NSDictionary *aSpecies = [self.myData objectForKey:self.myBoardCategory.text];
	if([self.myBoardSpecies.text length] == 0)
	{
		BOOL aFound = FALSE;
		NSArray *aSubSpeciesArray = [aSpecies allKeys];
		for(int ai = 0; ai < [aSubSpeciesArray count] && !aFound; ai++)
		{
			NSString *aSubSpecies = [aSubSpeciesArray objectAtIndex:ai];
			if([self hasValidCut:[[aSpecies objectForKey:aSubSpecies] allKeys]])
			{
				self.myBoardSpecies.text = aSubSpecies;
				aFound = TRUE;
			}
		}		
		//self.myBoardSpecies.text = [[aSpecies allKeys]objectAtIndex:0];
	}
	NSDictionary *aCuts = [aSpecies objectForKey:self.myBoardSpecies.text];
	if([self.mySawn.text length] == 0)
	{
		NSArray *anInformation = [aCuts allKeys];
		BOOL aFound = false;
		for(int ai = 0; ai < [anInformation count] && !aFound; ai++)
		{
			NSString *anInfo = [anInformation objectAtIndex:ai];
			if([anInfo isEqualToString:@"Quarter Sawn"] || [anInfo isEqualToString:@"Plain Sawn"])
			{
				self.mySawn.text = anInfo;
				aFound = TRUE;
			}
		}
	}
	myDimensionalChangeCoefficient = [[aCuts objectForKey:self.mySawn.text] floatValue];
	[self updateCalculations];
}

/**
 This should be implemented in subviewcontrollers to do the calculation
 **/
-(void) updateCalculations{}

/**
 This method is for making sure we don't allow the picker fields to go into edit mode, or display a custom keyboard with
 a decimal point
 **/
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {	
	[self boardCategoryTouch:textField];
	[self inputTouched:textField];
	if(textField == self.myInstallMoistureCont || textField == self.myBoardWidth || textField == self.myIndoorTemp || textField == self.myRelativeHumidy)
	{
		if (self.myNumberKeyPad) {
			self.myNumberKeyPad.currentTextField = textField;
		}
		return YES;
	}
    return NO;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {	
	if (![textField isEqual:normal]) {
		/*
		 Show the numberKeyPad 
		 */
		if (!self.myNumberKeyPad) 
		{
			[self.navigationItem setHidesBackButton:YES animated:YES];
			self.myNumberKeyPad = [NumberKeypadDecimalPoint keypadForTextField:textField];
		}
	}	
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	[self.navigationItem setHidesBackButton:NO animated:YES];
	if (textField == self.myNumberKeyPad.currentTextField || self.myNumberKeyPad.currentTextField == normal) {
		/*
		 Hide the number keypad
		 */
		[self.myNumberKeyPad removeButtonFromKeyboard];
		self.myNumberKeyPad = nil;
	}
}	

- (void)dealloc {
	[self.myBoardCategory release];
	[self.myBoardCategoryPicker release];
	[self.myBoardCategoryData release];
	[self.myBoardSpecies release];
	[self.mySawn release];
	[self.myBoardWidth release];
	[self.myIndoorTemp release];
	[self.myRelativeHumidy release];
	[self.myInstallMoistureCont release];
	[self.myGapSize release];
	[self.myCurMoistureCont release];
	[self.myMainView release];
	[self.myNumberKeyPad release];
	[self.myHelpViewController release];
	[self.myData release];
	[self.myImageView release];
    [super dealloc];
}

#pragma mark -
#pragma mark Picker Data Source Methods
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

-(NSInteger)pickerView: (UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [self.myBoardCategoryData count];	
}

#pragma mark Picker Delegate Methods
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	//myBoardCategory.text = [myBoardCategoryData objectAtIndex:row];
	return [self.myBoardCategoryData objectAtIndex:row];
}

@end
