//
//  GradesListController.m
//  KVCHomeWork
//
//  Created by Alex on 2/23/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "GradesListController.h"

static NSString * const kdropDownCellReuseId = @"dropDownCellReuseId";

@interface GradesListController ()

@end

@implementation GradesListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kdropDownCellReuseId];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kdropDownCellReuseId];
    
    cell.textLabel.text = [self setCellTextLabel:indexPath];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.delegate.student.grade = indexPath.row;
    [self.delegate.tableView reloadData];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40.f;
}

#pragma Private Methods

- (NSString *)setCellTextLabel:(NSIndexPath *)indexPath {
    
    NSString *retString;
    switch (indexPath.row) {
        case 0:
        {
            retString = @"Grade:          High School";
        }
            break;
            
        case 1:
        {
            retString = @"                     Univercity";
        }
            break;
            
        case 2:
        {
            retString = @"                     Magistr";
        }
            break;
            
        case 3:
        {
            retString = @"                     Professor";
        }
            break;
    }
    return retString;
}

+ (NSString *)reuseIdentifier {
    
    return @"gradeCellReuseIdentifier";
}



@end
