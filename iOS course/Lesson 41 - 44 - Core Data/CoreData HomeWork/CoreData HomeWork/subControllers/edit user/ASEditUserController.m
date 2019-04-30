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
#import "UIColor+CustomColors.h"

@interface ASEditUserController () <UITextFieldDelegate>

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *email;

@end

@implementation ASEditUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ASUserDetailCell class]) bundle:nil]
         forCellReuseIdentifier:[ASUserDetailCell reuseIdentifier]];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"BACK" style:UIBarButtonItemStylePlain target:self action:@selector(goBack:)];
    backItem.tintColor = [UIColor mainColor];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    if (self.user) {
        self.navigationItem.title = @"EDIT USER";
    } else {
        self.navigationItem.title = @"ADD USER";
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ASUserDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:[ASUserDetailCell reuseIdentifier]            forIndexPath:indexPath];
    
    cell.textField.enabled = self.isReadOnly ? NO : YES;
    cell.textField.delegate = self;
    
    switch (indexPath.row) {
        case 0:
            {
                cell.nameLabel.text = @"First Name:";
                cell.textField.placeholder = @"Enter first name...";
                cell.textField.tag = 0;
                cell.textField.returnKeyType = UIReturnKeyNext;
            }
            break;
            
        case 1:
            {
                cell.nameLabel.text = @"Last Name:";
                cell.textField.placeholder = @"Enter last name...";
                cell.textField.tag = 1;
                cell.textField.returnKeyType = UIReturnKeyNext;
            }
            break;
            
        case 2:
            {
                cell.nameLabel.text = @"Email:";
                cell.textField.placeholder = @"Enter email...";
                cell.textField.tag = 2;
                cell.textField.returnKeyType = UIReturnKeyDone;
            }
            break;
            
        case 3:
            {
                cell.nameLabel.hidden = YES;
                cell.textField.hidden = YES;
                cell.textLabel.text = @"DONE";
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                cell.textLabel.textColor = [UIColor blueColor];
                cell.layer.borderWidth = 0.3;
                cell.layer.borderColor = [UIColor blueColor].CGColor;
            }
            break;
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 3) {
        
        ASUser *user = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ASUser class]) inManagedObjectContext:[ASCoreDataManager sharedManager].persistentContainer.viewContext];
        
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


@end
