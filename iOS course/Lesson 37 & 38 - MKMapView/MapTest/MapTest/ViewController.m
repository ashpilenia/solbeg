//
//  ViewController.m
//  MapTest
//
//  Created by Alex on 1/8/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "ASMapAnnotation.h"

#import "UIView+MKAnnotationView.h"

static NSString *identifier = @"Annotation";

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
        self.mapView.showsUserLocation = true;
    } else {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(actionAdd:)];
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                               target:self
                                                                               action:@selector(actionShowAll:)];
    
    self.navigationItem.rightBarButtonItems = @[searchButton, barButton];
    
    [self.mapView registerClass:[MKPinAnnotationView class] forAnnotationViewWithReuseIdentifier:identifier];
  
}

#pragma mark - Private Methods

- (void)showAlertWithTitile:(NSString *)title andMessage:(NSString *)message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Actions

- (void)actionShowAll:(UIBarButtonItem *)barButton {
    
    MKMapRect zoomRect = MKMapRectNull;
    
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        
        CLLocationCoordinate2D location = annotation.coordinate;
        MKMapPoint center = MKMapPointForCoordinate(location);
        
        static double delta = 50000.f;
        
        MKMapRect rect = MKMapRectMake(center.x - delta, center.y - delta, delta * 2, delta * 2);
        
        zoomRect = MKMapRectUnion(zoomRect, rect);
    }
    
    zoomRect = [self.mapView mapRectThatFits:zoomRect];
    
    [self.mapView setVisibleMapRect:zoomRect edgePadding:UIEdgeInsetsMake(50.f, 50.f, 50.f, 50.f) animated:YES];
    
}

- (void)actionAdd:(UIBarButtonItem *)barButton {
    
    ASMapAnnotation *annotation = [[ASMapAnnotation alloc] init];
    annotation.title = @"Test Title";
    annotation.subtitle = @"Test Subtitle";
    annotation.coordinate = self.mapView.region.center;
    
    [self.mapView addAnnotation:annotation];
    
}

- (void)actionRouts:(UIButton *)button {
    
    MKAnnotationView *annotationView = [button superAnnotationView];
    
    if (!annotationView) {
        return;
    }
    
    CLLocationCoordinate2D coordinate = annotationView.annotation.coordinate;
    
    MKDirectionsRequest *directionRequest = [[MKDirectionsRequest alloc] init];
    directionRequest.source = [MKMapItem mapItemForCurrentLocation];
    
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate];
    MKMapItem *destination = [[MKMapItem alloc] initWithPlacemark:placemark];
    directionRequest.destination = destination;
    
    directionRequest.transportType = MKDirectionsTransportTypeAutomobile;
    
    directionRequest.requestsAlternateRoutes = YES;
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:directionRequest];
    
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            
            [self showAlertWithTitile:@"Error" andMessage:[error localizedDescription]];
            
        } else if (!response.routes.count) {
            
            [self showAlertWithTitile:@"Error" andMessage:@"No routes found"];
            
        } else {
            
            [self.mapView removeOverlays:[self.mapView overlays]];
            
            NSArray *polylinesArray = [response.routes valueForKeyPath:@"polyline"];
            
            [self.mapView addOverlays:polylinesArray level:MKOverlayLevelAboveRoads];
        }
    }];
}

- (void)actionDescription:(UIButton *)button {
    
    MKAnnotationView *annotationView = [button superAnnotationView];
    
    if (!annotationView) {
        return;
    }
    
    CLLocationCoordinate2D coordinate = annotationView.annotation.coordinate;
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        NSString *message = nil;
        
        if (error) {
            
            message = [error localizedDescription];
            
        } else {
            
            if ([placemarks count] > 0) {
                
                CLPlacemark *placeMark = [placemarks firstObject];
                
                NSString *name                         = placeMark.name.length ? placeMark.name : @"N/A";
                NSString *thoroughfare                 = placeMark.thoroughfare.length ? placeMark.thoroughfare : @"N/A";
                NSString *subThoroughfare              = placeMark.subThoroughfare.length ? placeMark.subThoroughfare : @"N/A";
                NSString *locality                     = placeMark.locality.length ? placeMark.locality : @"N/A";
                NSString *subLocality                  = placeMark.subLocality.length ? placeMark.subLocality : @"N/A";
                NSString *administrativeArea           = placeMark.administrativeArea.length ? placeMark.administrativeArea : @"N/A";
                NSString *subAdministrativeArea        = placeMark.subAdministrativeArea.length ? placeMark.subAdministrativeArea : @"N/A";
                NSString *postalCode                   = placeMark.postalCode.length ? placeMark.postalCode : @"N/A";
                NSString *ISOcountryCode               = placeMark.ISOcountryCode.length ? placeMark.ISOcountryCode : @"N/A";
                NSString *country                      = placeMark.country.length ? placeMark.country : @"N/A";
                NSString *inlandWater                  = placeMark.inlandWater.length ? placeMark.inlandWater : @"N/A";
                NSString *ocean                        = placeMark.ocean.length ? placeMark.ocean : @"N/A";
                
                NSDictionary *palceMarkDict = @{
                                                @"name"                  : name,
                                                @"thoroughfare"          : thoroughfare,
                                                @"subThoroughfare"       : subThoroughfare,
                                                @"locality"              : locality,
                                                @"subLocality"           : subLocality,
                                                @"administrativeArea"    : administrativeArea,
                                                @"subAdministrativeArea" : subAdministrativeArea,
                                                @"postalCode"            : postalCode,
                                                @"ISOcountryCode"        : ISOcountryCode,
                                                @"country"               : country,
                                                @"inlandWater"           : inlandWater,
                                                @"ocean"                 : ocean
                                                };
                
                message = [palceMarkDict description];
            } else {
                
                message = @"No Placemarks Found";
            }
        }
        
        [self showAlertWithTitile:@"Location" andMessage:message];
    }];
    
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    
    NSLog(@"regionWillChangeAnimated");
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    NSLog(@"regionDidChangeAnimated");
}

- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView {
    
    NSLog(@"mapViewWillStartLoadingMap");
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    
    NSLog(@"mapViewDidFinishLoadingMap");
}

- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error {
    
    NSLog(@"mapViewDidFailLoadingMap");
}

- (void)mapViewWillStartRenderingMap:(MKMapView *)mapView {
    
    NSLog(@"mapViewWillStartRenderingMap");
}

- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered {
    
    NSLog(@"mapViewDidFinishRenderingMap");
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier forAnnotation:annotation];
    pin.pinTintColor = [UIColor purpleColor];
    pin.animatesDrop = YES;
    pin.canShowCallout = YES;
    pin.draggable = YES;
    
    UIButton *descriptionButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [descriptionButton addTarget:self action:@selector(actionDescription:) forControlEvents:UIControlEventTouchUpInside];
    
    pin.rightCalloutAccessoryView = descriptionButton;
    
    UIButton *roadButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [roadButton addTarget:self action:@selector(actionRouts:) forControlEvents:UIControlEventTouchUpInside];
    
    pin.leftCalloutAccessoryView = roadButton;
    
    return pin;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view
                                 didChangeDragState:(MKAnnotationViewDragState)newState
                                       fromOldState:(MKAnnotationViewDragState)oldState {
    
    if (newState == MKAnnotationViewDragStateEnding) {
        
        CLLocationCoordinate2D location = view.annotation.coordinate;
        MKMapPoint point = MKMapPointForCoordinate(location);
        
        NSLog(@"\nLocation = {%f, %f}\nPoint = %@", location.latitude, location.longitude, MKStringFromMapPoint(point));
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
    
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        renderer.lineWidth = 2.f;
        renderer.strokeColor = [UIColor colorWithRed:0 green:0.5f blue:1.f alpha:0.9f];
        
        return renderer;
    }
    return nil;
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
}





@end
