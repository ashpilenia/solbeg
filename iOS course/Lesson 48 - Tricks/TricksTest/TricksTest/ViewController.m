//
//  ViewController.m
//  TricksTest
//
//  Created by Alex Shpilenia on 10/9/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"
#import "ASUtils.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewTest;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"square.jpg"];
    self.imageViewTest.image = image;
    
#ifdef PRODUCTION_BUILD
    
    NSLog(@"production mode is active");
    
#else
    NSLog(@"debug mode is active");
    
    NSLog(@"%@", fancyDateStringFromDate([NSDate date]));
    
    if (iPad()) {
        NSLog(@"iPad");
    }
    
    if (iPhone()) {
        NSLog(@"iPhone");
    }
    
    NSLog(@"%@", NSStringFromASProgrammerType(ASProgrammerTypeMiddle));
    
    NSLog(APP_SHORT_NAME);
    
    UIColor *someColor = RGBA(12, 160, 145, 250);
    self.view.backgroundColor = someColor;
    
    if (iPad()) {
        ASLog(@"iPad");
    }
    
#endif
    
    [[NSNotificationCenter defaultCenter] addObserverForName:ASLogNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        self.consoleTextView.text = [NSString stringWithFormat:@"%@\n%@", self.consoleTextView.text, [note.userInfo objectForKey:ASLogNotificationTextUserInfoKey]];
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Actions

- (IBAction)actionTest:(UIButton *)sender {
    
    ASLog(@"Action test");
}
@end
