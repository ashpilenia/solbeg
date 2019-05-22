//
//  ASWallCell.m
//  APITest
//
//  Created by Alex on 5/16/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASWallCell.h"
#import "ASImageCell.h"
#import "UIImageView+AFNetworking.h"

@interface ASWallCell () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ASWallCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.cellTableVIew.delegate = self;
    self.cellTableVIew.dataSource = self;
    self.likesImageView.image = [UIImage imageNamed:@"like.png"];
    self.commentsImageView.image = [UIImage imageNamed:@"reply.png"];
    self.viewsImageView.image = [UIImage imageNamed:@"eye.png"];
    
    self.headerAvatarView.layer.cornerRadius = 18.f;
    self.repostAvatarView.layer.cornerRadius = 18.f;
    
    [self.cellTableVIew registerNib:[UINib nibWithNibName:NSStringFromClass([ASImageCell class])
                             bundle:nil]
             forCellReuseIdentifier:[ASImageCell reuseIdentifier]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imagesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ASImageCell *cell = [tableView dequeueReusableCellWithIdentifier:[ASImageCell reuseIdentifier] forIndexPath:indexPath];
    
    NSURL *imageURL = [self.imagesArray objectAtIndex:indexPath.row];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:imageURL];
    
    __weak ASImageCell *weakCell = cell;
    [cell.mainImageVuew setImageWithURLRequest:request
                              placeholderImage:nil
                                       success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                           
                                           weakCell.mainImageVuew.image = image;
                                           [weakCell layoutSubviews];
    }
                                       failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                           
                                           NSLog(@"%@", error.localizedDescription);
    }];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [ASImageCell cellHeight];
}



+ (NSString *)reuseIdentifier {
    return @"wallReuseId";
}

- (void)setImagesArray:(NSArray *)imagesArray {
    
    _imagesArray = imagesArray;
    [self.cellTableVIew reloadData];
}




@end
