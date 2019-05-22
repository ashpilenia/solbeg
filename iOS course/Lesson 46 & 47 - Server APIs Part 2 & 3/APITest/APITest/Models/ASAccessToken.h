//
//  ASAccessToken.h
//  APITest
//
//  Created by Alex on 5/22/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASAccessToken : NSObject

@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSDate *expirationDate;
@property (strong, nonatomic) NSNumber *userID;

@end
