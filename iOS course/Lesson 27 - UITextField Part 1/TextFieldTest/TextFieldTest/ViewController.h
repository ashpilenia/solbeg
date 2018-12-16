//
//  ViewController.h
//  TextFieldTest
//
//  Created by Alex on 12/16/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;

- (IBAction)logAction:(UIButton *)sender;
- (IBAction)axtionTextChanged:(UITextField *)sender;

@end

