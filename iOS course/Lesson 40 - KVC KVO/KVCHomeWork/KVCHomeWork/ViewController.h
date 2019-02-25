//
//  ViewController.h
//  KVCHomeWork
//
//  Created by Alex on 2/21/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASStudent.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) ASStudent *student;


@end

