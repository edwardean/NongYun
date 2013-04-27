//
//  PeopleXML.h
//  NongYunTong
//
//  Created by Edward on 12-5-17.
//  Copyright (c) 2012年 TuringTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeopleXML : NSObject

@property (strong,nonatomic) NSMutableArray *mutArray;
-(void)XML:(NSString *)XmlFileName;
@end
