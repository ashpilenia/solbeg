//
//  ASJumpers.h
//  ASProtocolsHomeWork
//
//  Created by Alex on 9/11/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ASJumpers <NSObject>

@required

@property (nonatomic, assign) NSInteger p_height;
@property (nonatomic, strong) NSString* p_name;

- (void) jumping;
- (NSInteger) numberOfTries;


#pragma mark - optional
@optional

@property (nonatomic, assign) BOOL balance;

- (NSString*) landing;


@end
