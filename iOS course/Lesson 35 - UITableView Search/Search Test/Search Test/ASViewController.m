//
//  ASViewController.m
//  Search Test
//
//  Created by Alex on 2/7/18.
//  Copyright © 2018 Alex Shpilenia. All rights reserved.
//

#import "ASViewController.h"
#import "NSString+Random.h"
#import "ASSection.h"

@interface ASViewController ()

@property (strong, nonatomic) NSArray *namesArray;
@property (strong, nonatomic) NSArray *sectionsArray;

@property (strong, nonatomic) NSOperation *currentOperation;


@end

@implementation ASViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i <2000000 ; i++)
    {
        [array addObject:[[NSString randomString] capitalizedString]];
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
    
    [array sortUsingDescriptors:@[sortDescriptor]];
    
    self.namesArray = array;
    [self generateSectionsInBackgroundFromArray:self.namesArray withFilter:self.searchBar.text];

}

- (void) generateSectionsInBackgroundFromArray:(NSArray *) array withFilter:(NSString *) filterString {
    
    __weak typeof (self) weakSelf = self;
    
    self.currentOperation = [NSBlockOperation blockOperationWithBlock:^{
        
        NSArray *sectionsArray = [weakSelf generateSectionsFromArray:array withFilter:filterString];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.sectionsArray = sectionsArray;
            [self.tableView reloadData];
            
            weakSelf.currentOperation = nil;
        });
    }];
    
    NSOperationQueue *myQueue = [[NSOperationQueue alloc] init];
    [myQueue addOperation:self.currentOperation];
}

- (NSArray *) generateSectionsFromArray:(NSArray *) array withFilter:(NSString *) filterString {
    
    NSMutableArray *sectionsArray = [NSMutableArray array];
    
    NSString *currentLetter = nil;
    
    for (NSString *string in array)
    {
        
        if (filterString.length > 0 && [string rangeOfString:filterString].location == NSNotFound) {
            continue;
        }
        NSString *firstLetter = [string substringToIndex:1];
        
        ASSection *section = nil;
        
        if (![currentLetter isEqualToString:firstLetter])
        {
            section = [[ASSection alloc] init];
            section.sectionName = firstLetter;
            section.itemsArray = [NSMutableArray array];
            currentLetter = firstLetter;
            [sectionsArray addObject:section];
        }
        else
        {
            section = [sectionsArray lastObject];
        }
        [section.itemsArray addObject:string];
    }
    return sectionsArray;
}

#pragma mark - UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionsArray.count;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[self.sectionsArray objectAtIndex:section] sectionName];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ASSection *sec = [self.sectionsArray objectAtIndex:section];
    return sec.itemsArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    ASSection *sec = [self.sectionsArray objectAtIndex:indexPath.section];
    NSString *name = [sec.itemsArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = name;
    
    return cell;
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (ASSection *section in self.sectionsArray)
    {
        [array addObject:section.sectionName];
    }
    
    return array;
}


#pragma mark - UISearchBarDelegate

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"textDidChange %@", searchText);
    [self generateSectionsInBackgroundFromArray:self.namesArray withFilter:searchText];
}

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}


@end
