//
//  ASMeeting.h
//  Maps HomeWork
//
//  Created by Alex on 1/27/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ASMeeting : NSObject <MKAnnotation>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end

