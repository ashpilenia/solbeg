//
//  ViewController.m
//  Popover HomeWork
//
//  Created by Alex on 1/2/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"
#import "ApplicationInfoController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)infoButtonAction:(UIBarButtonItem *)sender {
    
    ApplicationInfoController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ApplicationInfoController"];
    
    controller.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController *popover = controller.popoverPresentationController;
    controller.preferredContentSize = CGSizeMake(300, 300);
    popover.delegate = controller;
    popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popover.barButtonItem = sender;
    
    [self presentViewController:controller animated:YES completion:nil];
}
@end
