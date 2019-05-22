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

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == self.postsArray.count) {
        
        [self getPostsFromServer];
        
    }
    
    
}


@end
