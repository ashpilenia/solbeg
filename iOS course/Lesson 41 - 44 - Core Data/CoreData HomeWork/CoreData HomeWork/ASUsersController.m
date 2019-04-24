//
//  ASUsersController.m
//  CoreData HomeWork
//
//  Created by Alex on 4/23/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASUsersController.h"
#import "ASCoreDataManager.h"
#import "ASUser+CoreDataClass.h"

@interface ASUsersController ()

@end

@implementation ASUsersController

@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[ASCoreDataManager sharedManager] generateTestData];
    
    
    [self showAllRecords];

    self.navigationItem.title = @"USERS";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}

- (void)showAllRecords {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:NSStringFromClass([ASUser class]) inManagedObjectContext:self.managedObjectContext];
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    
    [request setEntity:description];
    [request setSortDescriptors:@[descriptor]];
    
    NSError *error = nil;
    NSArray *usersArray = [request execute:&error];
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    } else {
        NSLog(@"%@ Count: %ld", usersArray, usersArray.count);
    }
}

#pragma mark - Fetched results controller

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

@end
