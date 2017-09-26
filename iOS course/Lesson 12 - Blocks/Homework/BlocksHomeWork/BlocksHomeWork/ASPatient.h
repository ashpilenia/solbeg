//
//  ASPatient.h
//  BlocksHomeWork
//
//  Created by Alex on 9/26/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


extern NSNotificationName const ASPatientGettingWorseNotifiaction;

typedef  NS_ENUM(NSInteger, ASOrgan){
    stomach = 0,
    head = 1,
    back = 2,
    ass = 3
};

@interface ASPatient : NSObject

typedef void (^OurTestBlock)(ASPatient *);

@property (nonatomic, assign) CGFloat temperature;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, assign) BOOL analysisAreOk;
@property (nonatomic, assign) ASOrgan organ;
@property (nonatomic, assign) BOOL feelsBad;


- (BOOL) gettingWorse;
- (void) firstHelpUpd:(NSInteger) number;
- (void) urgentHelpUpd:(NSInteger) number;
- (NSString*) formatOrganToString:(ASOrgan) organ;

- (void) blockHealing:(OurTestBlock) var;

@end
