//
//  ASStudent.h
//  Maps HomeWork
//
//  Created by Alex on 1/26/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef NS_ENUM(NSInteger) {
    female,
    male
} genderOptions;

@interface ASStudent : NSObject <MKAnnotation>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSDate *birthDate;
@property (nonatomic, assign) genderOptions gender;

- (void)generateTitleAndSubTitle;
+ (NSString *)reuseIdentifier;

@end


