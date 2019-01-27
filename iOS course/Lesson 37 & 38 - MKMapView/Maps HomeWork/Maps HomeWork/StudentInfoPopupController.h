//
//  StudentInfoPopupController.h
//  Maps HomeWork
//
//  Created by Alex on 1/27/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASStudent;


@interface StudentInfoPopupController : UIViewController <UIPopoverPresentationControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ASStudent *student;

@end


