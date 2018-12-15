//
//  ViewController.m
//  ControlsTest
//
//  Created by Alex on 12/15/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

typedef NS_ENUM(NSUInteger){
    
    rgbColorScheme = 0,
    hsvColorScheme
    
    }colorScheme;


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.coloeSchemeControl.selectedSegmentIndex = hsvColorScheme;
    [self refreshScreen];
}

#pragma mark - Private Methods

- (void)refreshScreen
{
    CGFloat red = self.redSlider.value;
    CGFloat green = self.greenSlider.value;
    CGFloat blue = self.blueSlider.value;
    
    CGFloat hue, saturation, brightness, alpha;
    
    UIColor *color;
    if (self.coloeSchemeControl.selectedSegmentIndex == rgbColorScheme)
    {
        color = [UIColor colorWithRed:red green:green blue:blue alpha:1.f];
    }
    else
    {
        color = [UIColor colorWithHue:red saturation:green brightness:blue alpha:1.f];
    }
    
    NSString *finalString;
    if ([color getRed:&red green:&green blue:&blue alpha:&alpha])
    {
        finalString = [NSString stringWithFormat:@"RGB: {%1.2f, %1.2f, %1.2f}\n", red, green, blue];
    }
    else
    {
        finalString = @"Failed to receive RGB scheme";
    }
    
    if ([color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha])
    {
        finalString = [finalString stringByAppendingFormat:@"HSV:{%1.2f, %1.2f, %1.2f}", hue, saturation, brightness];
    }
    else
    {
        finalString = [finalString stringByAppendingString:@"Failed to receive HSV scheme"];
    }
    
    self.infoLabel.text = finalString;
    self.view.backgroundColor = color;
}


#pragma mark - Actions

- (IBAction)actionSlider:(UISlider *)sender {
    
    [self refreshScreen];
}

- (IBAction)actionEnabled:(UISwitch *)sender {
    
    self.redSlider.enabled = self.greenSlider.enabled = self.blueSlider.enabled = sender.isOn;
}

- (IBAction)segmentChangedAction:(UISegmentedControl *)sender {
    
    [self refreshScreen];
}
@end
