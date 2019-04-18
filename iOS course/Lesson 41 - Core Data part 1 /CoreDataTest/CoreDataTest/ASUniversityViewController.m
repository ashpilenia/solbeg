//
//  ASUniversityViewController.m
//  CoreDataTest
//
//  Created by Alex on 4/16/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASUniversityViewController.h"
#import "ASUniversity+CoreDataClass.h"
#import "ASCoursesTableViewController.h"

@interface ASUniversityViewController ()

@end

@implementation ASUniversityViewController

@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"UNIVERSITIES";
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:NSStringFromClass([ASUniversity class]) inManagedObjectContext:self.managedObjectContext];

    [request setEntity:description];
    [request setFetchBatchSize:20];

    NSSortDescriptor *nameDescriptior = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];

    [request setSortDescriptors:@[nameDescriptior]];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                                                managedObjectContext:self.managedObjectContext
                                                                                                  sectionNameKeyPath:nil
                                                                                                           cacheName:nil];
    aFetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    _fetchedResultsController = aFetchedResultsController;
    return _fetchedResultsController;
}

#pragma mark - UITableViewDataSource

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    ASUniversity *university = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = university.name;
    cell.detailTextLabel.text = nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ASUniversity *university = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    ASCoursesTableViewController *vc = [[ASCoursesTableViewController alloc] initWithStyle:UITableViewStylePlain];
    vc.university = university;
    
    [self.navigationController pushViewController:vc animated:YES];
}


@end
