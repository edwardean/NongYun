
    //
    //  WeatherObject.h
    //  nmnmkj
    //
    //  Created by 航 李 on 12-4-3.
    //  Copyright (c) 2012年 南阳理工学院. All rights reserved.
    //

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import "CheckNetwork.h"
@protocol WeatherDelegate;


@interface WeatherObject : NSObject <CLLocationManagerDelegate, NSXMLParserDelegate>{
    CLLocationManager *locationManager;
    NSDictionary *location;
    NSDictionary *windCondition;
    NSDictionary *atmosphere;
	NSDictionary *current_Weatherdata;//目前天气
	NSDictionary *today_Weatherdata;//今天天气
	NSDictionary *tomorrow_Weatherdata;//明天天气
	NSDictionary *sunriseAndsunset;//日出日落
	NSDictionary *location_Data;//所在定位
	NSString *woeid;//求woeid,通过经纬度查询flickr得到该地区的woeid值，通过该值得到天气数据
	id<WeatherDelegate> delegate;
	
	BOOL today;
	BOOL isStart;
    BOOL firstRun;
}
@property (nonatomic, retain)NSDictionary *location;
@property (nonatomic, retain)NSDictionary *windCondition;
@property (nonatomic, retain)NSDictionary *atmosphere;
@property(nonatomic, retain)CLLocationManager *locationManager;
@property(nonatomic, retain)NSDictionary *current_Weatherdata;
@property(nonatomic, retain)NSDictionary *today_Weatherdata;
@property(nonatomic, retain)NSDictionary *tomorrow_Weatherdata;
@property(nonatomic, retain)NSDictionary *sunriseAndsunset;
@property(nonatomic, retain)NSDictionary *location_Data;
@property(nonatomic, retain)NSString *woeid;
@property(assign) id<WeatherDelegate> delegate;

- (void)updateWeather;
@end


@protocol WeatherDelegate <NSObject>
@optional
-(void)getWeatherFinish;
-(void)getWeatherError;

@end

