//
//  ASWallCell.h
//  APITest
//
//  Created by Alex on 5/16/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASWallCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mainTextLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UITableView *cellTableVIew;
@property (weak, nonatomic) IBOutlet UIImageView *likesImageView;
@property (weak, nonatomic) IBOutlet UIImageView *commentsImageView;
@property (weak, nonatomic) IBOutlet UIImageView *viewsImageView;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UILabel *repostsLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewsLabel;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *headerAvatarView;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UIView *repostView;
@property (weak, nonatomic) IBOutlet UIImageView *repostAvatarView;
@property (weak, nonatomic) IBOutlet UILabel *repostLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *repostHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainTextTopConstraint;

@property (nonatomic, strong) NSArray *imagesArray;

+ (NSString *)reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
