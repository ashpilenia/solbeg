//
//  ViewController.m
//  HomeWork - Superman
//
//  Created by Alex on 11/9/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.red = 0.0/255.0;
    self.green = 0.0/255.0;
    self.blue = 0.0/255.0;
    self.brush = 10.0;
    self.opacity = 1.0;
}


#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.mouseSwiped = NO;
    
}

#pragma mark - Actions

- (IBAction)pencilPressed:(UIButton *)sender {
}

- (IBAction)eraserPressed:(UIButton *)sender {
}

- (IBAction)reset:(UIButton *)sender {
}

- (IBAction)settings:(UIButton *)sender {
}

- (IBAction)save:(UIButton *)sender {
}
@end
