//
//  ViewController.h
//  ButtonsTest
//
//  Created by Alex on 11/29/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *indicatorLabel;

- (IBAction)actionTest2:(UIButton *)sender;
- (IBAction)actionTest2TouchDown:(UIButton *)sender;

@end

