//
//  ASSelectionPopoverController.h
//  CoreData HomeWork
//
//  Created by Alex on 5/6/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ASselectionPtotocol <NSObject>

@required
- (void)processSelectedValues:(NSArray *)values forTeacher:(BOOL)isTeacher;

@end

@interface ASSelectionPopoverController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIView *buttonView;

@property (nonatomic, strong) NSArray *optionsArray;
@property (nonatomic, strong) NSArray *selectedValues;
@property (nonatomic, assign) BOOL isMultipleSelectionAllowed;
@property (nonatomic, weak) id <ASselectionPtotocol> delegate;

@end

