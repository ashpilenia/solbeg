//
//  SegmentedViewCell.m
//  KVCHomeWork
//
//  Created by Alex on 2/23/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "SegmentedViewCell.h"

@implementation SegmentedViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.textLabel.text = @"Gender:";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)segmentedViewChanged:(UISegmentedControl *)sender {
    
    self.student.gender = sender.selectedSegmentIndex;
}

+ (NSString *)reuseIdentifier {
    
    return @"segmentedCellReuseId";
}
@end
