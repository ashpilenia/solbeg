//
//  ASStudent.m
//  Maps HomeWork
//
//  Created by Alex on 1/26/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASStudent.h"

@implementation ASStudent

- (void)generateTitleAndSubTitle {
    
    if (self.name.length && self.lastName.length) {
        
        self.title = [NSString stringWithFormat:@"%@ %@", self.name , self.lastName];
    }
    
    if (self.birthDate) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"MMM/dd/yyyy";
        self.subtitle = [formatter stringFromDate:self.birthDate];
    }

}

+ (NSString *)reuseIdentifier {
    
    return @"kAnnotationReuseIdentifier";
}

@end
