//
//  ASUserDetailsController.h
//  APITest
//
//  Created by Alex on 5/10/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASUser.h"

@interface ASUserDetailsController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) ASUser *user;

- (instancetype)initWithUser:(ASUser *)user;

@end

