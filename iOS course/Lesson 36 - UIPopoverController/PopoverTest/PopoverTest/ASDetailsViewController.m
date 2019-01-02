//
//  ASDetailsViewController.m
//  PopoverTest
//
//  Created by Alex on 12/28/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "ASDetailsViewController.h"

@interface ASDetailsViewController ()

@end

@implementation ASDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)dealloc {
    NSLog(@"Details deallocated");
}


#pragma mark - UIPopoverPresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    
    return UIModalPresentationNone;
}


- (IBAction)testButtonPressed:(UIButton *)sender {
    
    UIViewController *controller = [[UIViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:controller];
    controller.view.backgroundColor = [UIColor redColor];
    [self presentViewController:nc animated:YES completion:nil];
}
@end
