//
//  ASUsersControllers.m
//  CoreData HomeWork
//
//  Created by Alex on 4/24/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASUsersControllers.h"
#import "ASCoreDataManager.h"
#import "ASUser+CoreDataClass.h"
#import "ASEditUserController.h"
#import "UIColor+CustomColors.h"

static NSString * const kCellReuseId = @"CellReuseId";

@interface ASUsersControllers ()

@end

@implementation ASUsersControllers

@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"USERS";
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addUserAction:)];
    barButton.tintColor = [UIColor mainColor];
    self.navigationItem.rightBarButtonItem = barButton;
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:NSStringFromClass([ASUser class]) inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:description];

    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];

    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];

    [fetchRequest setSortDescriptors:@[sortDescriptor]];

    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;

    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }

    _fetchedResultsController = aFetchedResultsController;
    return _fetchedResultsController;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [[self.fetchedResultsController sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellReuseId];
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    ASUser *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Courses Attended: %ld", user.coursesAttended.count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ASEditUserController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ASEditUserController"];
    vc.user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Actions

- (void)addUserAction:(UIBarButtonItem *)sender {
    
    ASEditUserController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ASEditUserController"];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
