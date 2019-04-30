//
//  ASUserDetailCell.h
//  CoreData HomeWork
//
//  Created by Alex on 4/30/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASUserDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;

+ (NSString *)reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
