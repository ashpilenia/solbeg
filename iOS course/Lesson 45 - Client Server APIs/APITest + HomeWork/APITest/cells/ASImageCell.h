//
//  ASImageCell.h
//  APITest
//
//  Created by Alex on 5/17/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASImageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mainImageVuew;

+ (NSString *)reuseIdentifier;
+ (CGFloat)cellHeight;

@end
