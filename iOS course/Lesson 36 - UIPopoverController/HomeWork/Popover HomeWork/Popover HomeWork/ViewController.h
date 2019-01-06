//
//  ViewController.h
//  Popover HomeWork
//
//  Created by Alex on 1/2/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)infoButtonAction:(UIBarButtonItem *)sender;

- (void)didFinishPickingData:(NSDate *)selectedDate;
- (void)didFinishPickingEducation:(NSString *)selectedString;

@end

