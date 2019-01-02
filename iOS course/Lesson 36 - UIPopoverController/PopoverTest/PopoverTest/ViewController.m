//
//  ViewController.m
//  PopoverTest
//
//  Created by Alex on 12/19/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"
#import "ASDetailsViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - Actions

- (void)popoverAction:(id)sender {
    
    ASDetailsViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ASDetailsViewController"];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    navController.modalPresentationStyle = UIModalPresentationPopover;
    UIPopoverPresentationController *popover = navController.popoverPresentationController;
    
    controller.preferredContentSize = CGSizeMake(300.f, 300.f);
    
    popover.delegate = controller;
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        popover.barButtonItem = sender;
    } else if ([sender isKindOfClass:[UIButton class]]) {
        popover.sourceView = sender;
    } else {
        return;
    }
    
    popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
    
    [self presentViewController:navController animated:YES completion:nil];
    
}

- (IBAction)actionAdd:(UIBarButtonItem *)barButton {
    
    [self popoverAction:barButton];
}

- (IBAction)pressMe:(UIButton *)button {
    
    [self popoverAction:button];
    
}


@end
