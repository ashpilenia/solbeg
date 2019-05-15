//
//  ViewController.m
//  APITest
//
//  Created by Alex on 4/18/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"
#import "ASServerManager.h"
#import "ASUser.h"
#import "UIImageView+AFNetworking.h"
#import "ASUserDetailsController.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray<ASUser *> *friendsArray;

@end

@implementation ViewController

static NSInteger friendsInRequest = 5;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.friendsArray = [NSMutableArray array];
    
    [self getFriendsFromServer];
}

#pragma mark - API

- (void)getFriendsFromServer {
    
    [[ASServerManager sharedManager] getFriendsWithOffset:self.friendsArray.count count:friendsInRequest onSuccess:^(NSArray *friends) {
        
        [self.friendsArray addObjectsFromArray:friends];
        
        NSMutableArray *newPaths = [NSMutableArray array];
        for (int i = (int)self.friendsArray.count - (int)friends.count; i < self.friendsArray.count; i++) {
            [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }

        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        
        
    } onFailure:^(NSError *error, NSInteger code) {
        NSLog(@"Error = %@, code = %ld", error.localizedDescription, error.code);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friendsArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.row == self.friendsArray.count) {
        
        cell.textLabel.text = @"LOAD MORE";
        cell.imageView.image = nil;
        
    } else {
        
        if (self.friendsArray.count) {
            ASUser *friend = [self.friendsArray objectAtIndex:indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", friend.firstName, friend.lastName];
            
            __weak UITableViewCell *weakCell = cell;
            
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:friend.imageUrl];
            [cell.imageView setImageWithURLRequest:urlRequest
                                  placeholderImage:nil
                                           success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                               
                                               weakCell.imageView.image = image;
                                               [weakCell layoutSubviews];
            }
                                           failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                               
                                               NSLog(@"%@", error.localizedDescription);
            }];
            
        }
    }
    
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == self.friendsArray.count) {
        
        [self getFriendsFromServer];
        
    } else {
        
        ASUser *user = [self.friendsArray objectAtIndex:indexPath.row];
        ASUserDetailsController *vc = [[ASUserDetailsController alloc] initWithUser:user];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}



@end
