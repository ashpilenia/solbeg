//
//  ASEditUserController.h
//  CoreData HomeWork
//
//  Created by Alex on 4/24/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASUser;

@interface ASEditUserController : UITableViewController

@property (nonatomic, assign) BOOL isReadOnly;
@property (nonatomic, strong) ASUser *user;

@end
