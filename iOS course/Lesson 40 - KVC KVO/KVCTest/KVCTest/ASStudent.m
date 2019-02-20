//
//  ASStudent.m
//  KVCTest
//
//  Created by Alex on 2/18/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASStudent.h"

@implementation ASStudent

- (void)setName:(NSString *)name {
    
    _name = name;
    
    NSLog(@"student setName: %@", name);
}

- (void)setAge:(NSInteger)age {
    
    _age = age;
    
    NSLog(@"student setAge: %ld", (long)age);
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"Student: %@ %ld", self.name, (long)self.age];
}

#pragma mark - KVC/KVO

- (void)setValue:(id)value forKey:(NSString *)key {
    
    NSLog(@"setValue %@ for Key %@", value, key);
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    NSLog(@"setValue %@ forUndefinedKey %@", value, key);
}

- (id)valueForUndefinedKey:(NSString *)key {
    
    NSLog(@"valueForUndefinedKey %@", key);
    
    return nil;
}

- (void)changeName {
    
    self.name = @"fake name";
    
    _name = @"ghost name";
    
    [self willChangeValueForKey:@"name"];
    _name = @"visible ghost";
    [self didChangeValueForKey:@"name"];
}

- (BOOL)validateValue:(inout id  _Nullable __autoreleasing *)ioValue forKey:(NSString *)inKey error:(out NSError * _Nullable __autoreleasing *)outError {

    if ([inKey isEqualToString:@"name"]) {

        NSString *newName = *ioValue;
        if (![newName isKindOfClass:[NSString class]]) {

            *outError = [[NSError alloc] initWithDomain:@"invalid parameter class" code:666 userInfo:nil];
            return NO;
        }

        if ([newName rangeOfString:@"1"].location != NSNotFound) {

            *outError = [[NSError alloc] initWithDomain:@"string includes numbers" code:777 userInfo:nil];
            return NO;
        }

    }

    return YES;
}

//- (BOOL)validateName:(inout id *)ioValue error:(out NSError **)outError {
//
//    NSLog(@"AAA!");
//    return YES;
//}

@end
