//
//  RoomExpansionViewController.h
//  FlooringApp
//
//  Created by matt on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractCalculatorViewController.h"


@interface RoomExpansionViewController : AbstractCalculatorViewController {
	IBOutlet UITextField *myBottomMoisture;
	IBOutlet UILabel *myBoardDimensionalChange;

}

@property (nonatomic, retain) UITextField *myBottomMoisture;
@property (nonatomic, retain) UILabel *myBoardDimensionalChange;

@end
