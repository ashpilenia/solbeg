//
//  ViewController.h
//  HomeWork - Superman
//
//  Created by Alex on 11/9/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"

@interface ViewController : UIViewController <SettingsViewControllerDelegate, UIActionSheetDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *tempDrawImage;

- (IBAction)pencilPressed:(UIButton *)sender;
- (IBAction)eraserPressed:(UIButton *)sender;
- (IBAction)reset:(UIButton *)sender;
- (IBAction)settings:(UIButton *)sender;
- (IBAction)save:(UIButton *)sender;

@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, assign) CGFloat red;
@property (nonatomic, assign) CGFloat green;
@property (nonatomic, assign) CGFloat blue;
@property (nonatomic, assign) CGFloat brush;
@property (nonatomic, assign) CGFloat opacity;
@property (nonatomic, assign) BOOL mouseSwiped;




@end

