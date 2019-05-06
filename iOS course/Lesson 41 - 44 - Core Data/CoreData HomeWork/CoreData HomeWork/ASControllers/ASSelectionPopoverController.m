//
//  ASSelectionPopoverController.m
//  CoreData HomeWork
//
//  Created by Alex on 5/6/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASSelectionPopoverController.h"
#import "ASUser+CoreDataClass.h"

static NSString * const kCellOptionReuseId = @"CellOptionReuseId";

@interface ASSelectionPopoverController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ASSelectionPopoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellOptionReuseId];
    
    self.mainView.layer.cornerRadius = 10;
    self.mainView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.mainView.layer.borderWidth = 3.f;
    self.tableView.layer.cornerRadius = 10;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.optionsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellOptionReuseId forIndexPath:indexPath];
    
    if ([self.optionsArray.firstObject isKindOfClass:[ASUser class]]) {
        
        ASUser *user = [self.optionsArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
        if ([self.selectedValues containsObject:user]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.delegate processSelectedValues:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
