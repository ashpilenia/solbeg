//
//  ASCoursesTableViewController.m
//  CoreDataTest
//
//  Created by Alex on 4/18/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASCoursesTableViewController.h"
#import "ASUniversity+CoreDataClass.h"
#import "ASCourse+CoreDataClass.h"
#import "ASStudetnsTableViewController.h"

@interface ASCoursesTableViewController ()

@end

@implementation ASCoursesTableViewController

@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = @"COURSES";
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:NSStringFromClass([ASCourse class]) inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:description];
    [request setFetchBatchSize:20];
    
    NSSortDescriptor *nameDescriptior = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    [request setSortDescriptors:@[nameDescriptior]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"university == %@", self.university];
    [request setPredicate:predicate];
    
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
    
    ASCourse *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = course.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Students attended: %ld", course.students.count];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ASCourse *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    ASStudetnsTableViewController *vc = [[ASStudetnsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    vc.course = course;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
