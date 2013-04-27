    //
    //  WeatherObject.m
    //  nmnmkj
    //
    //  Created by 航 李 on 12-4-3.
    //  Copyright (c) 2012年 南阳理工学院. All rights reserved.
    //

#import "WeatherObject.h"
#define YAHOOWeather @"http://query.yahooapis.com/v1/public/yql?q=select * from flickr.places where lat=\"%f\" and lon=\"%f\" and api_key=\"f5bf3c7831b1cd751dfa9210e1ca529b\" and accuracy=\"9\""


@implementation WeatherObject
@synthesize woeid, locationManager;
@synthesize	current_Weatherdata, today_Weatherdata, tomorrow_Weatherdata, sunriseAndsunset, location_Data,location,windCondition,atmosphere; 
@synthesize	delegate;



- (id)init{
	self = [super init];
	if(self){
		CLLocationManager *_locationManager = [[CLLocationManager alloc]init];
		[_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];//设置最佳精确度
		[_locationManager setDistanceFilter:1000];//距离改变值1000米
		self.locationManager = _locationManager;
		[locationManager setDelegate:self];
		[_locationManager release];
		today = YES;
		delegate = nil;
	}
    firstRun = YES;
	return self;
}
- (void)updateWeather{
	
    if(firstRun)
    {
        /*UIAlertView *firstLoading = [[[UIAlertView alloc]initWithTitle:@"提醒"
                                                              message:@"初次加载可能需要更长时间" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] autorelease];
        [firstLoading show];*/
    }
    firstRun = NO;
    [CheckNetwork isExistenceNetwork];
	NSLog(@"开始update...");
	if([CLLocationManager locationServicesEnabled])//判断定位服务是否开启
        {
		//NSLog(@"ok");
		[locationManager startUpdatingLocation];//开始定位
        }
	else {
		UIAlertView *locationalert =[[[UIAlertView alloc]initWithTitle:@"定位失败" 
                                                              message:@"请打开定位服务" 
                                                              delegate:nil 
                                                     cancelButtonTitle:@"确定" 
                                                    otherButtonTitles:nil]autorelease];
        [locationalert show];
	}
    
}
#pragma mark -
#pragma mark locationManager delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	isStart = YES;
	if(newLocation.horizontalAccuracy >=0 )
        {
		[locationManager stopUpdatingLocation];
		[self performSelectorInBackground:@selector(getWoeidData) withObject:nil];
        }else {
            
            [locationManager stopUpdatingLocation];
            isStart = NO;
            if([[self delegate] respondsToSelector:@selector(getWeatherError)])
                {
                [[self delegate] performSelector:@selector(getWeatherError)];
                }
        }
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	//NSLog(@"定位错误:%@",[error localizedDescription]);
	[locationManager stopUpdatingLocation];
	if([[self delegate] respondsToSelector:@selector(getWeatherError)])
        {
		[[self delegate] performSelector:@selector(getWeatherError)];
        }
}
#pragma mark -
#pragma mark getWoeidXml/parserWoeidXml , parserWeatherXML

- (void)getWoeidData{
	CLLocationCoordinate2D coord = [locationManager.location coordinate];
	double latitude = coord.latitude;
	double longitude = coord.longitude;
    NSString *theStr = [[NSString stringWithFormat:YAHOOWeather,latitude,longitude]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"the location url is:%@",theStr);
	NSURL *theURL = [[[NSURL alloc]initWithString:theStr] autorelease];
	[self performSelector:@selector(parserWoeid:) withObject:theURL];
}

- (void)parserWoeid:(NSURL *)url
{
	//NSLog(@"start parserWoeid");
	
	
    NSXMLParser *parser = [[[NSXMLParser alloc] initWithContentsOfURL:url] autorelease];
	[parser setDelegate:self];
    [parser parse];
	
	if(woeid!=nil&& ![parser parserError])
        {
		[self performSelector:@selector(parserWeather)];
        }
    else
        {
       /* UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"错误" 
                              message:@"处理数据错误" 
                              delegate:nil 
                              cancelButtonTitle:@"确定" 
                              otherButtonTitles:nil];
        [alert show];
        [alert release];*/
        }
	
	
    if([[self delegate]respondsToSelector:@selector(getWeatherError)])
        [[self delegate] performSelector:@selector(getWeatherError)];
}
- (void)parserWeather
{
	//NSLog(@"start parserWeather");
    
    NSString *theStr = [NSString stringWithFormat:@"http://weather.yahooapis.com/forecastrss?w=%@&u=c",woeid];
    NSLog(@"The weather url is:%@",theStr);
    NSURL *theURL = [NSURL URLWithString:theStr];
    NSXMLParser *parser = [[[NSXMLParser alloc] initWithContentsOfURL:theURL] autorelease];
    [parser setDelegate:self];
    [parser parse];
	
	isStart = NO;
	if([[self delegate]respondsToSelector:@selector(getWeatherFinish)])
		[[self delegate] performSelector:@selector(getWeatherFinish)];
	
	
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
    
    if([elementName isEqualToString:@"place"])//求woeid
        {
		self.woeid = [attributeDict objectForKey:@"woeid"];
		self.location_Data = attributeDict;
		return;
        }
    
    if([elementName isEqualToString:@"yweather:astronomy"])
        {
		self.sunriseAndsunset = attributeDict;
		return;
        }
	if([elementName isEqualToString:@"yweather:condition"])
        {
		self.current_Weatherdata = attributeDict;
           // NSLog(@"数据更新时间:%@",[current_Weatherdata objectForKey:@"date"]);
		return;
        }
    if ([elementName isEqualToString:@"yweather:location"]) {
        self.location = attributeDict;
        //NSLog(@"位置: %@",location);
        return;
    }
    if ([elementName isEqualToString:@"yweather:wind"]) {
        self.windCondition = attributeDict;
        //NSLog(@"风: %@",windCondition);
        return;
    }
    if ([elementName isEqualToString:@"yweather:atmosphere"]) {
        self.atmosphere = attributeDict;
       // NSLog(@"大气状况: %@",atmosphere);
        return;
    }
	if([elementName isEqualToString:@"yweather:forecast"])
        {
		if(today){
			self.today_Weatherdata = attributeDict;
			today = NO;
			return;
		}else{
			self.tomorrow_Weatherdata = attributeDict;
			today = YES;
			return;
		}
        }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (qName) {
       elementName = qName;
    }
}
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
	//NSLog(@"NSXMLParser错误:%@",[parseError localizedDescription]);
}
- (void)dealloc
{
	[woeid release];
	[locationManager release];
    [location release];
	[current_Weatherdata release];
	[today_Weatherdata release];
	[tomorrow_Weatherdata release];
	[location_Data release];
    [atmosphere release];
	[sunriseAndsunset release];
	[super dealloc];
}
@end
