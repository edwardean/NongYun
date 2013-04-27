//
//  VolunteerXML.m
//  NongYunTong
//
//  Created by Edward on 12-5-18.
//  Copyright (c) 2012年 TuringTeam. All rights reserved.
//

#import "VolunteerXML.h"
#import "VolunteerData.h"
#import "TBXML.h"
@implementation VolunteerXML
@synthesize mutArray,volunteerData;

-(NSMutableArray *)XML {
    
    mutArray = [[NSMutableArray alloc]init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"volunteer" ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSString *string = [[NSString alloc] initWithData:data encoding:0x80000632]; 
    string = [string stringByReplacingOccurrencesOfString:@"encoding=\"gb2312\"" withString:@""];
    
    NSData *newData = [string dataUsingEncoding:NSUTF8StringEncoding];
    TBXML *tbXml = [TBXML tbxmlWithXMLData:newData];
    
    TBXMLElement * root = tbXml.rootXMLElement;
    
    if (root) {
        TBXMLElement *info = [TBXML childElementNamed:@"info" parentElement:root];
        while (info != nil) {
             volunteerData = [[VolunteerData alloc]init];
            
            TBXMLElement *name = [TBXML childElementNamed:@"name" parentElement:info];
            TBXMLElement *sex = [TBXML childElementNamed:@"sex" parentElement:info];
            TBXMLElement *speciality = [TBXML childElementNamed:@"speciality" parentElement:info];
            TBXMLElement *college = [TBXML childElementNamed:@"phone" parentElement:info];
            TBXMLElement *service_area = [TBXML childElementNamed:@"service_area" parentElement:info];
            volunteerData.name = [TBXML textForElement:name];
            volunteerData.sex = [TBXML textForElement:sex];
            volunteerData.speciality = [TBXML textForElement:speciality];
            volunteerData.college = [TBXML textForElement:college];
            volunteerData.service_area= [TBXML textForElement:service_area];
                // NSLog(@"%@,%@,%@,%@",peopleData.s_NO,peopleData.s_SpecialtiesCulture,peopleData.s_Source, peopleData.s_Image);
            [mutArray addObject:volunteerData];
            [volunteerData release];
            
            info = [TBXML nextSiblingNamed:@"info" searchFromElement:info];
        }
    }
    
    return mutArray;
    
}

@end
