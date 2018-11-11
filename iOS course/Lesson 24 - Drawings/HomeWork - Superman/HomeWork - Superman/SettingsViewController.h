//
//  SettingsViewController.h
//  HomeWork - Superman
//
//  Created by Alex on 11/11/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsViewControllerDelegate <NSObject>

- (void)closeSettings:(id)sender;

@end


@interface SettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISlider *brushSlider;
@property (weak, nonatomic) IBOutlet UILabel *brushValueLabel;
@property (weak, nonatomic) IBOutlet UIImageView *brushImageView;
@property (weak, nonatomic) IBOutlet UISlider *opacitySlider;
@property (weak, nonatomic) IBOutlet UILabel *opacityValueLabel;
@property (weak, nonatomic) IBOutlet UIImageView *opacityImageView;

- (IBAction)sliderChanged:(UISlider *)sender;

@property (nonatomic, assign) CGFloat brush;
@property (nonatomic, assign) CGFloat opacity;

@property (nonatomic, weak) id<SettingsViewControllerDelegate> delegate;

@end

