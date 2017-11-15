//
//  ASViewController.m
//  TableView Editing part 1
//
//  Created by Alex on 11/9/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import "ASViewController.h"
#import "ASStudent.h"
#import "ASGroup.h"

@interface ASViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *groups;

@end

@implementation  ASViewController

- (void) loadView
{
    [super loadView];
    
    CGRect frame = self.view.bounds;
    frame.origin = CGPointZero;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.allowsSelectionDuringEditing = NO;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.groups = [NSMutableArray array];
    
    for (int i = 0; i < arc4random() % 6 + 5; i++) {
        ASGroup *group = [[ASGroup alloc] init];
        group.name = [NSString stringWithFormat:@"Group #%d", i];
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (int j = 0; j < arc4random() % 11 + 15; j++) {
            [array addObject:[ASStudent randomStudent]];
        }
        
        group.students = array;
        
        [self.groups addObject:group];
    }
    [self.tableView reloadData];
    
    self.navigationItem.title = @"Students";
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                target:self
                                                                                action:@selector(actionEdit:)];
    
    self.navigationItem.rightBarButtonItem = editButton;
    
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(actionAddSection:)];
    
    self.navigationItem.leftBarButtonItem = addButton;
    

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    ASGroup *group = [self.groups objectAtIndex:section];
    return [group.students count] + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if (indexPath.row == 0)
    {
        static NSString *addStudIdentifier = @"addStudentCell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:addStudIdentifier];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addStudIdentifier];
            cell.textLabel.text = @"Add Student";
            cell.textLabel.textColor = [UIColor blueColor];
        }
        return cell;
    }
    else
    {
    
    static NSString *identifier = @"studentCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    ASGroup *group = [self.groups objectAtIndex:indexPath.section];
    ASStudent *student = [group.students objectAtIndex:indexPath.row - 1];
    
    cell.textLabel.text = [NSString stringWithFormat:@" %@, %@", student.firstName, student.lastName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%1.2f", student.averageGrade];
    
    if (student.averageGrade >= 4.0)
    {
        cell.detailTextLabel.textColor = [UIColor greenColor];
    }
    else if (student.averageGrade >= 3.0)
    {
        cell.detailTextLabel.textColor = [UIColor orangeColor];
    }
    else
    {
        cell.detailTextLabel.textColor = [UIColor redColor];
    }
    
    return cell;
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    ASGroup *group = [self.groups objectAtIndex:indexPath.section];
    //    ASStudent *student = [group.students objectAtIndex:indexPath.row];
    //
    //    return student.averageGrade < 4.f;
    return indexPath.row > 0;
    
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    ASGroup *sourceGroup = [self.groups objectAtIndex:sourceIndexPath.section];
    ASStudent *student = [sourceGroup.students objectAtIndex:sourceIndexPath.row - 1];
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:sourceGroup.students];
    
    if (sourceIndexPath.section == destinationIndexPath.section)
    {
        [tempArray  exchangeObjectAtIndex:sourceIndexPath.row - 1 withObjectAtIndex:destinationIndexPath.row - 1];
        sourceGroup.students = tempArray;
    }
    else
    {
        [tempArray removeObject:student];
        sourceGroup.students = tempArray;
        
        ASGroup *destinationGroup = [self.groups objectAtIndex:destinationIndexPath.section];
        tempArray = [NSMutableArray arrayWithArray:destinationGroup.students];
        [tempArray insertObject:student atIndex:destinationIndexPath.row - 1];
        destinationGroup.students = tempArray;
    }
    
    
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.groups count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[self.groups objectAtIndex:section] name];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        ASGroup *group = [self.groups objectAtIndex:indexPath.section];
        ASStudent *student = [group.students objectAtIndex:indexPath.row - 1];
        
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:group.students];
        [tempArray removeObject:student];
        group.students = tempArray;
        
        [self.tableView beginUpdates];
    
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.tableView endUpdates];
    }
}

#pragma mark - UITableViewDelegate

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
        ASGroup *group = [self.groups objectAtIndex:indexPath.section];
        
        NSMutableArray *tempArray = nil;
        
        if (group.students)
        {
            tempArray = [NSMutableArray arrayWithArray:group.students];
        }
        else
        {
            tempArray = [NSMutableArray array];
        }
        
        NSInteger newStudentIndex = 0;
        [tempArray insertObject:[ASStudent randomStudent] atIndex:newStudentIndex];
        
        group.students = tempArray;
        
        [self.tableView beginUpdates];
        
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:newStudentIndex + 1 inSection:indexPath.section];
        
        [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationTop];
        
        [self.tableView endUpdates];
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if ([[UIApplication sharedApplication] isIgnoringInteractionEvents])
            {
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            }
            
        });
        
    }
    
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Remove";
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
    [self.navigationItem setRightBarButtonItem:editButton animated:YES];
    
}

- (void) actionAddSection:(UIBarButtonItem *) sender
{
    ASGroup *group = [[ASGroup alloc] init];
    group.name = [NSString stringWithFormat:@"Group #%ld", [self.groups count] + 1];
    group.students = @[[ASStudent randomStudent], [ASStudent randomStudent]];
    
    NSInteger newSectionIndex = 0;
    
    [self.groups insertObject:group atIndex:newSectionIndex];

    [self.tableView beginUpdates];
    
    NSIndexSet *insertSections = [[NSIndexSet alloc] initWithIndex:newSectionIndex];
    
    [self.tableView insertSections:insertSections withRowAnimation: [self.groups count] % 2 ? UITableViewRowAnimationRight : UITableViewRowAnimationLeft];

    [self.tableView endUpdates];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     
        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents ])
        {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
        
    });
    
    
    
}

@end

