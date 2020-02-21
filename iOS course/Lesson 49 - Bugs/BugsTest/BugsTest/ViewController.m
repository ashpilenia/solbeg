//
//  ViewController.m
//  BugsTest
//
//  Created by Alex Shpilenia on 1/24/20.
//  Copyright © 2020 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"
#import "ASTestViewController.h"

@interface ViewController () <UIAdaptivePresentationControllerDelegate, UIPopoverPresentationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *testButton;
@property (assign, nonatomic) id delegate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[[NSArray arrayWithObjects:@"a", @"b", nil] objectAtIndex:5];
    //[self performSelector:@selector(abc)];
}

#pragma mark - Actions
- (IBAction)popoverAction:(UIButton *)sender {
    
    ASTestViewController *vc = [[ASTestViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:vc animated:YES completion:nil];
    
    UIPresentationController *popController = [vc presentationController];
    popController.delegate = self;
    
//    __weak ASTestViewController *weakVC = vc;
//    vc.block = ^{
//        [vc testMethod];
//    };
    
    self.delegate = vc;
}

#pragma mark - UIAdaptivePresentationControllerDelegate

- (void)presentationControllerDidDismiss:(UIPresentationController *)presentationController {
    
    NSLog(@"EST!!");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.delegate dismissPopoverAnimated:YES]; //Zombie objects in scheme are enabled ->  [ASTestViewController retain]: message sent to deallocated instance 0x7fcf3090bfb0
    });
    
}

@end
