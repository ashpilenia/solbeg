//
//  ViewController.m
//  HomeWork
//
//  Created by Alex on 12/15/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(int) {
    
    rotationOption = 0,
    scaleOption,
    translationOption
    
}transformOptions;

@interface ViewController ()

@property (nonatomic, strong) NSArray *imagesArray;
@property (nonatomic, assign) CGAffineTransform reservedTransform;
@property (nonatomic, assign) float animationSpeed;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.animationSpeed = self.sppedSlider.value;
    self.reservedTransform = self.mainImageView.transform;
    
    UIImage *image1 = [UIImage imageNamed:@"Julia.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"Julia2.jpg"];
    UIImage *image3 = [UIImage imageNamed:@"Julia4.jpg"];
    self.imagesArray = @[image1, image2, image3];
    
    self.segmentedControl.selectedSegmentIndex = 0;
}

#pragma mark - Private Methods

- (NSArray *)getAnimateOptions
{
    NSMutableArray<NSNumber *> *optionsArray = [NSMutableArray  array];
    if (self.scaleSwitch.isOn)
    {
        [optionsArray addObject:[NSNumber numberWithInt:scaleOption]];
    }
    if (self.rotationSwitch.isOn)
    {
        [optionsArray addObject:[NSNumber numberWithInt:rotationOption]];
    }
    if (self.translationSwitch.isOn)
    {
        [optionsArray addObject:[NSNumber numberWithInt:translationOption]];
    }
    return optionsArray;
}

- (void)animateImageWithOptions:(NSArray *)optionsArray
{
    double duration = 2.f / (double)self.animationSpeed;
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse
                     animations:^{
                         
                         CGAffineTransform totalTransform = self.mainImageView.transform;
                         for (NSNumber *number in optionsArray)
                         {
                             transformOptions option = [number intValue];
                             
                             switch (option) {
                                 case rotationOption:
                                     {
                                         totalTransform = CGAffineTransformRotate(totalTransform, M_PI);
                                     }
                                     break;
                                     
                                 case scaleOption:
                                     {
                                         totalTransform = CGAffineTransformScale(totalTransform, 0.5f, 0.5f);
                                     }
                                     break;
                                     
                                 case translationOption:
                                 {
                                     totalTransform = CGAffineTransformTranslate(totalTransform, 0, 200);
                                 }
                                     break;
                                     
                                 default:
                                     break;
                             }
                         }
                         
                         self.mainImageView.transform = totalTransform;
                         
                     } completion:nil];
}

#pragma mark - Actions

- (IBAction)switchAction:(UISwitch *)sender {
    
    NSArray *optionsArray = [self getAnimateOptions];
   
    [self.mainImageView.layer removeAllAnimations];
    self.mainImageView.transform = self.reservedTransform;
    if (optionsArray.count)
    {
        [self animateImageWithOptions:optionsArray];
    }
}

- (IBAction)sliderAction:(UISlider *)sender {
    
    self.animationSpeed = sender.value;
    NSArray *options = [self getAnimateOptions];
    [self.mainImageView.layer removeAllAnimations];
    self.mainImageView.transform = self.reservedTransform;
    [self animateImageWithOptions:options];
    
}

- (IBAction)segmentChangedAction:(UISegmentedControl *)sender {
    
    self.mainImageView.image = [self.imagesArray objectAtIndex:sender.selectedSegmentIndex];

}
@end
