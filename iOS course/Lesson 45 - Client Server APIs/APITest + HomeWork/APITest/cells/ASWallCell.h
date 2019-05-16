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

+ (NSString *)reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
