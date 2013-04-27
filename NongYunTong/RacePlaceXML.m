//
//  RacePlaceXML.m
//  NongYunTong
//
//  Created by Edward on 12-5-19.
//  Copyright (c) 2012年 南阳理工学院. All rights reserved.
//

#import "RacePlaceXML.h"
#import "RacePlaceData.h"
#import "TBXML.h"
@implementation RacePlaceXML
@synthesize racePlaceData,mutArray;
-(NSMutableArray *)XML 
{
    
    mutArray = [[NSMutableArray alloc]init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"competitionInfo" ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSString *string = [[NSString alloc] initWithData:data encoding:0x80000632];
    string = [string stringByReplacingOccurrencesOfString:@"encoding=\"gb2312\"" withString:@""];
    
    NSData *newData = [string dataUsingEncoding:NSUTF8StringEncoding];
    TBXML *tbXml = [TBXML tbxmlWithXMLData:newData];
    
    TBXMLElement * root = tbXml.rootXMLElement;
    
    if (root) 
    {
        TBXMLElement *info = [TBXML childElementNamed:@"competitionInfo" parentElement:root];
        while (info != nil) 
        {
            racePlaceData = [[RacePlaceData alloc]init];
            
            TBXMLElement *pName = [TBXML childElementNamed:@"cpt_name" parentElement:info];
            TBXMLElement *pAddress = [TBXML childElementNamed:@"cpt_address" parentElement:info];
            TBXMLElement *pProject = [TBXML childElementNamed:@"cpt_project" parentElement:info];
            TBXMLElement *pIntroduction = [TBXML childElementNamed:@"cpt_introduction" parentElement:info];
            TBXMLElement *pBus = [TBXML childElementNamed:@"cpt_bus" parentElement:info];
            TBXMLElement *pImage = [TBXML childElementNamed:@"image_name" parentElement:info];
            
            racePlaceData.pName = [TBXML textForElement:pName];
            racePlaceData.pAddress = [TBXML textForElement:pAddress];
            racePlaceData.pProject = [TBXML textForElement:pProject];
            racePlaceData.pIntroduction = [TBXML textForElement:pIntroduction];
            racePlaceData.pBus= [TBXML textForElement:pBus];
            racePlaceData.pImage = [TBXML textForElement:pImage];
            [mutArray addObject:racePlaceData];
            [racePlaceData release];
            
            info = [TBXML nextSiblingNamed:@"competitionInfo" searchFromElement:info];
        }
    }
    
    return mutArray;
    
}
@end
