//
//  ASWallGroupCell.h
//  APITest
//
//  Created by Alex on 5/22/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASWallGroupCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *postTextLabel;

+ (NSString *)reuseIdentifier;
+ (CGFloat)heightForText:(NSString *)text;

@end

