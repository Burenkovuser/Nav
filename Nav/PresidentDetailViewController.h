//
//  PresidentDetailViewController.h
//  Nav
//
//  Created by Vasilii on 06.06.17.
//  Copyright © 2017 Vasilii Burenkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class President;
#define kNumberOfEditableRows   4
#define kNameRowIndex           0
#define kFromyearRowIndex       1
#define kToYearFromIndex        2
#define kPartyIndex             3

//#define kLabelTag               4096
#define kLabelTag 2048 
#define kTextFieldTag 4094

@interface PresidentDetailViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, retain) President *president;
@property (nonatomic, retain) NSArray *fieldLabels;
@property (nonatomic, retain) NSMutableDictionary *tempValues;
@property (nonatomic, retain) UITextField *textFieldBeingEdited;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)textFieldDone:(id)sender;

@end
