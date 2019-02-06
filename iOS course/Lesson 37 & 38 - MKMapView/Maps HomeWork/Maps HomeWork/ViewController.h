//
//  ViewController.h
//  Maps HomeWork
//
//  Created by Alex on 1/23/19.
//  Copyright © 2019 Alex Shpilenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKMapView;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *statisticView;
@property (weak, nonatomic) IBOutlet UILabel *fiveKmLabel;
@property (weak, nonatomic) IBOutlet UILabel *tenKmLabel;
@property (weak, nonatomic) IBOutlet UILabel *fifteenKmLabel;

@end

