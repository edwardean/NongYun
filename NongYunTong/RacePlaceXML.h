//
//  RacePlaceXML.h
//  NongYunTong
//
//  Created by Edward on 12-5-19.
//  Copyright (c) 2012年 TuringTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RacePlaceData;
@interface RacePlaceXML : NSObject
@property (strong,nonatomic)RacePlaceData *racePlaceData;
@property (strong,nonatomic) NSMutableArray *mutArray;
-(NSMutableArray *)XML;
@end
