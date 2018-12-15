//
//  ViewController.h
//  ControlsTest
//
//  Created by Alex on 12/15/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *coloeSchemeControl;

- (IBAction)actionSlider:(UISlider *)sender;
- (IBAction)actionEnabled:(UISwitch *)sender;
- (IBAction)segmentChangedAction:(UISegmentedControl *)sender;

@end

