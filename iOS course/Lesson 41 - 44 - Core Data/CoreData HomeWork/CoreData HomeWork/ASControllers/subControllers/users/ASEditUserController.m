//
//  ASEditUserController.m
//  CoreData HomeWork
//
//  Created by Alex on 4/24/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASEditUserController.h"
#import "ASUserDetailCell.h"
#import <CoreData/CoreData.h>
#import "ASCoreDataManager.h"
#import "ASUser+CoreDataClass.h"
#import "ASCourse+CoreDataClass.h"
#import "UIColor+CustomColors.h"

static NSString * const kSimpleCellReuseId = @"SimpleCellReuseId";

@interface ASEditUserController () <UITextFieldDelegate>

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSArray *coursesAttended;
@property (nonatomic, strong) NSArray *coursesLead;

@end

@implementation ASEditUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ASUserDetailCell class]) bundle:nil]
         forCellReuseIdentifier:[ASUserDetailCell reuseIdentifier]];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kSimpleCellReuseId];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"BACK" style:UIBarButtonItemStylePlain target:self action:@selector(goBack:)];
    backItem.tintColor = [UIColor mainColor];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)viewWillAppear:(BOOL)animated {
    
    if (self.user) {
        
        [self processUserCourses];
        
        self.navigationItem.title = self.isReadOnly ? @"USER PROFILE" : @"EDIT USER";
        
        self.firstName = self.user.firstName;
        self.lastName = self.user.lastName;
        self.email = self.user.email;
        
    } else {
        self.navigationItem.title = @"ADD USER";
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger number = 1;
    if (self.user.coursesAttended.count) {
        number += 1;
    }
    
    if (self.user.coursesLead.count) {
        number += 1;
    }
    
    return number;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger retVal = 0;
    switch (section) {
        case 0:
            {
                retVal = self.isReadOnly ? 3 : 4;
            }
            break;
            
        case 1:
            {
                if (self.user.coursesAttended.count) {
                    retVal = self.user.coursesAttended.count;
                } else {
                    retVal = self.user.coursesLead.count;
                }
            }
            break;
            
        case 2:
            {
                retVal = self.user.coursesLead.count;
            }
            break;
            
        default:
            break;
    }
    
    return retVal;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *retString = nil;
    switch (section) {
        case 0:
            retString = @"USER PROFILE";
            break;
            
        case 1:
            {
                if (self.user.coursesAttended.count) {
                    retString = @"COURSES ATTENDED";
                } else {
                    retString = @"COURSES LEAD";
                }
            }
            break;
            
        case 2:
            retString = @"COURSES LEAD";
            break;
            
        default:
            break;
    }
    
    return retString;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!indexPath.section) {
        ASUserDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:[ASUserDetailCell reuseIdentifier]            forIndexPath:indexPath];
        
        cell.textField.delegate = self;
        cell.textField.enabled = self.isReadOnly ? NO : YES;
        
        switch (indexPath.row) {
            case 0:
            {
                cell.nameLabel.text = @"First Name:";
                cell.textField.placeholder = self.isReadOnly ? nil : @"Enter first name...";
                cell.textField.tag = 0;
                cell.textField.returnKeyType = UIReturnKeyNext;
                cell.textField.text = self.user ? self.user.firstName : nil;
            }
                break;
                
            case 1:
            {
                cell.nameLabel.text = @"Last Name:";
                cell.textField.placeholder = self.isReadOnly ? nil : @"Enter last name...";
                cell.textField.tag = 1;
                cell.textField.returnKeyType = UIReturnKeyNext;
                cell.textField.text = self.user ? self.user.lastName : nil;
            }
                break;
                
            case 2:
            {
                cell.nameLabel.text = @"Email:";
                cell.textField.placeholder = self.isReadOnly ? nil : @"Enter email...";
                cell.textField.tag = 2;
                cell.textField.returnKeyType = UIReturnKeyDone;
                cell.textField.text = self.user ? self.user.email : nil;
            }
                break;
                
            case 3:
            {
                cell.nameLabel.hidden = YES;
                cell.textField.hidden = YES;
                cell.textLabel.text = @"DONE";
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                cell.textLabel.textColor = [UIColor mainColor];
            }
                break;
                
            default:
                break;
        }
        
        return cell;
        
    } else {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSimpleCellReuseId forIndexPath:indexPath];
        ASCourse *course =  nil;
        if (indexPath.section == 1 && self.user.coursesAttended.count) {
            course = [self.coursesAttended objectAtIndex:indexPath.row];
        } else {
            course = [self.coursesLead objectAtIndex:indexPath.row];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@", course.name];
        
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 3) {
        
        if (!self.isReadOnly) {
            ASUser *user = self.user;
            if (!user) {
                user = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ASUser class]) inManagedObjectContext:[ASCoreDataManager sharedManager].persistentContainer.viewContext];
            }
            
            user.firstName = self.firstName;
            user.lastName = self.lastName;
            user.email = self.email;
            
            NSError *error = nil;
            if (![[ASCoreDataManager sharedManager].persistentContainer.viewContext save:&error]) {
                NSLog(@"%@", error.localizedDescription);
            }
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
    replacementString:(NSString *)string {
    
    switch (textField.tag) {
        case 0:
            {
                NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
                self.firstName = text;
            }
            break;
            
        case 1:
            {
                NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
                self.lastName = text;
            }
            break;
            
        case 2:
            {
                NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
                self.email = text;
            }
            break;
            
        default:
            break;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    switch (textField.tag) {
        case 0:
            {
                ASUserDetailCell *cell = [self getCellForTextFieldId:textField.tag + 1];
                [cell.textField becomeFirstResponder];
            }
            break;
            
        case 1:
            {
                ASUserDetailCell *cell = [self getCellForTextFieldId:textField.tag + 1];
                [cell.textField becomeFirstResponder];
            }
            break;
            
        case 2:
            {
                ASUserDetailCell *cell = [self getCellForTextFieldId:textField.tag];
                [cell.textField resignFirstResponder];
            }
            break;
            
        default:
            break;
    }
    
    return YES;
}

- (ASUserDetailCell *)getCellForTextFieldId:(NSInteger)tagId {
    
    NSArray *cellsArray = [self.tableView visibleCells];
    ASUserDetailCell *reqCell = nil;
    for (ASUserDetailCell *cell in cellsArray) {
        if (cell.textField.tag == tagId) {
            reqCell = cell;
        }
    }
    return reqCell;
}

#pragma mark - Actions

- (void)goBack:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private Methods

- (void)processUserCourses {
    
    NSArray *coursesAttended = [self.user.coursesAttended allObjects];
    NSArray *coursesLead = [self.user.coursesLead allObjects];
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    self.coursesAttended = [coursesAttended sortedArrayUsingDescriptors:@[nameDescriptor]];
    self.coursesLead = [coursesLead sortedArrayUsingDescriptors:@[nameDescriptor]];
    
}


@end
