//
//  FileCell.h
//  Navigation_Homework
//
//  Created by Alex on 12/4/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *fileName;
@property (nonatomic, weak) IBOutlet UILabel *fileSize;
@property (nonatomic, weak) IBOutlet UILabel *modifiedDate;

@end
