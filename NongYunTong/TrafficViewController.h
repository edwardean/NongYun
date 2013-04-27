    //
    //  TrafficViewController.h
    //  NongYunTong
    //
    //  Created by Edward on 12-5-16.
    //  Copyright (c) 2012年 南阳理工学院. All rights reserved.
    //


#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>
#import "ASIHTTPRequest.h"
#import "SBJson.h"

@interface TrafficViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate>
{
    CLLocation *current;
    MKMapView *_mapView;
    CLLocationCoordinate2D userCoor;
    
    UIImageView *route_view;
    NSArray *routes;
    UIColor *line_color;
    
    ASIHTTPRequest *request;
    CLGeocoder *geo;
    CLLocationManager *location;
    MKPointAnnotation *pointAnnotation;
    SBJsonParser *parser;
}
@property (strong,nonatomic)ASIHTTPRequest *request;
@end