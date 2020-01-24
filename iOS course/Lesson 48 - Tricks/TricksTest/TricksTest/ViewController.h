//
//  ViewController.h
//  TricksTest
//
//  Created by Alex Shpilenia on 10/9/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *consoleTextView;

- (IBAction)actionTest:(UIButton *)sender;

@end

