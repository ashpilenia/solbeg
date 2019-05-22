//
//  ASGroupWallController.m
//  APITest
//
//  Created by Alex on 5/22/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASGroupWallController.h"
#import "ASServerManager.h"
#import "ASUser.h"
#import "ASWallGroupCell.h"
#import "ASWallItem.h"

@interface ASGroupWallController ()

@property (nonatomic, strong) NSMutableArray *postsArray;

@end

@implementation ASGroupWallController

static NSInteger postsInRequest = 20;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.postsArray = [NSMutableArray array];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ASWallGroupCell class]) bundle:nil]
         forCellReuseIdentifier:[ASWallGroupCell reuseIdentifier]];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(refreshWall) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    
    UIBarButtonItem *addPostItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                 target:self
                                                                                 action:@selector(addPostAction:)];
    [self.navigationItem setRightBarButtonItem:addPostItem];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.postsArray count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *retCell = nil;
    if (indexPath.row == self.postsArray.count) {
        
        static NSString *identifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        cell.textLabel.text = @"LOAD MORE";
        cell.imageView.image = nil;
        
        retCell = cell;
        
    } else {
        
        ASWallItem *item = [self.postsArray objectAtIndex:indexPath.row];
        
        ASWallGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:[ASWallGroupCell reuseIdentifier]
                                                                forIndexPath:indexPath];
        
        cell.postTextLabel.text = item.text;
        
        retCell = cell;
    }
    
    
    return retCell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == self.postsArray.count) {
        
        return 44.f;
        
    } else {
        
        ASWallItem *item = [self.postsArray objectAtIndex:indexPath.row];
        return [ASWallGroupCell heightForText:item.text];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == self.postsArray.count) {
        
        [self getPostsFromServer];
        
    }
    
    
}

#pragma mark - API

- (void)getPostsFromServer {
    
    NSNumber *iOSGroupId = @(58860049);
    
    [[ASServerManager sharedManager] loadGroupWall:iOSGroupId
                                        withOffset:@([self.postsArray count])
                                             count:@(postsInRequest)
                                         onSuccess:^(NSArray *parsedObjects) {
                                             
                                             [self.postsArray addObjectsFromArray:parsedObjects];
                                             
                                             NSMutableArray *newPaths = [NSMutableArray array];
                                             for (int i = (int)self.postsArray.count - (int)parsedObjects.count; i < self.postsArray.count; i++) {
                                                 [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                                             }
                                             
                                             [self.tableView beginUpdates];
                                             [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationFade];
                                             [self.tableView endUpdates];
                                         }
                                         onFailure:^(NSError *error, NSInteger code) {
                                             
                                             NSLog(@"Error = %@, code = %ld", error.localizedDescription, error.code);
                                         }];
}

- (void)refreshWall {
    
    NSNumber *iOSGroupId = @(58860049);
    
    NSInteger refreshCount = MAX(postsInRequest, self.postsArray.count);
    
    [[ASServerManager sharedManager] loadGroupWall:iOSGroupId
                                        withOffset:@(0)
                                             count:@(refreshCount)
                                         onSuccess:^(NSArray *parsedObjects) {
                                             
                                             [self.postsArray removeAllObjects];
                                             [self.postsArray addObjectsFromArray:parsedObjects];
                                             
                                             [self.tableView reloadData];
                                             
                                             [self.refreshControl endRefreshing];
                                         }
                                         onFailure:^(NSError *error, NSInteger code) {
                                             
                                             NSLog(@"Error = %@, code = %ld", error.localizedDescription, error.code);
                                         }];
}

- (void)addPostAction:(UIBarButtonItem *)sender {
    
    NSNumber *iOSGroupId = @(58860049);
    
    [[ASServerManager sharedManager] postText:@"API Test"
                                  onGroupWall:iOSGroupId onSuccess:^(NSArray *parsedObjects) {
                                      
                                      [self refreshWall];
                                      
                                  } onFailure:^(NSError *error, NSInteger code) {
                                      
                                      NSLog(@"Error = %@, code = %ld", error.localizedDescription, error.code);
                                  }];
}


@end
