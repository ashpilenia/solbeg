//
//  ASSubscribersController.m
//  APITest
//
//  Created by Alex on 5/15/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASSubscribersController.h"
#import "ASServerManager.h"
#import "ASUser.h"
#import "ASSubscription.h"
#import "UIImageView+AFNetworking.h"


static NSString * const kSubCellReuseId = @"SubCellReuseId";

@interface ASSubscribersController () <UITableViewDataSource>

@property (nonatomic, strong) NSArray<ASSubscription *> *subsArray;

@end

@implementation ASSubscribersController

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
    self.navigationItem.title = @"SUBSCRIPTIONS";
    
    [self getSubscriptions];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.subsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSubCellReuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSubCellReuseId];
    }
    
    ASSubscription *sub = [self.subsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = sub.name;
    
    __weak typeof (UITableViewCell *) weakCell = cell;
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:sub.imageUrl];
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

- (void)getSubscriptions {
    
    __weak typeof (self) weakSelf = self;
    
    [[ASServerManager sharedManager] getSubscriptionsForId:self.user.identifier
                                                 onSuccess:^(NSArray *parsedObjects) {
                                                     
                                                     weakSelf.subsArray = parsedObjects;
                                                     [weakSelf.tableView reloadData];
                                                     
                                                 }
                                                 onFailure:^(NSError *error, NSInteger code) {
                                                    
                                                     NSLog(@"%@ \nError code: %ld", error.localizedDescription, code);
                                                     
                                                 }];
}


@end
