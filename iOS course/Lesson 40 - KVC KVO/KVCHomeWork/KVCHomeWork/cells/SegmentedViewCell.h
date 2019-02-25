//
//  SegmentedViewCell.h
//  KVCHomeWork
//
//  Created by Alex on 2/23/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASStudent.h"

@interface SegmentedViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedView;

@property (nonatomic, strong) ASStudent *student;

- (IBAction)segmentedViewChanged:(UISegmentedControl *)sender;

+ (NSString *)reuseIdentifier;

@end

