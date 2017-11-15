//
//  ASStudent.h
//  TableView Editing part 1
//
//  Created by Alex on 11/8/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ASStudent : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, assign) CGFloat averageGrade;

+ (ASStudent *) randomStudent;

@end
