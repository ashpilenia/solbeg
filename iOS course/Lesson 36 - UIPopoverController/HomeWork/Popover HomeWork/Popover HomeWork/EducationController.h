//
//  EducationController.h
//  Popover HomeWork
//
//  Created by Alex on 1/6/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EducationController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) ViewController *delegate;
@property (strong, nonatomic) NSString *passedString;

@end

NS_ASSUME_NONNULL_END
