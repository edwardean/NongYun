//
//  RaceItemSearchXML.m
//  NongYunTong
//
//  Created by Edward on 12-5-19.
//  Copyright (c) 2012年 TuringTeam. All rights reserved.
//

#import "RaceItemSearchXML.h"
#import "RaceItemSearchData.h"
#import "TBXML.h"
@implementation RaceItemSearchXML
@synthesize itemArray,raceItemSearchData;

-(NSMutableArray *)XML:(NSString *)itemXML {
    
    itemArray = [[NSMutableArray alloc]init];
    NSString *path = [[NSBundle mainBundle] pathForResource:itemXML ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSString *string = [[NSString alloc] initWithData:data encoding:0x80000632];
    string = [string stringByReplacingOccurrencesOfString:@"encoding=\"gb2312\"" withString:@""];
    
    NSData *newData = [string dataUsingEncoding:NSUTF8StringEncoding];
    TBXML *tbXml = [TBXML tbxmlWithXMLData:newData];
    
    TBXMLElement * root = tbXml.rootXMLElement;
    
    if (root) {
        TBXMLElement *info = [TBXML childElementNamed:@"gameInfo" parentElement:root];
        while (info != nil) {
            raceItemSearchData = [[RaceItemSearchData alloc]init];
            
            TBXMLElement *gamePlace = [TBXML childElementNamed:@"game_place" parentElement:info];
            TBXMLElement *gameProject = [TBXML childElementNamed:@"game_project" parentElement:info];
            TBXMLElement *gameTime = [TBXML childElementNamed:@"game_time" parentElement:info];
            TBXMLElement *gameDate = [TBXML childElementNamed:@"game_date" parentElement:info];
            TBXMLElement *gameKind = [TBXML childElementNamed:@"game_kind" parentElement:info];
            raceItemSearchData.gamePlace = [TBXML textForElement:gamePlace];
            raceItemSearchData.gameProject = [TBXML textForElement:gameProject];
            raceItemSearchData.gameTime = [TBXML textForElement:gameTime];
            raceItemSearchData.gameDate = [TBXML textForElement:gameDate];
            raceItemSearchData.gameKind= [TBXML textForElement:gameKind];
            [itemArray addObject:raceItemSearchData];
            [raceItemSearchData release];
            
            info = [TBXML nextSiblingNamed:@"gameInfo" searchFromElement:info];
        }
    }
    
    return itemArray;
    
}

@end
