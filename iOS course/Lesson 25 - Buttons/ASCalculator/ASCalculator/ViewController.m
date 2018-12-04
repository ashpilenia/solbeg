//
//  ViewController.m
//  ASCalculator
//
//  Created by Alex on 12/3/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - View Controller

- (void)viewDidLoad {
    [super viewDidLoad];

    //set outlets properties
    self.clearButton.layer.borderWidth = 0.5f;
    self.clearButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.changeSignButton.layer.borderWidth = 0.5f;
    self.changeSignButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.percantageButton.layer.borderWidth = 0.5f;
    self.percantageButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.divisionButton.layer.borderWidth = 0.5f;
    self.divisionButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.sevenButton.layer.borderWidth = 0.5f;
    self.sevenButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.eightButton.layer.borderWidth = 0.5f;
    self.eightButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.nineButton.layer.borderWidth = 0.5f;
    self.nineButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.multiplierButton.layer.borderWidth = 0.5f;
    self.multiplierButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.fourButton.layer.borderWidth = 0.5f;
    self.fourButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.fiveButton.layer.borderWidth = 0.5f;
    self.fiveButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.sixButton.layer.borderWidth = 0.5f;
    self.sixButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.minusButton.layer.borderWidth = 0.5f;
    self.minusButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    [self.oneButton.layer setBorderWidth:0.5f];
    [self.oneButton.layer setBorderColor:[UIColor blackColor].CGColor];
    
    self.twoButton.layer.borderWidth = 0.5f;
    self.twoButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.threeButton.layer.borderWidth = 0.5f;
    self.threeButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.plusButton.layer.borderWidth = 0.5f;
    self.plusButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.zeroButton.layer.borderWidth = 0.5f;
    self.zeroButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.dotButton.layer.borderWidth = 0.5f;
    self.dotButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.equalButton.layer.borderWidth = 0.5f;
    self.equalButton.layer.borderColor = [UIColor blackColor].CGColor;
    
}


#pragma mark - Actions

- (IBAction)numericAction:(UIButton *)sender {
}

- (IBAction)operationAction:(UIButton *)sender {
}

- (IBAction)equalAction:(UIButton *)sender {
}

- (IBAction)singleTargetAction:(UIButton *)sender {
}

- (IBAction)clearAction:(UIButton *)sender {
}
@end
