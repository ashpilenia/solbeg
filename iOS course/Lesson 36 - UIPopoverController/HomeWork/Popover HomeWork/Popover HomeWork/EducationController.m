//
//  EducationController.m
//  Popover HomeWork
//
//  Created by Alex on 1/6/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "EducationController.h"

static NSString * const kCellEducationId = @"kCellEducationId";

@interface EducationController ()

@property (nonatomic, strong) NSArray *educationOptions;

@end

@implementation EducationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellEducationId];
    
    self.educationOptions = @[@"Elementary school",
                              @"High School",
                              @"College",
                              @"Univercity",
                              @"Science Degree"];
    
    self.mainView.layer.cornerRadius = 40;
    self.mainView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.mainView.layer.borderWidth = 3.f;
    self.tableView.layer.cornerRadius = 40;
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellEducationId
                                                            forIndexPath:indexPath];
    
    cell.textLabel.text = [self.educationOptions objectAtIndex:indexPath.row];
    
    if ([self.passedString isEqualToString:cell.textLabel.text]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.delegate didFinishPickingEducation:[self.educationOptions objectAtIndex:indexPath.row]];
    self.delegate.view.alpha = 1.f;
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
