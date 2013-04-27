//
//  PeopleXML.m
//  NongYunTong
//
//  Created by Edward on 12-5-17.
//  Copyright (c) 2012年 TuringTeam. All rights reserved.
//

#import "PeopleXML.h"
#import "TBXML.h"
#import "PeopleData.h"
@implementation PeopleXML
@synthesize mutArray;


-(void)XML:(NSString *)XmlFileName {
    
    mutArray = [[NSMutableArray alloc]init];
    NSString *path = [[NSBundle mainBundle] pathForResource:XmlFileName ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSString *string = [[NSString alloc] initWithData:data encoding:0x80000632];
    string = [string stringByReplacingOccurrencesOfString:@"encoding=\"gb2312\"" withString:@""];
    
    NSData *newData = [string dataUsingEncoding:NSUTF8StringEncoding];
    TBXML *tbXml = [TBXML tbxmlWithXMLData:newData];
    
    TBXMLElement * root = tbXml.rootXMLElement;
    
    if (root) {
        TBXMLElement *info = [TBXML childElementNamed:@"info" parentElement:root];
        while (info != nil) {
            PeopleData *peopleData = [[PeopleData alloc]init];
            
            TBXMLElement *t_no = [TBXML childElementNamed:@"t_no" parentElement:info];
            TBXMLElement *t_SpecialtiesCulture = [TBXML childElementNamed:@"t_SpecialtiesCulture" parentElement:info];
            TBXMLElement *t_Source = [TBXML childElementNamed:@"t_Source" parentElement:info];
            TBXMLElement *t_Image = [TBXML childElementNamed:@"t_Image" parentElement:info];
            
            peopleData.s_NO = [TBXML textForElement:t_no];
            peopleData.s_SpecialtiesCulture = [TBXML textForElement:t_SpecialtiesCulture];
            peopleData.s_Source = [TBXML textForElement:t_Source];
            peopleData.s_Image = [TBXML textForElement:t_Image];
                // NSLog(@"%@,%@,%@,%@",peopleData.s_NO,peopleData.s_SpecialtiesCulture,peopleData.s_Source, peopleData.s_Image);
            [mutArray addObject:peopleData];
            [peopleData release];
            
            info = [TBXML nextSiblingNamed:@"info" searchFromElement:info];
        }
    }
    
    
    
}

@end
