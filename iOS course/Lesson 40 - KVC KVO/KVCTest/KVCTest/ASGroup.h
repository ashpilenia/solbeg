//
//  ASGroup.h
//  KVCTest
//
//  Created by Alex on 2/20/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASStudent.h"



@interface ASGroup : NSObject

@property (nonatomic, strong) NSArray<ASStudent *> *students;

@end


