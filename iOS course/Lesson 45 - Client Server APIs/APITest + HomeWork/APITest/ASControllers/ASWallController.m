//
//  ASWallController.m
//  APITest
//
//  Created by Alex on 5/15/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ASWallController.h"
#import "ASServerManager.h"
#import "ASUser.h"

@interface ASWallController ()

@end

@implementation ASWallController

- (instancetype)initWithUser:(ASUser *)user {
    
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    
    if (self) {
        self.user = user;
    }
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self loadWall];
    
}

#pragma mark - API

- (void)loadWall {
    
    [[ASServerManager sharedManager] loadWall:self.user.identifier
                                    onSuccess:^(NSArray *parsedObjects) {
        
    }
                                    onFailure:^(NSError *error, NSInteger code) {
        
                                    }];
    
}

@end
