//
//  ViewController.h
//  HomeWork
//
//  Created by Alex on 12/15/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UISwitch *rotationSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *scaleSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *translationSwitch;
@property (weak, nonatomic) IBOutlet UISlider *sppedSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction)switchAction:(UISwitch *)sender;
- (IBAction)sliderAction:(UISlider *)sender;
- (IBAction)segmentChangedAction:(UISegmentedControl *)sender;


@end

