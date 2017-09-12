//
//  ASRunners.h
//  ASProtocolsHomeWork
//
//  Created by Alex on 9/11/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ASRunners <NSObject>

@required

@property (nonatomic, strong) NSString* p_name;
@property (nonatomic, assign) CGFloat speed;

- (NSString*) run;
- (BOOL) record;

#pragma mark - optional
@optional

@property (nonatomic, assign) NSInteger distance;

- (NSInteger) averageSpeed;

@end
