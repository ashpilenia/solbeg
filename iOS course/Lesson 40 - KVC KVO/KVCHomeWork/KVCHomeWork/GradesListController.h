//
//  GradesListController.h
//  KVCHomeWork
//
//  Created by Alex on 2/23/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface GradesListController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) ViewController *delegate;

@end

