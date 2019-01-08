//
//  ASMapAnnotation.h
//  MapTest
//
//  Created by Alex on 1/8/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface ASMapAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *subtitle;

@end

NS_ASSUME_NONNULL_END
