//
//  StudentInfoPopupController.m
//  Maps HomeWork
//
//  Created by Alex on 1/27/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "StudentInfoPopupController.h"
#import "ASStudent.h"
#import "NSDateFormatter+Methods.h"

static NSString * const kTableViewReuseIdentifier = @"kTableViewReuseIdentifier";

@interface StudentInfoPopupController ()

@property (nonatomic, strong) CLPlacemark *placemark;
@property (nonatomic, assign) BOOL isFinishedLoading;

@end

@implementation StudentInfoPopupController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isFinishedLoading = NO;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewReuseIdentifier];
    
    [self getPlaceMarkFromCoordinate:self.student.coordinate];
   
}

#pragma mark - Private Methods

- (void)getPlaceMarkFromCoordinate:(CLLocationCoordinate2D)coordinate {
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    
    __weak typeof (self) weakSelf = self;
    
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
    
        self.isFinishedLoading = YES;
        
        if (!error && placemarks.count) {
            weakSelf.placemark = [placemarks firstObject];
            [weakSelf.tableView reloadData];
        }
    }];
    
}

#pragma mark - UIPopoverPresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    
    return UIModalPresentationNone;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.student) {
        return 5;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewReuseIdentifier forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = [NSString stringWithFormat:@"Name: %@", self.student.name];
        }
        break;
        case 1:
        {
            cell.textLabel.text = [NSString stringWithFormat:@"Last Name: %@", self.student.lastName];
        }
            break;
        case 2:
        {
            NSDateFormatter *formatter = [NSDateFormatter uiDateFormatter];
            cell.textLabel.text = [NSString stringWithFormat:@"Birthday: %@",
                                   [formatter stringFromDate:self.student.birthDate]];
        }
            break;
        case 3:
        {
            if (self.student.gender == male) {
                cell.textLabel.text = @"Gender: Male";
            } else {
                cell.textLabel.text = @"Gender: Female";
            }
            
        }
            break;
        case 4:
        {
            if (self.isFinishedLoading) {
                if (self.placemark) {
                    cell.textLabel.text = [NSString stringWithFormat:@"ADDRESS: %@ %@", self.placemark.name, self.placemark.country];
                } else {
                    cell.textLabel.text = @"ADDRESS: Loading failed";
                }
            } else {
                cell.textLabel.text = @"ADDRESS: Loading...";
            }
        }
            break;
    }
    
    cell.textLabel.textColor = [UIColor blackColor];
    
    return cell;
    
}


@end
