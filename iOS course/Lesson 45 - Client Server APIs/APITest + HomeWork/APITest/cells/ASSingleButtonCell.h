//
//  ASSingleButtonCell.h
//  APITest
//
//  Created by Alex on 5/10/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASSingleButtonCell : UITableViewCell

@property (nonatomic, copy) void (^wallBlock)(void);

+ (NSString *)reuseIdentifier;
- (IBAction)wallAction:(UIButton *)sender;

@end

