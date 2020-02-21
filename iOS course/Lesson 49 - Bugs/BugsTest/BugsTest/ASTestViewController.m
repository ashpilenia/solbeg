//
//  ASTestViewController.m
//  BugsTest
//
//  Created by Alex Shpilenia on 1/24/20.
//  Copyright © 2020 Alex Shpilenia. All rights reserved.
//

#import "ASTestViewController.h"

@interface ASTestViewController ()

@end

@implementation ASTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect r = self.view.bounds;
    r.origin = CGPointZero;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:r];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"imageTest" ofType:@"jpg"];
    imageView.image = [UIImage imageWithContentsOfFile:filePath];
    [self.view addSubview:imageView];
    
    CGMutablePathRef path  = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, &CGAffineTransformIdentity, CGRectZero);
   
    //CGPathRelease(path);
    
    
}

- (void)testMethod {
    NSLog(@"BUG!");
}

- (void)dealloc {
    NSLog(@"ASTestViewController deallocated");
}

@end
