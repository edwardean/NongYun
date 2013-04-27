//
//  LifeXML.m
//  NongYunTong
//
//  Created by Edward on 12-5-21.
//  Copyright (c) 2012年 南阳理工学院. All rights reserved.
//

#import "LifeXML.h"
#import "TBXML.h"
#import "LifeData.h"

@implementation LifeXML
@synthesize mutableArray,lifeData;


-(NSMutableArray *)XML:(NSString *)itemXML {
    
    mutableArray = [[NSMutableArray alloc]init];
    NSString *path = [[NSBundle mainBundle] pathForResource:itemXML ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSString *string = [[NSString alloc] initWithData:data encoding:0x80000632];
    string = [string stringByReplacingOccurrencesOfString:@"encoding=\"gb2312\"" withString:@""];
    
    NSData *newData = [string dataUsingEncoding:NSUTF8StringEncoding];
    TBXML *tbXml = [TBXML tbxmlWithXMLData:newData];
    
    TBXMLElement * root = tbXml.rootXMLElement;
    
    if (root) {
        TBXMLElement *info = [TBXML childElementNamed:@"info" parentElement:root];
        while (info != nil) {
            lifeData = [[LifeData alloc]init];
            
            TBXMLElement *Des1 = [TBXML childElementNamed:@"Des1" parentElement:info];
            TBXMLElement *Des2 = [TBXML childElementNamed:@"Des2" parentElement:info];
            TBXMLElement *Des3 = [TBXML childElementNamed:@"Des3" parentElement:info];
            TBXMLElement *Des4 = [TBXML childElementNamed:@"Des4" parentElement:info];
            TBXMLElement *Des5 = [TBXML childElementNamed:@"Des5" parentElement:info];
            TBXMLElement *Des6 = [TBXML childElementNamed:@"Des6" parentElement:info];
            TBXMLElement *Des7 = [TBXML childElementNamed:@"Des7" parentElement:info];
            TBXMLElement *Des8 = [TBXML childElementNamed:@"Des8" parentElement:info];
            lifeData.Des1 = [TBXML textForElement:Des1];
            lifeData.Des2 = [TBXML textForElement:Des2];
            lifeData.Des3 = [TBXML textForElement:Des3];
            lifeData.Des4 = [TBXML textForElement:Des4];
            lifeData.Des5 = [TBXML textForElement:Des5];
            lifeData.Des6 = [TBXML textForElement:Des6];
            lifeData.Des7 = [TBXML textForElement:Des7];
            lifeData.Des8 = [TBXML textForElement:Des8];
            [mutableArray addObject:lifeData];
            [lifeData release];
            
            info = [TBXML nextSiblingNamed:@"info" searchFromElement:info];
        }
    }
    
    return mutableArray;
    
}


@end
