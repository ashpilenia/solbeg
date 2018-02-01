//
//  ASDirectoryViewController.h
//  FileManagerTest
//
//  Created by Alex on 11/16/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASDirectoryViewController : UITableViewController

@property (nonatomic, strong) NSString *path;

- (id) initWithFolderPath:(NSString *) path;

- (IBAction) actionInfoCell:(id)sender;

@end
