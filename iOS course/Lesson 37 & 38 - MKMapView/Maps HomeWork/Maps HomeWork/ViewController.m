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
@property (nonatomic, strong) NSMutableArray<MKPolyline *> *drawedPolylines;

@property (nonatomic, strong) NSSet<ASStudent *> *fiveKmStudentsSet;
@property (nonatomic, strong) NSSet<ASStudent *> *tenKmStudentsSet;
@property (nonatomic, strong) NSSet<ASStudent *> *fifteenKmStudentsSet;

@property (nonatomic, strong) UIBarButtonItem *routsButton;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.drawedPolylines = [NSMutableArray array];
    
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
    UIBarButtonItem *pathButton = [[UIBarButtonItem alloc] initWithTitle:@"Show routs" style:UIBarButtonItemStylePlain target:self action:@selector(showPath:)];
    
    self.navigationItem.rightBarButtonItem = testButton;
    self.navigationItem.leftBarButtonItems = @[meetingButton, pathButton];
    
    self.routsButton = pathButton;
    
    [self createStudentsArray];
    
    [self.mapView registerClass:[MKAnnotationView class] forAnnotationViewWithReuseIdentifier:[ASStudent reuseIdentifier]];
    
    self.statisticView.hidden = YES;
 
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

- (void)addOverlaysForMeetingAnnotation:(CLLocationCoordinate2D)coordinate {
    
    MKCircle *smallCircle = [MKCircle circleWithCenterCoordinate:coordinate radius:5000];
    MKCircle *mediumCircle = [MKCircle circleWithCenterCoordinate:coordinate radius:10000];
    MKCircle *largeCircle = [MKCircle circleWithCenterCoordinate:coordinate radius:15000];
    
    [self.mapView addOverlays:@[smallCircle, mediumCircle, largeCircle]];
}

- (void)calculatePeoplePerCircle {
    
    CLLocation *meetingLocation = [[CLLocation alloc] initWithLatitude:self.currentMeeting.coordinate.latitude
                                                             longitude:self.currentMeeting.coordinate.longitude];
    
    NSMutableSet *fiveKmSet = [NSMutableSet set];
    NSMutableSet *tenKmSet = [NSMutableSet set];
    NSMutableSet *fifteenKmSet = [NSMutableSet set];
    
    for (ASStudent *stud in self.studentsArray) {
        
        CLLocation *studLocation = [[CLLocation alloc] initWithLatitude:stud.coordinate.latitude
                                                              longitude:stud.coordinate.longitude];
        
        CLLocationDistance distance = [meetingLocation distanceFromLocation:studLocation];
        
        if (distance <= 15000 && distance > 10000) {
            [fifteenKmSet addObject:stud];
        } else if (distance <= 10000 && distance > 5000) {
            [tenKmSet addObject:stud];
        } else if (distance <= 5000) {
            [fiveKmSet addObject:stud];
        }
    }
    
    self.fiveKmStudentsSet = fiveKmSet;
    self.tenKmStudentsSet = tenKmSet;
    self.fifteenKmStudentsSet = fifteenKmSet;
}

- (void)updatePeopleCountView {
    
    self.fiveKmLabel.text = [NSString stringWithFormat:@"%ld people", self.fiveKmStudentsSet.count];
    self.tenKmLabel.text = [NSString stringWithFormat:@"%ld people", self.tenKmStudentsSet.count];
    self.fifteenKmLabel.text = [NSString stringWithFormat:@"%ld people", self.fifteenKmStudentsSet.count];
}

- (MKDirectionsRequest *)createDirectionRequestForAnnotation:(ASStudent *)annotation {
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    
    MKPlacemark *sourcePlaceMark = [[MKPlacemark alloc] initWithCoordinate:annotation.coordinate];
    MKPlacemark *destinationPlaceMark = [[MKPlacemark alloc] initWithCoordinate:self.currentMeeting.coordinate];
    
    request.source = [[MKMapItem alloc] initWithPlacemark:sourcePlaceMark];
    request.destination = [[MKMapItem alloc] initWithPlacemark:destinationPlaceMark];
    
    request.transportType = MKDirectionsTransportTypeAutomobile;
    request.requestsAlternateRoutes = NO;
    
    return request;
}

- (NSMutableSet *)filterStudentsWithChanceToCome:(NSSet *)studentsSet {
    
    NSMutableSet *filteredStudentsSet = [NSMutableSet set];
    
    float chance = 0;
    if ([studentsSet isEqualToSet:self.fiveKmStudentsSet]) {
        chance = 0.9;
    } else if ([studentsSet isEqualToSet:self.tenKmStudentsSet]) {
        chance = 0.4;
    } else {
        chance = 0.1;
    }
    
    for (ASStudent *stud in studentsSet) {
        
        BOOL isComing = [self tryChance:chance];
        if (isComing) {
            [filteredStudentsSet addObject:stud];
        }
    }
    
    return filteredStudentsSet;
}

- (BOOL)tryChance:(float)chance {
    
    chance *= 10;
    
    uint32_t randomNumber = arc4random_uniform(9) + 1;
    if (randomNumber <= chance) {
        return YES;
    } else {
        return NO;
    }
}

- (void)showAlertWithTitile:(NSString *)title andMessage:(NSString *)message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
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

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
    
    if ([overlay isKindOfClass:[MKCircle class]]) {
        
        MKCircleRenderer *renderer = [[MKCircleRenderer alloc] initWithOverlay:overlay];
        renderer.fillColor = [UIColor redColor];
        renderer.strokeColor = [UIColor blackColor];
        renderer.lineWidth = 2.5f;
        renderer.alpha = 0.2f;
        
        return renderer;
    }
    
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        renderer.lineWidth = 2.f;
        renderer.strokeColor = [UIColor blueColor];
        
        return renderer;
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState {
    
    if (newState == MKAnnotationViewDragStateStarting) {
        
        [self.mapView removeOverlays:self.mapView.overlays];
    }
    
    if (newState == MKAnnotationViewDragStateNone) {
        
        [self addOverlaysForMeetingAnnotation:view.annotation.coordinate];
    }
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
        
        [self addOverlaysForMeetingAnnotation:meetingAnnotation.coordinate];
        
        [self calculatePeoplePerCircle];
        [self updatePeopleCountView];
        self.statisticView.hidden = NO;
        
    } else  {
        
        barButton.title = @"Start Meeting";
        
        [self.mapView removeAnnotation:self.currentMeeting];
        [self.mapView removeOverlays:self.mapView.overlays];
        self.currentMeeting = nil;
        self.statisticView.hidden = YES;
        [self.drawedPolylines removeAllObjects];
        self.routsButton.title = @"Show routs";
        
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

- (void)showPath:(UIBarButtonItem *)button {
    
    if (self.drawedPolylines.count) {
        
        [self.mapView removeOverlays:self.drawedPolylines];
        [self.drawedPolylines removeAllObjects];
        button.title = @"Show routs";
        
    } else {
        
        button.title = @"Hide routs";
        
        NSMutableArray *directionRequests = [NSMutableArray array];
        
        NSMutableSet *arrivingStudentsFiveKm = [self filterStudentsWithChanceToCome:self.fiveKmStudentsSet];
        NSMutableSet *arrivingStudentsTenKm = [self filterStudentsWithChanceToCome:self.tenKmStudentsSet];
        NSMutableSet *arrivingStudentsFifteenKm = [self filterStudentsWithChanceToCome:self.fifteenKmStudentsSet];
        
        NSLog(@"Range 5km: %ld/%ld will come", arrivingStudentsFiveKm.count, self.fiveKmStudentsSet.count);
        NSLog(@"Range 10km: %ld/%ld will come", arrivingStudentsTenKm.count, self.tenKmStudentsSet.count);
        NSLog(@"Range 15km: %ld/%ld will come", arrivingStudentsFifteenKm.count, self.fifteenKmStudentsSet.count);
        
        NSMutableSet *finalSet = [NSMutableSet setWithSet:arrivingStudentsFiveKm];
        [finalSet unionSet:arrivingStudentsTenKm];
        [finalSet unionSet:arrivingStudentsFifteenKm];
        
        for (ASStudent *stud in finalSet) {
            
            MKDirectionsRequest *request = [self createDirectionRequestForAnnotation:stud];
            [directionRequests addObject:request];
        }
        
        for (MKDirectionsRequest *request in directionRequests) {
            
            MKDirections *direction = [[MKDirections alloc] initWithRequest:request];
            
            [direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
                
                if (error) {
                    [self showAlertWithTitile:@"Error" andMessage:error.localizedDescription];
                } else if (!response.routes.count) {
                    [self showAlertWithTitile:@"Error" andMessage:@"No routes found"];
                } else {
                    NSArray *polylinesArray = [response.routes valueForKeyPath:@"polyline"];
                    [self.drawedPolylines addObject:polylinesArray.firstObject];
                    [self.mapView addOverlays:polylinesArray level:MKOverlayLevelAboveRoads];
                }
            }];
        }
        
    }
    
    
}




@end
