//
//  ASToken.h
//  last_homework
//
//  Created by Alex on 5/23/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASToken : NSObject

@property (nonatomic, strong) NSDate *expirationDate;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *token;


@end

