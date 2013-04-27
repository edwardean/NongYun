//
//  PeopleXML.h
//  NongYunTong
//
//  Created by Edward on 12-5-17.
//  Copyright (c) 2012年 南阳理工学院. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeopleXML : NSObject

@property (strong,nonatomic) NSMutableArray *mutArray;
-(void)XML:(NSString *)XmlFileName;
@end
