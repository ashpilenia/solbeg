//
//  ASFollowersController.m
//  APITest
//
//  Created by Alex on 5/15/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASFollowersController.h"
#import "ASUser.h"
#import "ASFollower.h"
#import "UIImageView+AFNetworking.h"
#import "ASServerManager.h"

static NSString * const kFollowersCellReuseId = @"FollowersCellReuseId";

@interface ASFollowersController () <UITableViewDataSource>

@property (nonatomic, strong) NSArray<ASFollower *> *followersArray;

@end

@implementation ASFollowersController

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
    self.tableView.allowsSelection = NO;
    self.navigationItem.title = @"FOLLOWERS";
    
    [self getFollowers];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.followersArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFollowersCellReuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kFollowersCellReuseId];
    }
    
    ASFollower *follower = [self.followersArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", follower.firstName, follower.lastName];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:follower.imageUrl];
    
    __weak UITableViewCell *weakCell = cell;
    
    [cell.imageView setImageWithURLRequest:request
                          placeholderImage:nil
                                   success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                       
                                       weakCell.imageView.image = image;
                                       [weakCell layoutSubviews];
    }
                                   failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                       
                                       NSLog(@"%@", error.localizedDescription);
    }];
    
    return cell;
}

#pragma mark - API

- (void)getFollowers {
    
    __weak typeof (self) weakSelf = self;
    
    [[ASServerManager sharedManager] getFollowersForId:self.user.identifier
                                             onSuccess:^(NSArray *parsedObjects) {
        
                                                 weakSelf.followersArray = parsedObjects;
                                                 [weakSelf.tableView reloadData];
    }
                                             onFailure:^(NSError *error, NSInteger code) {
                                                 
                                                 NSLog(@"%@ \nError code: %ld", error.localizedDescription, code);
    }];
}


@end
