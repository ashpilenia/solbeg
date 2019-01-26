//
//  ViewController.m
//  Maps HomeWork
//
//  Created by Alex on 1/23/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "ASStudent.h"

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSArray<ASStudent *> *studentsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    self.mapView.delegate = self;
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
        self.mapView.showsUserLocation = YES;
    } else {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    UIBarButtonItem *testButton = [[UIBarButtonItem alloc] initWithTitle:@"Show" style:UIBarButtonItemStyleDone target:self action:@selector(testAction:)];
    
    self.navigationItem.rightBarButtonItem = testButton;
    
    [self createStudentsArray];
    
    [self.mapView registerClass:[MKPinAnnotationView class] forAnnotationViewWithReuseIdentifier:[ASStudent reuseIdentifier]];
 
}

#pragma mark - Private Methods

- (void)createStudentsArray {
    
    NSMutableArray *students = [NSMutableArray array];
    
    CLLocationCoordinate2D baseCoodrinates = self.locationManager.location.coordinate;
    
    for (int i = 0; i < 20; i++) {
        
        ASStudent *student = [[ASStudent alloc] init];
        
        student.name = [self randomStringWithLength:[self getNameLength]];
        student.lastName = [self randomStringWithLength:[self getNameLength]];
        student.coordinate = CLLocationCoordinate2DMake(baseCoodrinates.latitude + [self randomDoubleBetween:-0.2 and:0.2],
                                                         baseCoodrinates.longitude + [self randomDoubleBetween:-0.2 and:0.2]);
        
        student.birthDate = [self randomDate];
        
        [student generateTitleAndSubTitle];
        
        [students addObject:student];
    }
    
    self.studentsArray = students;
}

-(NSString *)randomStringWithLength:(int)len {
    
    static NSString *letters = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex:arc4random_uniform((uint32_t)[letters length])]];
    }
    
    return randomString;
}

- (NSDate *)randomDate {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComponents = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:[NSDate date]];
    
    [dateComponents setDay:1];
    [dateComponents setMonth:1];
    [dateComponents setYear:2000];
    
    NSDate *date = [calendar dateFromComponents:dateComponents];
    
    NSTimeInterval delta = (double)arc4random_uniform(315) * 100000;
    
    date = [NSDate dateWithTimeInterval:delta sinceDate:date];
    
    return date;
}

- (int)getNameLength {
    
    return 2 + arc4random_uniform(9);
}

- (CLLocationDegrees)randomDoubleBetween:(CLLocationDegrees)smallNumber and:(CLLocationDegrees)bigNumber {
    double diff = bigNumber - smallNumber;
    return (((double) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        
        return nil;
    }
    
    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:[ASStudent reuseIdentifier] forAnnotation:annotation];
    
    pin.canShowCallout = YES;
    pin.animatesDrop = YES;
    pin.pinTintColor = [UIColor greenColor];
    
    return pin;
    
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        
        self.mapView.showsUserLocation = YES;
    }
}

#pragma mark - Actions

- (void)testAction:(UIBarButtonItem *)barButton {
    
    if (self.mapView.annotations.count > 1) {
        
        barButton.title = @"Show";
        [self.mapView removeAnnotations:self.studentsArray];
        
    } else {
        
        barButton.title = @"Hide";
        [self.mapView addAnnotations:self.studentsArray];
    }
}


@end
