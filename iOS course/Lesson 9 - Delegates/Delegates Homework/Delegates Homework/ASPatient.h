//
//  ASPatient.h
//  Delegates Homework
//
//  Created by Alex on 9/15/17.
//  Copyright © 2017 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    stomach = 0,
    head = 1,
    back = 2,
    ass = 3
} ASOrgan;

@protocol ASPatientDelegate;

@interface ASPatient : NSObject

@property (nonatomic, assign) CGFloat temperature;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, assign) BOOL analysisAreOk;
@property (nonatomic, weak) id <ASPatientDelegate> delegate;
@property (nonatomic, assign) ASOrgan organ;
@property (nonatomic, assign) BOOL mark;
@property (nonatomic, strong) NSString* d_name;



- (BOOL) gettingWorse;
- (void) firstHelp;
- (void) urgentHelp;
- (void) firstHelpUpd:(NSInteger) number;
- (void) urgentHelpUpd:(NSInteger) number;
- (NSString*) formatOrganToString:(ASOrgan) organ;



@end

@protocol ASPatientDelegate <NSObject>

- (void) takePill:(ASPatient*) pill;
- (void) makeShot:(ASPatient*) shot;

@end
