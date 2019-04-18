//
//  ASDataManager.h
//  CoreDataTest
//
//  Created by Alex on 4/16/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ASDataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

+ (ASDataManager *)sharedManager;

- (void)saveContext;

- (void)generateAndAddUniversity;

@end

