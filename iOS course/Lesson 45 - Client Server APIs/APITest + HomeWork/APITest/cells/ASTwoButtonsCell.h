//
//  ASTwoButtonsCell.h
//  APITest
//
//  Created by Alex on 5/10/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASTwoButtonsCell : UITableViewCell

@property (nonatomic, copy) void (^subsctibersBlock)(void);
@property (nonatomic, copy) void (^followersBlock)(void);

+ (NSString *)reuseIdentifier;

- (IBAction)subscriptionsAction:(UIButton *)sender;
- (IBAction)followersAction:(UIButton *)sender;

@end

