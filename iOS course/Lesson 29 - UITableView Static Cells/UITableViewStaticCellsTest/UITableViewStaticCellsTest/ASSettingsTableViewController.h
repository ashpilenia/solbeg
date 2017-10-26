//
//  ASSettingsTableViewController.h
//  UITableViewStaticCellsTest
//
//  Created by Alex on 10/22/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASSettingsTableViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *difficultyControl;
@property (weak, nonatomic) IBOutlet UISwitch *shadowsSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *detalizationControl;
@property (weak, nonatomic) IBOutlet UISlider *soundSlider;
@property (weak, nonatomic) IBOutlet UISlider *musicSlider;


- (IBAction)actionTextChanged:(UITextField *)sender;
- (IBAction)actionValueChanged:(id)sender;

@end
