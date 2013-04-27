//
//  CheckNetwork.m
//  ConvenienceWeather
//
//  Created by 航 李 on 12-5-17.
//  Copyright (c) 2012年 Turing. All rights reserved.
//

#import "CheckNetwork.h"
#import "Reachability.h"
@implementation CheckNetwork
+(BOOL)isExistenceNetwork
{
	BOOL isExistenceNetwork;
	Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
			isExistenceNetwork=FALSE;
            break;
        case ReachableViaWWAN:
			isExistenceNetwork=TRUE;
            break;
        case ReachableViaWiFi:
			isExistenceNetwork=TRUE;      
            break;
    }
	if (!isExistenceNetwork) {
		UIAlertView *myalert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络不可达" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
		[myalert show];
		[myalert release];
	}
	return isExistenceNetwork;
}
@end