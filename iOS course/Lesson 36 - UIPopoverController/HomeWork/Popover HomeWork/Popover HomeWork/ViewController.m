//
//  ViewController.m
//  Popover HomeWork
//
//  Created by Alex on 1/2/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"
#import "ApplicationInfoController.h"
#import "ASTableViewCell.h"
#import "ASSegmentedTableViewCell.h"
#import "DatePickerModalConroller.h"
#import "EducationController.h"

@interface ViewController ()

@property (nonatomic, strong) NSDate *selectedBirthDate;
@property (nonatomic, strong) NSString *selectedEducation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ASTableViewCell class])
                                               bundle:nil]
                               forCellReuseIdentifier:[ASTableViewCell reuseIdentifier]];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ASSegmentedTableViewCell class])
                                               bundle:nil]
         forCellReuseIdentifier:[ASSegmentedTableViewCell reuseIdentifier]];
}


- (IBAction)infoButtonAction:(UIBarButtonItem *)sender {
    
    ApplicationInfoController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ApplicationInfoController"];
    
    controller.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController *popover = controller.popoverPresentationController;
    controller.preferredContentSize = CGSizeMake(300, 300);
    popover.delegate = controller;
    popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popover.barButtonItem = sender;
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak typeof (self) weakSelf = self;
    
    UITableViewCell *retCell;
    if (indexPath.row == 2) {
        
        ASSegmentedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ASSegmentedTableViewCell reuseIdentifier] forIndexPath:indexPath];
        
        cell.mainLabel.text = @"Gender";
        retCell = cell;
        
    } else {
        
        ASTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ASTableViewCell reuseIdentifier] forIndexPath:indexPath];
        
        switch (indexPath.row) {
            case 0:
            {
                cell.mainLabel.text = @"First Name";
            }
                break;
            case 1:
            {
                cell.mainLabel.text = @"Last Name";
                cell.isLastNameCell = YES;
                __weak typeof (ASTableViewCell *) weakCell = cell;
                cell.firstNameToLastTransitionBlock = ^{
                    [weakCell.textField becomeFirstResponder];
                };
            }
                break;
            case 3:
            {
                cell.mainLabel.text = @"Birth Date";
                cell.isBirthDateCell = YES;
                if (self.selectedBirthDate) {
                    
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"dd MMM yyyy"];
                    cell.textField.text = [formatter stringFromDate:self.selectedBirthDate];
                }

                cell.birthDateBlock = ^{
                    
                    weakSelf.view.alpha = 0.5f;
                    DatePickerModalConroller *controller = [weakSelf.storyboard instantiateViewControllerWithIdentifier:@"DatePickerModalConroller"];
                    controller.modalPresentationStyle = UIModalPresentationCustom;
                    controller.mainView.layer.cornerRadius = 200;
                    
                    if (weakSelf.selectedBirthDate) {
                        controller.passedDate = weakSelf.selectedBirthDate;
                    }
                    controller.delegate = self;
                    
                    [weakSelf presentViewController:controller animated:YES completion:nil];
                    
                };
            }
                break;
            case 4:
            {
                cell.mainLabel.text = @"Education";
                cell.isEducationCell = YES;
                
                if (self.selectedEducation) {
                    cell.textField.text = self.selectedEducation;
                }
                
                cell.educationBlock = ^{
                    
                    weakSelf.view.alpha = 0.5f;
                    EducationController *controller = [weakSelf.storyboard instantiateViewControllerWithIdentifier:@"EducationController"];
                    controller.modalPresentationStyle = UIModalPresentationCustom;
                    controller.mainView.layer.cornerRadius = 200;
                    
                    if (self.selectedEducation) {
                        controller.passedString = weakSelf.selectedEducation;
                    }
                    controller.delegate = self;
                    
                    [weakSelf presentViewController:controller animated:YES completion:nil];
                    
                };
            }
            default:
                break;
        }
        
        retCell = cell;
    }
    
    return retCell;
}

- (void)didFinishPickingData:(NSDate *)selectedDate {
    
    self.selectedBirthDate = selectedDate;
    [self.tableView reloadData];
}

- (void)didFinishPickingEducation:(NSString *)selectedString {
    
    self.selectedEducation = selectedString;
    [self.tableView reloadData];
}

- (void)dealloc {
    NSLog(@"Main controller is deallocated");
}


@end
