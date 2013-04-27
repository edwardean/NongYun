//
//  VolunteerXML.h
//  NongYunTong
//
//  Created by Edward on 12-5-18.
//  Copyright (c) 2012年 南阳理工学院. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VolunteerData;
@interface VolunteerXML : NSObject
@property (strong,nonatomic) NSMutableArray *mutArray;
@property (strong,nonatomic) VolunteerData *volunteerData;
-(NSMutableArray *)XML;
@end
