//
//  SettingsViewController.m
//  HomeWork - Superman
//
//  Created by Alex on 11/11/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

- (IBAction)closeSettings:(UIBarButtonItem *)sender;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.opacityValueLabel.text = [NSString stringWithFormat:@"%.1f", self.opacity];
    self.brushValueLabel.text = [NSString stringWithFormat:@"%.1f", self.brush];
    self.opacitySlider.value = self.opacity;
    self.brushSlider.value = self.brush;
    
}

#pragma mark - Actions

- (IBAction)closeSettings:(UIBarButtonItem *)sender {
    
    [self.delegate closeSettings:self];
}

- (IBAction)sliderChanged:(UISlider *)sender {
    
    if (sender == self.brushSlider)
    {
        self.brush = self.brushSlider.value;
        self.brushValueLabel.text = [NSString stringWithFormat:@"%.1f", self.brush];
        
        UIGraphicsBeginImageContext(self.brushImageView.frame.size);
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0, 0, 0, 1.f);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 50.f, 50.f);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 50.f, 50.f);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        self.brushImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    else
    {
        self.opacity = self.opacitySlider.value;
        self.opacityValueLabel.text = [NSString stringWithFormat:@"%.1f", self.opacity];
        
        UIGraphicsBeginImageContext(self.opacityImageView.frame.size);
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 20.f);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0, 0, 0, self.opacity);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 50.f, 50.f);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 50.f, 50.f);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        self.opacityImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }

}
@end
