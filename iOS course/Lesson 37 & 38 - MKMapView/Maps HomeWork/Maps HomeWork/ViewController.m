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
#import "ASMeeting.h"
#import "StudentInfoPopupController.h"

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSArray<ASStudent *> *studentsArray;
@property (nonatomic, strong) ASMeeting *currentMeeting;

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
    UIBarButtonItem *meetingButton = [[UIBarButtonItem alloc] initWithTitle:@"Start Meeting" style:UIBarButtonItemStylePlain target:self action:@selector(meetingAction:)];
    
    self.navigationItem.rightBarButtonItem = testButton;
    self.navigationItem.leftBarButtonItem = meetingButton;
    
    [self createStudentsArray];
    
    [self.mapView registerClass:[MKAnnotationView class] forAnnotationViewWithReuseIdentifier:[ASStudent reuseIdentifier]];
 
}

#pragma mark - Private Methods

- (void)createStudentsArray {
    
    NSMutableArray *students = [NSMutableArray array];
    
    for (int i = 0; i < 20; i++) {
        
        ASStudent *student = [[ASStudent alloc] init];
        
        student.name = [self randomStringWithLength:[self getNameLength]];
        student.lastName = [self randomStringWithLength:[self getNameLength]];
        student.coordinate = [self getRandomCoordinate];
        
        student.birthDate = [self randomDate];
        student.gender = arc4random()%2;
        
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

- (ASStudent *)getStudentForAnnotationSuperView:(UIView *)view {
    
    if ([view isKindOfClass:[MKAnnotationView class]]) {
        
        if ([[(MKAnnotationView *)view annotation] isKindOfClass:[ASStudent class]]) {
            
            return [(MKAnnotationView *)view annotation];
            
        } else {
            
            return nil;
        }
        
    } else {
        
        if (view.superview) {
            
            return [self getStudentForAnnotationSuperView:[view superview]];
            
        } else {
            
            return nil;
        }
        
    }
}

- (CLLocationCoordinate2D)getRandomCoordinate {
    
    CLLocationCoordinate2D baseCoodrinates = self.locationManager.location.coordinate;
    CLLocationCoordinate2D retVal = CLLocationCoordinate2DMake(baseCoodrinates.latitude + [self randomDoubleBetween:-0.12 and:0.12],
                                                              baseCoodrinates.longitude + [self randomDoubleBetween:-0.12 and:0.12]);
    
    return retVal;
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        
        return nil;
    }
    
    MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:[ASStudent reuseIdentifier] forAnnotation:annotation];
    
    view.canShowCallout = YES;
    
    UIImage *image = nil;
    if ([annotation isKindOfClass:[ASStudent class]]) {
        
        if ([(ASStudent *)annotation gender] == male) {
            
            image = [UIImage imageNamed:@"malemale.png"];
        } else {
            
            image = [UIImage imageNamed:@"female.png"];
        }
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoDark];
        [button addTarget:self action:@selector(showInfo:) forControlEvents:UIControlEventTouchUpInside];
        view.rightCalloutAccessoryView = button;
        view.draggable = NO;
    }
    
    if ([annotation isKindOfClass:[ASMeeting class]]) {
        
        image = [UIImage imageNamed:@"meeting.png"];
        view.draggable = YES;
    }
    view.image = image;
    
    
    
    return view;
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        
        self.mapView.showsUserLocation = YES;
    }
}

#pragma mark - Actions

- (void)testAction:(UIBarButtonItem *)barButton {
    
    if ([barButton.title isEqualToString:@"Hide"]) {
        
        barButton.title = @"Show";
        [self.mapView removeAnnotations:self.studentsArray];
        
    } else {
        
        barButton.title = @"Hide";
        [self.mapView addAnnotations:self.studentsArray];
    }
}

- (void)meetingAction:(UIBarButtonItem *)barButton {
    
    if ([barButton.title isEqualToString:@"Start Meeting"]) {
        
        barButton.title = @"End Meeting";
        
        ASMeeting *meetingAnnotation = [[ASMeeting alloc] init];
        meetingAnnotation.title = @"Friendly Meeting";
        meetingAnnotation.subtitle = @"Please come and have fun";
        meetingAnnotation.coordinate = [self getRandomCoordinate];
        
        self.currentMeeting = meetingAnnotation;
        [self.mapView addAnnotation:self.currentMeeting];
        
        
    } else  {
        
        barButton.title = @"Start Meeting";
        
        [self.mapView removeAnnotation:self.currentMeeting];
        self.currentMeeting = nil;
        
    }
}

- (void)showInfo:(UIButton *)button {
    
    ASStudent *student = [self getStudentForAnnotationSuperView:button];
    StudentInfoPopupController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"1"];
    
    controller.modalPresentationStyle = UIModalPresentationPopover;
    UIPopoverPresentationController *popover = controller.popoverPresentationController;
    popover.delegate = controller;
    popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popover.sourceView = button;
    
    controller.preferredContentSize = CGSizeMake(600, 223);
    
    controller.student = student;
    
    [self presentViewController:controller animated:YES completion:nil];
}




@end
