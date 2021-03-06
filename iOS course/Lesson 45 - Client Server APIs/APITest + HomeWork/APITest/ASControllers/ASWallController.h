//
//  ASWallController.h
//  APITest
//
//  Created by Alex on 5/15/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASUser;

@interface ASWallController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) ASUser *user;
@property (nonatomic, strong) NSArray *itemsArray;

- (instancetype)initWithUser:(ASUser *)user;


@end

