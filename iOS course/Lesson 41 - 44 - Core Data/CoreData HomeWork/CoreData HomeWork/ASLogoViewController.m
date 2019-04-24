//
//  ASLogoViewController.m
//  CoreData HomeWork
//
//  Created by Alex on 4/24/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASLogoViewController.h"

@interface ASLogoViewController ()

@end

@implementation ASLogoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"firstController"];
        [self presentViewController:vc animated:YES completion:nil];
    });
    
}



@end
