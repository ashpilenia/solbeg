//
//  ASWallGroupCell.m
//  APITest
//
//  Created by Alex on 5/22/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASWallGroupCell.h"

@implementation ASWallGroupCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)reuseIdentifier {
    return @"groupCellReuseId";
}

+ (CGFloat)heightForText:(NSString *)text {
    
    CGFloat offset = 5.f;
    
    UIFont *font = [UIFont systemFontOfSize:17.f];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(0, -1);
    shadow.shadowBlurRadius = 0.5f;
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    [paragraph setLineBreakMode:NSLineBreakByWordWrapping];
    [paragraph setAlignment:NSTextAlignmentCenter];
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName            : font,
                                 NSParagraphStyleAttributeName  : paragraph,
                                 NSShadowAttributeName          : shadow
                                 };
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(320.f - 2 * offset, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:attributes
                                     context:nil];
    
    return rect.size.height + 2 * offset;
}

@end
