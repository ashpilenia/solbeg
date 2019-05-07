//
//  ASSelectionPopoverController.m
//  CoreData HomeWork
//
//  Created by Alex on 5/6/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASSelectionPopoverController.h"
#import "ASUser+CoreDataClass.h"
#import "UIColor+CustomColors.h"

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
    
    self.buttonView.backgroundColor = [UIColor mainColor];
    self.buttonView.layer.cornerRadius = 10.f;
    self.buttonView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.buttonView.layer.borderWidth = 1.5f;
    
    UITapGestureRecognizer *recognier = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(saveAction:)];
    
    [self.buttonView addGestureRecognizer:recognier];
    
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
        cell.accessoryType = UITableViewCellAccessoryNone;
        if ([self.selectedValues containsObject:user]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.selectedValues];
    ASUser *user = [self.optionsArray objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [tempArray removeObject:user];
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        if (!self.isMultipleSelectionAllowed) {
            if (self.selectedValues.count) {
                ASUser *previousSelection = [self.selectedValues firstObject];
                NSInteger index = [self.optionsArray indexOfObject:previousSelection];
                NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
                
                UITableViewCell *cellForUpdate = [self.tableView cellForRowAtIndexPath:path];
                cellForUpdate.accessoryType = UITableViewCellAccessoryNone;
            }
            
            [tempArray removeAllObjects];
            
        }
        [tempArray addObject:user];
    }
    
    self.selectedValues = tempArray;
}

#pragma mark - Actions

- (void)saveAction:(UITapGestureRecognizer *)sender {
    
    self.buttonView.backgroundColor = [UIColor whiteColor];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.buttonView.backgroundColor = [UIColor mainColor];
    } completion:^(BOOL finished) {
        [self.delegate processSelectedValues:self.selectedValues];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
}


@end
