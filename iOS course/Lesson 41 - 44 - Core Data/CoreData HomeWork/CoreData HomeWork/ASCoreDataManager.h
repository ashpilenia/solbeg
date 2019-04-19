//
//  ASCoreDataManager.h
//  CoreData HomeWork
//
//  Created by Alex on 4/19/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSPersistentContainer;

@interface ASCoreDataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

+ (ASCoreDataManager *)sharedManager;

- (void)saveContext;

@end

