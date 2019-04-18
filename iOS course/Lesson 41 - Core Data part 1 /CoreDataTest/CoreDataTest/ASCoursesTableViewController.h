//
//  ASCoursesTableViewController.h
//  CoreDataTest
//
//  Created by Alex on 4/18/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASCoreDataTableViewController.h"

@class ASUniversity;

@interface ASCoursesTableViewController : ASCoreDataTableViewController

@property (nonatomic, strong) ASUniversity *university;

@end

