//
//  ASViewController.m
//  UITableView_editing
//
//  Created by Alex on 11/14/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASViewController.h"
#import "ASEmployee.h"
#import "ASDepartment.h"

static NSInteger departmentsCount = 5;

static NSString *departmentsArray[] = {
    @"Finance", @"IT", @"Security", @"Service", @"Management"
};

@interface ASViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *departments;



@end

@implementation ASViewController

- (void) loadView
{
    [super loadView];
    
    self.departments = [NSMutableArray array];
    
    CGRect frame = self.view.bounds;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    for (int i = 0; i <5; i++)
    {
        ASDepartment *department = [[ASDepartment alloc] init];
        department.name = [NSString stringWithFormat:@"%@ department#%d", departmentsArray[arc4random_uniform(departmentsCount - 1)], i];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (int j = 0; j < (arc4random_uniform(30) + 3); j++)
        {
            ASEmployee *employee = [ASEmployee randomEmployee];
            [tempArray addObject:employee];
        }
        
        department.employeeList = tempArray;
        
        [self.departments addObject:department];
    }
    
    [self.tableView reloadData];
    
    
    self.navigationItem.title = @"Payroll sheet";
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                target:self
                                                                                action:@selector(actionEdit:)];
    self.navigationItem.rightBarButtonItem = editButton;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(actionAdd:)];
    
    self.navigationItem.leftBarButtonItem = addButton;
    
    
}


#pragma mark - Actions

- (void) actionEdit:(UIBarButtonItem *) sender
{
    BOOL isEditing = self.tableView.editing;
    
    [self.tableView setEditing:!isEditing animated:YES];
    
    UIBarButtonSystemItem item = UIBarButtonSystemItemEdit;
    
    if (self.tableView.editing)
    {
        item = UIBarButtonSystemItemDone;
    }
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:item
                                                                                target:self
                                                                                action:@selector(actionEdit:)];
    
    [self.navigationItem setRightBarButtonItem:editButton];
}

- (void) actionAdd:(UIBarButtonItem *) sender
{
    ASDepartment *newDepartment = [[ASDepartment alloc] init];
    NSInteger depCount = [self.departments count];
    newDepartment.name = [NSString stringWithFormat:@"%@ department#%ld", departmentsArray[arc4random_uniform(departmentsCount - 1)], depCount];
    
    NSInteger newSectionIndex = 0;
    [self.departments insertObject:newDepartment atIndex:newSectionIndex];
    
    [self.tableView beginUpdates];
    
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:newSectionIndex];
    
    [self.tableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    
    [self.tableView endUpdates];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
       if ( [[UIApplication sharedApplication] isIgnoringInteractionEvents])
       {
           [[UIApplication sharedApplication] endIgnoringInteractionEvents];
       }
    });
    
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.departments count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ASDepartment *department = [self.departments objectAtIndex:section];
    
    return [department.employeeList count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        static NSString *firstRowID = @"addRowCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:firstRowID];
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstRowID];
        }
        
        cell.textLabel.text = @"New Employee";
        cell.textLabel.textColor = [UIColor cyanColor];
        cell.backgroundColor = [UIColor darkGrayColor];
        
        return cell;
    }
    else
    {
        static NSString *identifier = @"ordinaryCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        }
        
        ASDepartment *department = [self.departments objectAtIndex:indexPath.section];
        ASEmployee *employee = [department.employeeList objectAtIndex:[self getRowAtIndexPath:indexPath]];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", employee.name, employee.lastName];
        cell.textLabel.textColor = [UIColor brownColor];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld$", employee.salary];
        if (employee.salary < 3000)
        {
            cell.detailTextLabel.textColor = [UIColor redColor];
        }
        else if (employee.salary < 7000)
        {
            cell.detailTextLabel.textColor = [UIColor greenColor];
        }
        else
        {
            cell.detailTextLabel.textColor = [UIColor magentaColor];
        }
        
        
        return cell;
    }
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[self.departments objectAtIndex:section] name];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row > 0;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    ASDepartment *sourceDep = [self.departments objectAtIndex:sourceIndexPath.section];
    ASEmployee *employee = [sourceDep.employeeList objectAtIndex:[self getRowAtIndexPath:sourceIndexPath]];
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:sourceDep.employeeList];
    
    if (sourceIndexPath.section == destinationIndexPath.section)
    {
        [tempArray exchangeObjectAtIndex:[self getRowAtIndexPath:sourceIndexPath] withObjectAtIndex:[self getRowAtIndexPath:destinationIndexPath]];
        sourceDep.employeeList = tempArray;
    }
    else
    {
        [tempArray removeObject:employee];
        sourceDep.employeeList = tempArray;
        
        ASDepartment *destinationDep = [self.departments objectAtIndex:destinationIndexPath.section];
        
        tempArray = [NSMutableArray arrayWithArray:destinationDep.employeeList];
        [tempArray insertObject:employee atIndex:[self getRowAtIndexPath:destinationIndexPath]];
        
        destinationDep.employeeList = tempArray;

    }
    
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ASDepartment *department = [self.departments objectAtIndex:indexPath.section];
    ASEmployee *employee = [department.employeeList objectAtIndex:[self getRowAtIndexPath:indexPath]];
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:department.employeeList];
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [tempArray removeObject:employee];
        department.employeeList = tempArray;
        
        [self.tableView beginUpdates];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        
        [self.tableView endUpdates];
    }
}


#pragma mark - UITableViewDelegate

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Delete record";
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row == 0 ? UITableViewCellEditingStyleNone : UITableViewCellEditingStyleDelete;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if (proposedDestinationIndexPath.row == 0)
    {
        return sourceIndexPath;
    }
    else
    {
        return proposedDestinationIndexPath;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0)
    {
        ASDepartment *department = [self.departments objectAtIndex:indexPath.section];
        
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:department.employeeList];
        
        ASEmployee *employee = [ASEmployee randomEmployee];
        
        NSInteger newEmpIndex = 0;
        
        [tempArray insertObject:employee atIndex:newEmpIndex];
        
        department.employeeList = tempArray;
        
        [self.tableView beginUpdates];
        
        NSIndexPath *tempIndexPath= [NSIndexPath indexPathForItem:1 inSection:indexPath.section];
        
        [self.tableView insertRowsAtIndexPaths:@[tempIndexPath] withRowAnimation:UITableViewRowAnimationBottom];
        
        [self.tableView endUpdates];
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        });
    }
        
}

#pragma mark - custom methods

- (NSInteger) getRowAtIndexPath:(NSIndexPath *) indexPath
{
    return indexPath.row - 1;
}

@end
