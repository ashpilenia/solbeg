//
//  ASSwimmers.h
//  ASProtocolsHomeWork
//
//  Created by Alex on 9/11/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ASSwimmers <NSObject>

@required

@property (nonatomic, strong) NSString* p_name;
@property (nonatomic, assign) NSInteger age;

- (void) swimming;
- (NSInteger) distance;

#pragma mark - optional
@optional

typedef enum {
    Backstroke,
    Butterfly,
    Flutter,
    Sidestroke
} ASSwimStyles;

@property (nonatomic, assign) ASSwimStyles style;

- (CGFloat) technique;

@end
