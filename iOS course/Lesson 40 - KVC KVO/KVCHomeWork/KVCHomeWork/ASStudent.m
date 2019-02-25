//
//  ASStudent.m
//  KVCHomeWork
//
//  Created by Alex on 2/21/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASStudent.h"

@interface ASStudent ()

@property (nonatomic, assign) BOOL isInitiatedWithParams;

@end

@implementation ASStudent

- (instancetype)initWithInitialParams {
    
    self = [super init];
    if (self) {
        
        [self setInitialParams];
        
        self.isInitiatedWithParams = YES;
        
        [self addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [self addObserver:self forKeyPath:@"lastName" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [self addObserver:self forKeyPath:@"gender" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [self addObserver:self forKeyPath:@"grade" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [self addObserver:self forKeyPath:@"birthDate" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    
    return self;
}

- (void)dealloc {
    
    if (self.isInitiatedWithParams) {
        
        [self removeObserver:self forKeyPath:@"name"];
        [self removeObserver:self forKeyPath:@"lastName"];
        [self removeObserver:self forKeyPath:@"gender"];
        [self removeObserver:self forKeyPath:@"grade"];
        [self removeObserver:self forKeyPath:@"birthDate"];
    }
    
    
}

#pragma mark - Pivate Methods

- (NSString *)gradeString {
    
    NSString *retString;
    switch (self.grade) {
        case 0:
        {
            retString = @"High School";
        }
            break;
            
        case 1:
        {
            retString = @"Univercity";
        }
            break;
            
        case 2:
        {
            retString = @"Magistr";
        }
            break;
            
        case 3:
        {
            retString = @"Professor";
        }
            break;
    }
    
    return retString;
}

- (void)setInitialParams {
    
    _birthDate = [NSDate dateWithTimeIntervalSinceNow:-630720000.f];
    _gender = transgender;
    _grade = univercity;
    _name = @"Carol";
    _lastName = @"Grim";
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"Name = %@, BorthDate = %@, Score = %ld", self.name, self.birthDate, (long)self.score];
}

#pragma mark - KVC/KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSLog(@"\nobserveValueForKeyPath: %@\nofObject: %@\nchange: %@", keyPath, object, change);
}

- (void)clearSettings {
    
    [self willChangeValueForKey:@"name"];
    [self willChangeValueForKey:@"lastName"];
    [self willChangeValueForKey:@"gender"];
    [self willChangeValueForKey:@"grade"];
    [self willChangeValueForKey:@"birthDate"];
    
    [self setInitialParams];
    
    [self didChangeValueForKey:@"name"];
    [self didChangeValueForKey:@"lastName"];
    [self didChangeValueForKey:@"gender"];
    [self didChangeValueForKey:@"grade"];
    [self didChangeValueForKey:@"birthDate"];
    
}


@end
