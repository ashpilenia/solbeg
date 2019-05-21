//
//  ASWallController.m
//  APITest
//
//  Created by Alex on 5/15/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASWallController.h"
#import "ASServerManager.h"
#import "ASUser.h"
#import "ASWallCell.h"
#import "ASWallItem.h"
#import "ASGroup.h"

@interface ASWallController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIImage *avatar;

@end

@implementation ASWallController

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
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ASWallCell class]) bundle:nil]
         forCellReuseIdentifier:[ASWallCell reuseIdentifier]];
    
    NSData *data = [NSData dataWithContentsOfURL:self.user.originalImageUrl];
    self.avatar = [[UIImage alloc] initWithData:data];
    
    [self loadWall];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ASWallCell *cell = [tableView dequeueReusableCellWithIdentifier:[ASWallCell reuseIdentifier] forIndexPath:indexPath];
    
    ASWallItem *item = [self.itemsArray objectAtIndex:indexPath.row];
    
    cell.likesLabel.text = [NSString stringWithFormat:@"%@", item.likes];
    cell.repostsLabel.text = [NSString stringWithFormat:@"%@", item.reposts];
    cell.viewsLabel.text = [NSString stringWithFormat:@"%@", item.views];
    cell.likesLabel.text = [NSString stringWithFormat:@"%@", item.likes];
    cell.imagesArray = item.attachmentsArray;
    cell.mainTextLabel.text = item.text;
    
    cell.headerAvatarView.image = self.avatar;
    cell.headerLabel.text = [NSString stringWithFormat:@"%@ %@", self.user.firstName, self.user.lastName];
    //mocking
    
    if (item.isUsingGroup) {
        
        cell.repostLabel.text = item.repostGroup.name;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:item.repostGroup.photoUrl];
            dispatch_sync(dispatch_get_main_queue(), ^{
                cell.repostAvatarView.image = [UIImage imageWithData:data];
            });
        });

        cell.repostView.hidden = NO;
        cell.mainTextTopConstraint.constant = 42.f;
    } else {
        cell.repostView.hidden = YES;
        cell.mainTextTopConstraint.constant = 2.f;
    }
    
    cell.textHeightConstraint.constant = [self mesureTextHeightForText:cell.mainTextLabel.text];
    
    cell.tableViewHeightConstraint.constant = 305 * item.attachmentsArray.count;
    
    if (!cell.mainTextLabel.text.length && !cell.imagesArray.count) {
        NSString *apologies = @"The post data has been missing. Apologies from the API team.";
        cell.mainTextLabel.text = apologies;
        item.text = apologies;
        
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ASWallItem *item = [self.itemsArray objectAtIndex:indexPath.row];
    CGFloat textHeight = [self mesureTextHeightForText:item.text];
    CGFloat tableViewHeight = item.attachmentsArray.count * 305.f;
    CGFloat repostHeight = item.isUsingGroup ? 40.f : 0;
    
    return textHeight + tableViewHeight + repostHeight + 120.f;
}

#pragma mark - Private Methods

- (CGFloat)mesureTextHeightForText:(NSString *)text {
    
    if (!text.length) {
        return 0;
    }
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:15]};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 10, CGFLOAT_MAX)
                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                     attributes:attributes
                                                        context:nil];
    
    return rect.size.height;
    
}

#pragma mark - API

- (void)loadWall {
    
    [[ASServerManager sharedManager] loadWall:self.user.identifier
                                    onSuccess:^(NSArray *parsedObjects) {
                                        
                                        self.itemsArray = parsedObjects;
                                        [self.tableView reloadData];
    }
                                    onFailure:^(NSError *error, NSInteger code) {
                                        
                                        NSLog(@"%@ with Code: %ld", error.localizedDescription, code);
                                    }];
    
}

@end
