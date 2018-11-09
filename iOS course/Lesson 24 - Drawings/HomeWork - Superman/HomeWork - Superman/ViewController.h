//
//  ViewController.h
//  HomeWork - Superman
//
//  Created by Alex on 11/9/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *tempDrawImage;
@property (nonatomic, weak) IBOutlet UIImageView *mainImage;

- (IBAction)pencilPressed:(UIButton *)sender;
- (IBAction)eraserPressed:(UIButton *)sender;


@end

