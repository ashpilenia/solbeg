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
    
    UIGraphicsBeginImageContext(self.brushImageView.frame.size);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brush);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0, 0, 0, 1.f);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 50.f, 50.f);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 50.f, 50.f);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.brushImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    int redIntValue = self.red * 255.f;
    int greedIntValue = self.green * 255.f;
    int blueIntValue = self.blue * 255.f;
    
    self.redControl.value = redIntValue;
    self.greenControl.value = greedIntValue;
    self.blueControl.value = blueIntValue;
    
    [self sliderChanged:self.redControl];
    [self sliderChanged:self.greenControl];
    [self sliderChanged:self.blueControl];
}

#pragma mark - Actions

- (IBAction)closeSettings:(UIBarButtonItem *)sender {
    
    [self.delegate closeSettings:self];
}

- (IBAction)sliderChanged:(UISlider *)sender {
    
    if (sender == self.brushSlider) {
        
        self.brush = self.brushSlider.value;
        self.brushValueLabel.text = [NSString stringWithFormat:@"%.1f", self.brush];
        
    } else if (sender == self.opacitySlider) {
        
        self.opacity = self.opacitySlider.value;
        self.opacityValueLabel.text = [NSString stringWithFormat:@"%.1f", self.opacity];
        
    } else if (sender == self.redControl) {
        
        self.red = self.redControl.value/255.f;
        self.redLabel.text = [NSString stringWithFormat:@"Red: %d", (int)self.redControl.value];
        
    } else if (sender == self.greenControl) {
        
        self.green = self.greenControl.value/255.f;
        self.greenLabel.text = [NSString stringWithFormat:@"Green: %d", (int)self.greenControl.value];
        
    } else if (sender == self.blueControl) {
        
        self.blue = self.blueControl.value/255.f;
        self.blueLabel.text = [NSString stringWithFormat:@"Blue: %d", (int)self.blueControl.value];
        
    }
    
    UIGraphicsBeginImageContext(self.brushImageView.frame.size);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brush);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.red, self.green, self.blue, 1.f);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 50.f, 50.f);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 50.f, 50.f);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.brushImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(self.opacityImageView.frame.size);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 20.f);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.red, self.green, self.blue, self.opacity);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 50.f, 50.f);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 50.f, 50.f);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.opacityImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
}
@end
