//
//  ASFileCell.h
//  FileManagerTest
//
//  Created by Alex on 11/20/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASFileCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *sizeLabel;

@property (nonatomic, weak) IBOutlet UILabel *dateLabel;



@end
