//
//  ViewController.m
//  ButtonsTest
//
//  Created by Alex on 11/29/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(200, 200, 130, 100);
    
    button.backgroundColor = [UIColor grayColor];
    
//    UIEdgeInsets insets = UIEdgeInsetsMake(30, 30, 0, 0);
//    button.titleEdgeInsets = insets;
    
//    NSDictionary *parameters = @{
//                                 NSForegroundColorAttributeName : [UIColor orangeColor],
//                                 NSFontAttributeName            : [UIFont boldSystemFontOfSize:24.f]
//                                 };
//    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"Button" attributes:parameters];
//    [button setAttributedTitle:title forState:UIControlStateNormal];
//
//    NSDictionary *parameters2 = @{
//                                 NSForegroundColorAttributeName : [UIColor redColor],
//                                 NSFontAttributeName            : [UIFont boldSystemFontOfSize:16.f]
//                                 };
//    NSAttributedString *title2 = [[NSAttributedString alloc] initWithString:@"Button" attributes:parameters2];
//    [button setAttributedTitle:title2 forState:UIControlStateHighlighted];
    
    [button setTitle:@"Button" forState:UIControlStateNormal];
    [button setTitle:@"Button pressed" forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    
    [button addTarget:self action:@selector(actionTestIn:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(actionTestOut:) forControlEvents:UIControlEventTouchUpOutside];
    
    [self.view addSubview:button];
}

#pragma mark - Actions

- (void)actionTestIn:(UIButton *)sender
{
    NSLog(@"INSIDE!!!");
}

- (void)actionTestOut:(UIButton *)sender
{
    NSLog(@"OUTSIDE!!!");
}

- (IBAction)actionTest2:(UIButton *)sender
{
    NSLog(@"Button %ld pressed", (long)sender.tag);
    self.indicatorLabel.text = [NSString stringWithFormat:@"%ld", sender.tag];
}

- (IBAction)actionTest2TouchDown:(UIButton *)sender
{
    //NSLog(@"Test 2 Touch Down");
}


@end
