//
//  ViewController.m
//  ASCalculator
//
//  Created by Alex on 12/3/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSUInteger, operationsList) {
    
    divisionOperationOption = 21,
    multiplicationOperationOption,
    minusOperationOption,
    plusOpertaionOption
    
};


@interface ViewController ()

@property (nonatomic, strong) NSArray *allButtonsArray;
@property (nonatomic, assign) double lastNumber;
@property (nonatomic, assign) double firstNumber;
@property (nonatomic, assign) operationsList lastOperation;
@property (nonatomic, strong) UIButton *lastPressedButton;
@property (nonatomic, assign) BOOL isDotActioInProgress;

@end

@implementation ViewController

#pragma mark - View Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.allButtonsArray = @[self.oneButton, self.twoButton, self.threeButton, self.fourButton,
                             self.fiveButton, self.sixButton, self.sevenButton, self.eightButton,
                             self.nineButton, self.zeroButton, self.clearButton, self.changeSignButton,
                             self.percantageButton, self.divisionButton, self.multiplierButton,
                             self.minusButton, self.plusButton, self.equalButton, self.dotButton];
    
    for (UIButton *button in self.allButtonsArray)
    {
        [self setupButtonAppearance:button];
    }
    
}

#pragma mark - Helpers

- (NSNumber *)getValidNumberAppearance:(double)number
{
    NSNumber *retVal;
    double test = number - (int)number;
    if (!test)
    {
        retVal = [NSNumber numberWithInt:(int)number];
    }
    else
    {
        retVal = [NSNumber numberWithDouble:number];
    }
    return retVal;
}

- (void)setupButtonAppearance:(UIButton *)button
{
    button.layer.borderWidth = 0.5f;
    button.layer.borderColor = [UIColor blackColor].CGColor;
    [button addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(buttonNormalized:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(buttonNormalized:) forControlEvents:UIControlEventTouchUpOutside];
    
    if (button.tag <= 11)
    {
        button.backgroundColor = [self numericColor];
    }
    else if (11 < button.tag && button.tag < 20 )
    {
        button.backgroundColor = [self singleTargetOperationsColor];
    }
    else
    {
        button.backgroundColor = [self operationsColor];
    }
}

- (UIColor *)numericColor
{
    return [UIColor colorWithRed:116.f/255.f green:108.f/255.f blue:104.f/255.f alpha:1.f];
}

- (UIColor *)singleTargetOperationsColor
{
    return [UIColor colorWithRed:82.f/255.f green:75.f/255.f blue:72.f/255.f alpha:1.f];
}

- (UIColor *)operationsColor
{
    return [UIColor colorWithRed:242.f/255.f green:163.f/255.f blue:59.f/255.f alpha:1.f];
}

- (void)executeOperation:(operationsList)operation
{
    switch (operation) {
        case plusOpertaionOption:
            {
                double tempNumber = self.lastNumber + self.firstNumber;
                self.lastNumber = self.firstNumber;
                self.firstNumber = tempNumber;
                self.mainLabel.text = [NSString stringWithFormat:@"%@", [self getValidNumberAppearance:self.firstNumber]];
            }
            break;

        case minusOperationOption:
            {
                double tempNumber = self.lastNumber - self.firstNumber;
                self.lastNumber = self.firstNumber;
                self.firstNumber = tempNumber;
                self.mainLabel.text = [NSString stringWithFormat:@"%@", [self getValidNumberAppearance:self.firstNumber]];
            }
            break;

        case divisionOperationOption:
            {
                double tempNumber = self.lastNumber / self.firstNumber;
                self.lastNumber = self.firstNumber;
                self.firstNumber = tempNumber;
                self.mainLabel.text = [NSString stringWithFormat:@"%@", [self getValidNumberAppearance:self.firstNumber]];
            }
            break;

        case multiplicationOperationOption:
            {
                double tempNumber = self.lastNumber * self.firstNumber;
                self.lastNumber = self.firstNumber;
                self.firstNumber = tempNumber;
                self.mainLabel.text = [NSString stringWithFormat:@"%@", [self getValidNumberAppearance:self.firstNumber]];
            }
            break;

        default:
            break;
    }
}

    

#pragma mark - Actions

- (IBAction)numericAction:(UIButton *)sender {
    
    if (self.isDotActioInProgress)
    {
        self.mainLabel.text = [self.mainLabel.text stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)sender.tag]];
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        NSNumber *enteredNumber = [formatter numberFromString:self.mainLabel.text];
        self.firstNumber = [enteredNumber doubleValue];
        
    }
    else
    {
        if (self.lastPressedButton.tag <= 11)
        {
            self.firstNumber = self.firstNumber*10 + sender.tag;
            double testNumber = self.firstNumber - (int)self.firstNumber;
            if (!testNumber)
            {
                self.mainLabel.text = [NSString stringWithFormat:@"%d", (int)self.firstNumber];
            }
            else
            {
                self.mainLabel.text = [NSString stringWithFormat:@"%f", self.firstNumber];
            }
        }
        else if (self.lastPressedButton.tag == 25)
        {
            self.firstNumber = sender.tag;
            self.lastNumber = 0;
            self.mainLabel.text = [NSString stringWithFormat:@"%ld", (long)sender.tag];
        }
        else
        {
            if (!self.firstNumber)
            {
                self.firstNumber = sender.tag;
            }
            else
            {
                self.lastNumber = self.firstNumber;
                self.firstNumber = sender.tag;
            }
            self.mainLabel.text = [NSString stringWithFormat:@"%ld", (long)sender.tag];
        }
    }
    self.lastPressedButton = sender;
}

- (IBAction)operationAction:(UIButton *)sender {
    
    self.isDotActioInProgress = NO;
    if (self.lastPressedButton.tag <= 11)
    {
        if (self.lastOperation)
        {
            [self executeOperation:self.lastOperation];
        }
    }
    else if (self.lastPressedButton.tag == 25)
    {
        self.firstNumber = self.lastNumber;
        self.lastNumber = 0;
    }
    self.lastOperation = sender.tag;
    self.lastPressedButton = sender;
    
}

- (IBAction)equalAction:(UIButton *)sender {
    
    if (self.lastOperation)
    {
        switch (self.lastOperation) {
            case plusOpertaionOption:
            {
                self.lastNumber = self.lastNumber + self.firstNumber;
                self.mainLabel.text = [NSString stringWithFormat:@"%@", [self getValidNumberAppearance:self.lastNumber]];
            }
                break;
                
            case minusOperationOption:
            {
                self.lastNumber = self.lastNumber - self.firstNumber;
                self.mainLabel.text = [NSString stringWithFormat:@"%@", [self getValidNumberAppearance:self.lastNumber]];
            }
                break;
                
            case divisionOperationOption:
            {
                self.lastNumber = self.lastNumber / self.firstNumber;
                self.mainLabel.text = [NSString stringWithFormat:@"%@", [self getValidNumberAppearance:self.lastNumber]];
            }
                break;
                
            case multiplicationOperationOption:
            {
                self.lastNumber = self.lastNumber * self.firstNumber;
                self.mainLabel.text = [NSString stringWithFormat:@"%@", [self getValidNumberAppearance:self.lastNumber]];
            }
                break;
                
            default:
                break;
        }
    }
    self.lastPressedButton = sender;
    
}

- (IBAction)singleTargetAction:(UIButton *)sender {
    
    switch (sender.tag) {
        case 13:
            {
                if (self.lastPressedButton.tag == 25)
                {
                    self.lastNumber *= -1;
                    self.mainLabel.text = [NSString stringWithFormat:@"%@", [self getValidNumberAppearance:self.lastNumber]];
                }
                else
                {
                    self.firstNumber *= -1;
                    self.mainLabel.text = [NSString stringWithFormat:@"%@", [self getValidNumberAppearance:self.firstNumber]];
                }
            }
            break;
            
        case 14:
            {
                if (self.lastPressedButton.tag == 25)
                {
                    self.lastNumber /= 100;
                    self.mainLabel.text = [NSString stringWithFormat:@"%@", [self getValidNumberAppearance:self.lastNumber]];
                }
                else
                {
                    self.firstNumber /= 100;
                    self.mainLabel.text = [NSString stringWithFormat:@"%@", [self getValidNumberAppearance:self.firstNumber]];
                }
                
            }
            break;
            
        default:
            break;
    }
}

- (IBAction)clearAction:(UIButton *)sender {
   
    self.firstNumber = 0;
    self.lastNumber = 0;
    self.lastOperation = 0;
    self.mainLabel.text = @"0";
    self.lastPressedButton = sender;
    self.isDotActioInProgress = NO;
}

- (IBAction)dotAction:(UIButton *)sender {
    
    if (!self.isDotActioInProgress)
    {
        if (self.lastPressedButton.tag > 20)
        {
            self.firstNumber = 0;
            self.lastNumber = 0;
            self.mainLabel.text = @"0.";
            self.isDotActioInProgress = YES;
        }
        else
        {
            double test = self.firstNumber - (int)self.firstNumber;
            if (!test)
            {
                self.mainLabel.text = [NSString stringWithFormat:@"%@.", [self getValidNumberAppearance:self.firstNumber]];
                self.isDotActioInProgress = YES;
            }
            
        }
    }
}

- (void)buttonSelected:(UIButton *)sender
{
    if (sender.tag <= 11)
    {
        sender.backgroundColor = [UIColor lightGrayColor];
    }
    else if (11 < sender.tag && sender.tag < 20)
    {
        sender.backgroundColor = [self numericColor];
    }
    else
    {
        sender.backgroundColor = [UIColor colorWithRed:176.f/255.f green:103.f/255.f blue:36.f/255.f alpha:1.f];
    }
}

- (void)buttonNormalized:(UIButton *)sender
{
    if (sender.tag <= 11)
    {
        sender.backgroundColor = [self numericColor];
    }
    else if (11 < sender.tag && sender.tag < 20)
    {
        sender.backgroundColor = [self singleTargetOperationsColor];
    }
    else
    {
        sender.backgroundColor = [self operationsColor];
    }
}



@end
