//
//  LifeXML.h
//  NongYunTong
//
//  Created by Edward on 12-5-21.
//  Copyright (c) 2012年 南阳理工学院. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LifeData;
@interface LifeXML : NSObject
@property (strong,nonatomic) LifeData *lifeData;
@property (strong,nonatomic)NSMutableArray *mutableArray;
-(NSMutableArray *)XML:(NSString *)itemXML;
@end
