    //
    //  TrafficViewController.m
    //  NongYunTong
    //
    //  Created by Edward on 12-5-16.
    //  Copyright (c) 2012年 南阳理工学院. All rights reserved.
    //

#import "TrafficViewController.h"

@interface TrafficViewController ()

@end

@implementation TrafficViewController
@synthesize request;
-(id)init{
    if (self = [super init]) {
        self.tabBarItem.title = @"交通服务";
        self.tabBarItem.image = [UIImage imageNamed:@"Third.png"];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    parser = [[SBJsonParser alloc]init];
    _mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    route_view =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    _mapView.mapType = MKMapTypeStandard;
    _mapView.showsUserLocation = YES;
    userCoor = _mapView.userLocation.location.coordinate;
    MKCoordinateRegion region;
    region.center.latitude = 32.970358;
    region.center.longitude = 112.562066;
    MKCoordinateSpan span;
    span.latitudeDelta = .2;
    span.longitudeDelta = .2;
    region.span = span;
    _mapView.delegate = self;
    
    [_mapView setRegion:region animated:YES];
    
    MKPointAnnotation *annotation1 = [[MKPointAnnotation alloc]init];   //这里为添加大图钉的用法，只需要穿个经纬度就行啦
    CLLocationCoordinate2D coor1;
    coor1.latitude = 33.033785;
    coor1.longitude = 112.609335;
    annotation1.coordinate = coor1;
    annotation1.title = @"田径";
    
    MKPointAnnotation*annotation2 = [[MKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor2;
    coor2.latitude = 33.044121;
    coor2.longitude = 112.608526;
    annotation2.coordinate = coor2;
    annotation2.title = @"摔跤";
    
    MKPointAnnotation* annotation3 = [[MKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor3;
    coor3.latitude = 32.970358;
    coor3.longitude = 112.562066;
    annotation3.coordinate = coor3;
    annotation3.title = @"男篮";
    annotation3.subtitle = @"南阳理工学院";
    
    MKPointAnnotation* annotation4 = [[MKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor4;
    coor4.latitude = 32.997077;
    coor4.longitude = 112.584811;
    annotation4.coordinate = coor4;
    annotation4.title = @"武术、游泳、女篮";
    annotation4.subtitle = @"南阳市体育中心";
    
    MKPointAnnotation*annotation5 = [[MKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor5;
    coor5.latitude = 32.995851;
    coor5.longitude = 112.522684;
    annotation5.coordinate = coor5;
    annotation5.title = @"乒乓球";
    annotation5.subtitle = @"南阳师范学院";
    
    MKPointAnnotation* annotation6 = [[MKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor6;
    coor6.latitude = 32.975459;
    coor6.longitude = 112.498476;
    annotation6.coordinate = coor6;
    annotation6.title = @"毽球、花毽";
    annotation6.subtitle = @"南阳医专";
    
    MKPointAnnotation* annotation7 = [[MKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor7;
    coor7.latitude = 33.068254;
    coor7.longitude = 112.585835;
    annotation7.coordinate = coor7;
    annotation7.title = @"民兵三项";
    
    MKPointAnnotation* annotation8 = [[MKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor8;
    coor8.latitude = 33.016046;
    coor8.longitude = 112.599777;
    annotation8.coordinate = coor8;
    annotation8.title = @"龙舟";
    
    MKPointAnnotation* annotation9 = [[MKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor9;
    coor9.latitude = 32.622023;
    coor9.longitude = 112.852955;
    annotation9.coordinate = coor9;
    annotation9.title = @"舞龙舞狮";
    
    MKPointAnnotation* annotation10 = [[MKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor10;
    coor10.latitude = 32.694433;
    coor10.longitude = 112.620689;
    annotation10.coordinate = coor10;
    annotation10.title = @"秧歌";
    
    
    MKPointAnnotation* annotation11 = [[MKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor11;
    coor11.latitude = 33.197667;
    coor11.longitude = 112.547802;
    annotation11.coordinate = coor11;
    annotation11.title = @"钓鱼";
    
    
    MKPointAnnotation* annotation12 = [[MKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor12;
    coor12.latitude = 33.265934;
    coor12.longitude = 112.599921;
    annotation12.coordinate = coor12;
    annotation12.title = @"风筝";
    
    
    MKPointAnnotation* annotation13 = [[MKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor13;
    coor13.latitude = 32.694886;
    coor13.longitude = 112.092306;
    annotation13.coordinate = coor13;
    annotation13.title = @"象棋";
    
    MKPointAnnotation* annotation14 = [[MKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor14;
    coor14.latitude = 330224356;
    coor14.longitude = 111.847617;
    annotation14.coordinate = coor13;
    annotation14.title = @"自行车负重";
    
    
    [_mapView addAnnotation:annotation1];
    [_mapView addAnnotation:annotation2];
    [_mapView addAnnotation:annotation3];
    [_mapView addAnnotation:annotation4];
    [_mapView addAnnotation:annotation5];
    [_mapView addAnnotation:annotation6];
    [_mapView addAnnotation:annotation7];
    [_mapView addAnnotation:annotation8];
    [_mapView addAnnotation:annotation9];
    [_mapView addAnnotation:annotation10];
    [_mapView addAnnotation:annotation11];
    [_mapView addAnnotation:annotation12];
    [_mapView addAnnotation:annotation13];
    [_mapView addAnnotation:annotation14];
    [_mapView addSubview:route_view];
    
    [self.view addSubview:_mapView];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    NSLog(@"jkhdlgjhguyrushfgdvxbnzmdfghjhjfdkjzghkhjzf\\n\n");
    if([annotation isKindOfClass:[MKPointAnnotation class]])
    {  //将大图钉加载到图钉视图上
        
        MKPinAnnotationView *newAnnotationView = [[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"]autorelease];
        newAnnotationView.pinColor = MKPinAnnotationColorRed;
        newAnnotationView.animatesDrop = YES;
        
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view 
{
    NSLog(@"aaa:%F\n,bbb:%f\n",_mapView.userLocation.coordinate.longitude,view.annotation.coordinate.longitude);
    CLLocationCoordinate2D coord1 = CLLocationCoordinate2DMake(31.484137685, 120.371875243);
    CLLocationCoordinate2D coord2 = CLLocationCoordinate2DMake(31.484044745, 120.371879653);
        //[self show_two_point_route:coord1 to:coord2];
    [self show_two_point_route:_mapView.userLocation.coordinate to:view.annotation.coordinate];
    
}

-(void)show_two_point_route:(CLLocationCoordinate2D)point1 to:(CLLocationCoordinate2D)point2
{NSLog(@"show_route");
    routes = [self calculate_routes_from:point1 to:point2];
    [self update_route_view];
    [self center_map];
}

-(NSArray*)calculate_routes_from:(CLLocationCoordinate2D)f to:(CLLocationCoordinate2D)t
{
    NSString *saddr = [NSString stringWithFormat:@"%f,%f",f.latitude,f.longitude];
    NSString *daddr = [NSString stringWithFormat:@"%f,%f",t.latitude,t.longitude];
    
    NSString *apiUrlStr = [NSString stringWithFormat:@"http://maps.google.com/maps/api/directions/json?origin=%@&destination=%@&sensor=true",saddr,daddr];
    
    
    NSURL *apiUrl = [NSURL URLWithString:apiUrlStr];
    [self setRequest:[ASIHTTPRequest requestWithURL:apiUrl]];NSLog(@"%@",apiUrl);
    NSLog(@"urlshow");
    [request startSynchronous];
    NSString *apiResponse = [request responseString];
    NSLog(@"www:%@",[request responseString]);
    NSDictionary *dic_data = [apiResponse JSONValue];
    NSArray *dic_routes = [dic_data objectForKey:@"routes"];
    
    NSDictionary *legs = [dic_routes objectAtIndex:0];
    
    NSDictionary *temp = [legs objectForKey:@"overview_polyline"];
    NSLog(@"temp is %@",temp);
    NSString *end_points = [temp objectForKey:@"points"];
    return [[self decodePolyline:[end_points mutableCopy]]retain];
}

-(NSMutableArray *)decodePolyline:(NSMutableString *)encoded
{
    NSInteger len = [encoded length];
    NSInteger index = 0;
    NSMutableArray *array = [[[NSMutableArray alloc]init]autorelease];
    NSInteger lat = 0;
    NSInteger lng = 0;
    while(index <len)
        {
        NSInteger b;
        NSInteger shift = 0;
        NSInteger result = 0;
        do{
            b = [encoded characterAtIndex:index++] - 63;
            result |=(b &0x1f) << shift;
            shift += 5;
        }while(b >= 0x20);
        NSInteger dlat = ((result & 1)? ~(result >> 1) : (result >> 1));
        lat +=dlat;
        shift = 0;
        result = 0;
        do {
            b = [encoded characterAtIndex:index++] - 63;
            result |=(b &0x1f) << shift;
            shift += 5;
        }while(b >= 0x20);
        NSInteger dlng = ((result & 1)? ~(result >> 1) : (result >> 1));
        lng +=dlng;
        NSNumber *latitude = [[[NSNumber alloc]initWithFloat:lat * 1e-5]autorelease];
        NSNumber *longitude = [[[NSNumber alloc]initWithFloat:lng * 1e-5]autorelease];
        printf("[%f,",[latitude doubleValue]);
        printf("%f]",[longitude doubleValue]);
        CLLocation *loc = [[[CLLocation alloc]initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]]autorelease];
        [array addObject:loc];
        }
    return array;
    
}

-(void)update_route_view
{
    CGContextRef context = CGBitmapContextCreate(nil, 
                                                 route_view.frame.size.width, 
                                                 route_view.frame.size.height, 
                                                 8, 
                                                 4 * route_view.frame.size.width, 
                                                 CGColorSpaceCreateDeviceRGB(), 
                                                 kCGImageAlphaPremultipliedLast);
    NSLog(@"route_view.fram.size.width = %f,route_view.frame.size.height = %f",route_view.frame.size.width,route_view.frame.size.height);
    CGContextSetStrokeColorWithColor(context, line_color.CGColor);
    CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 4.0);
    for(int i = 0;i< routes.count;i++)
        {
        CLLocation *location_ = [routes objectAtIndex:i];
        CGPoint point = [_mapView convertCoordinate:location_.coordinate toPointToView:route_view];
        
        if(i==0){
            CGContextMoveToPoint(context, point.x, route_view.frame.size.height-point.y);
        }
        else {
            CGContextAddLineToPoint(context, point.x, route_view.frame.size.height-point.y);
        }
        }
    CGContextStrokePath(context);
    CGImageRef image = CGBitmapContextCreateImage(context);
    UIImage *img = [UIImage imageWithCGImage:image];
    
    route_view.image =img;
    CGContextRelease(context);
}

-(void)center_map{
    MKCoordinateRegion region;
    CLLocationDegrees maxLat = -90;
    CLLocationDegrees maxLon = -180;
    CLLocationDegrees minLat = 90;
    CLLocationDegrees minLon = 180;
    for(int idx = 0; idx < routes.count; idx++){
        CLLocation *currentLocation = [routes objectAtIndex:idx];
        if(currentLocation.coordinate.latitude > maxLat)
            maxLat = currentLocation.coordinate.latitude;
        if(currentLocation.coordinate.latitude < minLat)
            minLat = currentLocation.coordinate.latitude;
        if(currentLocation.coordinate.longitude > maxLon)
            maxLon = currentLocation.coordinate.longitude;
        if(currentLocation.coordinate.longitude < minLon)
            minLon = currentLocation.coordinate.longitude;
    }
    region.center.latitude = (maxLat + minLat) / 2;
    region.center.longitude = (maxLon + minLon) / 2 ;
    region.span.latitudeDelta = maxLat - minLat;
    region.span.longitudeDelta = maxLon - minLon;
    
    [_mapView setRegion:region animated:YES];
}

#pragma mark mapView delegate functions
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    route_view.hidden = YES;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [self update_route_view];
    route_view.hidden = NO;
    [route_view setNeedsDisplay];
}
@end
