//
//  ASUserDetailsController.m
//  APITest
//
//  Created by Alex on 5/10/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASUserDetailsController.h"
#import "ASServerManager.h"
#import "ASPhotoCell.h"
#import "ASTwoButtonsCell.h"
#import "ASSingleButtonCell.h"
#import "UIImageView+AFNetworking.h"
#import "ASSubscribersController.h"
#import "ASFollowersController.h"
#import "ASWallController.h"

static NSString * const kFirstCellId = @"FirstCellId";

@interface ASUserDetailsController ()

@end

@implementation ASUserDetailsController 

- (instancetype)initWithUser:(ASUser *)user {
    
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    
    if (self) {
        self.user = user;
    }
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.navigationItem.title = @"USER DETAILS";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kFirstCellId];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ASPhotoCell class]) bundle:nil]
         forCellReuseIdentifier:[ASPhotoCell reuseIdentifier]];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ASTwoButtonsCell class]) bundle:nil]
         forCellReuseIdentifier:[ASTwoButtonsCell reuseIdentifier]];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ASSingleButtonCell class]) bundle:nil]
         forCellReuseIdentifier:[ASSingleButtonCell reuseIdentifier]];
    
    self.tableView.allowsSelection = NO;
    
    [self getUserDetails];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    __weak typeof (self) weakSelf = self;
    
    switch (indexPath.row) {
        case 0:
        {
            UITableViewCell *firstCell = [tableView dequeueReusableCellWithIdentifier:kFirstCellId forIndexPath:indexPath];
            firstCell.textLabel.text = [NSString stringWithFormat:@"%@ %@", self.user.firstName, self.user.lastName];
            firstCell.textLabel.textAlignment = NSTextAlignmentCenter;
            UIFont *font = [UIFont fontWithName:@"Arial" size:26.f];
            firstCell.textLabel.textColor = [UIColor purpleColor];
            firstCell.textLabel.font = font;
            
            cell = firstCell;
        }
            break;
            
        case 1:
        {
            ASPhotoCell *photoCell = [tableView dequeueReusableCellWithIdentifier:[ASPhotoCell reuseIdentifier] forIndexPath:indexPath];
            
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:self.user.originalImageUrl];
            __weak ASPhotoCell *weakPhotoCell = photoCell;
            
            [photoCell.avatarView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                
                weakPhotoCell.avatarView.image = image;
                [weakPhotoCell layoutSubviews];
                
            } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                
                NSLog(@"%@", error.localizedDescription);
            }];
            
            photoCell.cityLabel.text = self.user.city.length ? self.user.city : @"N/A";
            photoCell.sexLabel.text = self.user.sex.length ? self.user.sex : @"N/A";
            photoCell.lastSeenLabel.text = self.user.lastSeenDate ? [self convertDateToString:self.user.lastSeenDate] : @"N/A";
            photoCell.identifierLabel.text = [NSString stringWithFormat:@"%@", self.user.identifier];
            
            cell = photoCell;
        }
            break;
            
        case 2:
        {
            ASTwoButtonsCell *buttonsCell = [tableView dequeueReusableCellWithIdentifier:[ASTwoButtonsCell reuseIdentifier]
                                                                            forIndexPath:indexPath];
            
            buttonsCell.followersBlock = ^{
                
                [weakSelf startFollowersFlow];
            };
            buttonsCell.subsctibersBlock = ^{
                
                [weakSelf startSubscribersFlow];
            };
            
            cell = buttonsCell;
        }
        break;
            
        case 3:
        {
            ASSingleButtonCell *oneButtonCell = [tableView dequeueReusableCellWithIdentifier:[ASSingleButtonCell reuseIdentifier]
                                                                                forIndexPath:indexPath];
            
            oneButtonCell.wallBlock = ^{
                
                [weakSelf showWall];
                
            };
            
            cell = oneButtonCell;
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        return [ASPhotoCell cellHeight];
    } else {
        return 50.f;
    }
}

#pragma mark - API

- (void)getUserDetails {
    
    [[ASServerManager sharedManager] getUserDetails:self.user.identifier
                                          onSuccess:^(NSArray *parsedObjects) {
        
                                              self.user = parsedObjects.firstObject;
                                              [self.tableView reloadData];
        
    }
                                          onFailure:^(NSError *error, NSInteger code) {
        
        
    }];
}

#pragma mark - Private Methods

- (NSString *)convertDateToString:(NSDate *)date {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss dd-MM-yyyy"];
    return [formatter stringFromDate:date];
}

- (void)startSubscribersFlow {
    
    ASSubscribersController *vc = [[ASSubscribersController alloc] initWithUser:self.user];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)startFollowersFlow {
    
    ASFollowersController *vc = [[ASFollowersController alloc] initWithUser:self.user];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showWall {
    
    ASWallController *vc = [[ASWallController alloc] initWithUser:self.user];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
