//
//  ASEditCourseController.m
//  CoreData HomeWork
//
//  Created by Alex on 5/6/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASEditCourseController.h"
#import "ASUserDetailCell.h"
#import <CoreData/CoreData.h>
#import "ASCoreDataManager.h"
#import "ASCourse+CoreDataClass.h"
#import "ASUser+CoreDataClass.h"
#import "UIColor+CustomColors.h"
#import "ASEditUserController.h"
#import "ASSelectionPopoverController.h"

static NSString * const kStudentCellReuseId = @"StudentCellReuseId";

@interface ASEditCourseController () <UITextFieldDelegate, ASselectionPtotocol>

@property (nonatomic, strong) NSString *courseName;
@property (nonatomic, strong) NSString *courseSubject;
@property (nonatomic, strong) NSString *courseBranch;
@property (nonatomic, strong) ASUser *teacher;
@property (nonatomic ,strong) NSArray *studentsArray;


@end

@implementation ASEditCourseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ASUserDetailCell class]) bundle:nil]
         forCellReuseIdentifier:[ASUserDetailCell reuseIdentifier]];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kStudentCellReuseId];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"BACK" style:UIBarButtonItemStylePlain target:self action:@selector(goBack:)];
    backItem.tintColor = [UIColor mainColor];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    if (self.course) {
        self.navigationItem.title = @"EDIT COURSE";
    } else {
        self.navigationItem.title = @"ADD COURSE";
    }
    
    [self setupInitialConfig];
}

- (void)setupInitialConfig {
    
    if (self.course) {
        
        self.courseName = self.course.name;
        self.courseSubject = self.course.subject;
        self.courseBranch = self.course.branch;
        self.teacher = self.course.teacher;
        self.studentsArray = [self.course.students allObjects];
        NSSortDescriptor *descriptior = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
        self.studentsArray = [self.studentsArray sortedArrayUsingDescriptors:@[descriptior]];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.course ? 2 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger retVal = 0;
    switch (section) {
        case 0:
            retVal = 5;
            break;
            
        case 1:
            retVal = self.course.students.count + 1;
            break;
            
        default:
            break;
    }
    return retVal;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!indexPath.section) {
        ASUserDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:[ASUserDetailCell reuseIdentifier] forIndexPath:indexPath];
        
        cell.textField.delegate = self;
        
        switch (indexPath.row) {
            case 0:
            {
                cell.nameLabel.text = @"Name:";
                cell.textField.placeholder = @"Enter course name...";
                cell.textField.tag = 0;
                cell.textField.returnKeyType = UIReturnKeyNext;
                if (self.course) {
                    cell.textField.text = self.course.name;
                } else {
                    cell.textField.text = self.courseName ? self.courseName : nil;
                }
            }
                break;
                
            case 1:
            {
                cell.nameLabel.text = @"Subject:";
                cell.textField.placeholder = @"Enter course subject...";
                cell.textField.tag = 1;
                cell.textField.returnKeyType = UIReturnKeyNext;
                if (self.course) {
                    cell.textField.text = self.course.subject;
                } else {
                    cell.textField.text = self.courseSubject ? self.courseSubject : nil;
                }
            }
                break;
                
            case 2:
            {
                cell.nameLabel.text = @"Branch:";
                cell.textField.placeholder = @"Enter course branch...";
                cell.textField.tag = 2;
                cell.textField.returnKeyType = UIReturnKeyDone;
                if (self.course) {
                    cell.textField.text = self.course.branch;
                } else {
                    cell.textField.text = self.courseBranch ? self.courseBranch : nil;
                }
            }
                break;
                
            case 3:
            {
                cell.nameLabel.text = @"Teacher:";
                cell.textField.tag = 3;
                cell.textField.textColor = [UIColor mainColor];
                
                if (self.course.teacher) {
                    cell.textField.text = [NSString stringWithFormat:@"%@ %@", self.course.teacher.firstName, self.course.teacher.lastName];
                } else {
                    cell.textField.text = self.teacher ? [NSString stringWithFormat:@"%@ %@", self.teacher.firstName, self.teacher.lastName] : @"Select a teacher";
                }
                
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                             action:@selector(selectTeacherAction:)];
                [cell.textField addGestureRecognizer:tapGesture];
            }
                break;
                
            case 4:
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
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kStudentCellReuseId];
        
        if (!indexPath.row) {
            cell.textLabel.text = @"ADD STUDENT";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textColor = [UIColor mainColor];
        } else {
            ASUser *student = [self.studentsArray objectAtIndex:indexPath.row - 1];
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
        }

        return cell;
    }
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = nil;
    if (!section) {
        title = @"COURSE INFO";
    } else {
        title = @"STUDENTS";
    }
    return title;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 4 && indexPath.section == 0) {

        ASCourse *course = self.course;
        if (!course) {
            course = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ASCourse class]) inManagedObjectContext:[ASCoreDataManager sharedManager].persistentContainer.viewContext];
        }

        course.name = self.courseName;
        course.subject = self.courseSubject;
        course.branch = self.courseBranch;
        course.teacher = self.teacher;

        NSError *error = nil;
        if (![[ASCoreDataManager sharedManager].persistentContainer.viewContext save:&error]) {
            NSLog(@"%@", error.localizedDescription);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } else if (indexPath.row == 0 && indexPath.section == 1) {
        
        [self invokeSelectionPopoverWithMultipleSelections:YES];
        
    } else if (indexPath.section) {
        
        ASUser *user = [self.studentsArray objectAtIndex:indexPath.row -1];
        ASEditUserController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ASEditUserController class])];
        vc.user = user;
        vc.isReadOnly = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [ASCoreDataManager sharedManager].persistentContainer.viewContext;
        
        ASUser *user = [self.studentsArray objectAtIndex:indexPath.row - 1];
        NSMutableSet *courses = [NSMutableSet setWithArray:[user.coursesAttended allObjects]];
        [courses removeObject:self.course];
        user.coursesAttended = courses;

        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            abort();
        }
        
        self.course = [self reloadCurrentCourse];
        [self setupInitialConfig];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section && indexPath.row) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    
    switch (textField.tag) {
        case 0:
        {
            NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
            self.courseName = text;
        }
            break;
            
        case 1:
        {
            NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
            self.courseSubject = text;
        }
            break;
            
        case 2:
        {
            NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
            self.courseBranch = text;
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

- (void)selectTeacherAction:(UITapGestureRecognizer *)sender {
    
    [self invokeSelectionPopoverWithMultipleSelections:NO];
}

#pragma mark - Core Data

- (ASCourse *)reloadCurrentCourse {
    
    NSManagedObjectContext *context = [ASCoreDataManager sharedManager].persistentContainer.viewContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:NSStringFromClass([ASCourse class]) inManagedObjectContext:context];
    [request setEntity:description];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", self.course.name];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *coursesArray = [context executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }
    if (coursesArray.count != 1) {
        NSLog(@"Something went wrong! Unexpected fetch result.");
        return nil;
    }
    
    return coursesArray.firstObject;
}

- (NSArray <ASUser *> *)loadAllUsers {
    
    NSManagedObjectContext *context = [ASCoreDataManager sharedManager].persistentContainer.viewContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:NSStringFromClass([ASUser class]) inManagedObjectContext:context];
    [request setEntity:description];
    
    NSError *error = nil;
    NSArray *usersArray = [context executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"%@", error.localizedDescription);
        return nil;
    } else {
        return usersArray;
    }
}

#pragma mark - ASselectionPtotocol

- (void)processSelectedValues:(NSArray *)values forTeacher:(BOOL)isTeacher {
    
    self.view.alpha = 1.f;
    
    if (isTeacher) {
        if (self.course) {
            self.course.teacher = values.firstObject;
        } else {
            self.teacher = values.firstObject;
        }
    } else {
        self.course.students = [NSSet setWithArray:values];
    }
    
    NSError *error = nil;
    if (![[ASCoreDataManager sharedManager].persistentContainer.viewContext save:&error]) {
        NSLog(@"%@", error.localizedDescription);
    }
    
    [self setupInitialConfig];
    [self.tableView reloadData];
    
}

#pragma mark - Private Methods

- (void)invokeSelectionPopoverWithMultipleSelections:(BOOL)allowed {
    
    NSArray *subscribedStudents = [self.course.students allObjects];
    NSArray *allStudents = [self loadAllUsers];
    
    ASSelectionPopoverController *popover = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ASSelectionPopoverController class])];
    
    popover.isMultipleSelectionAllowed = allowed;
    popover.optionsArray = allStudents;
    if (allowed) {
        popover.selectedValues = subscribedStudents;
    } else {
        popover.selectedValues = self.teacher ? @[self.teacher] : nil;
    }
    popover.delegate = self;
    
    self.view.alpha = 0.5f;
    popover.modalPresentationStyle = UIModalPresentationCustom;
    
    [self.navigationController presentViewController:popover animated:YES completion:nil];
    
}


@end
