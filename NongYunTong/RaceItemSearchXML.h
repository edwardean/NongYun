//
//  RaceItemSearchXML.h
//  NongYunTong
//
//  Created by Edward on 12-5-19.
//  Copyright (c) 2012年 TuringTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RaceItemSearchData;
@interface RaceItemSearchXML : NSObject
@property (strong,nonatomic)RaceItemSearchData *raceItemSearchData;
@property (strong,nonatomic)NSMutableArray *itemArray;
-(NSMutableArray *)XML:(NSString *)itemXML;
@end
