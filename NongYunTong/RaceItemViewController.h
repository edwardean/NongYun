//
//  RaceItemViewController.h
//  NongYunTong
//
//  Created by Edward on 12-5-18.
//  Copyright (c) 2012年 TuringTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RaceItemSearchXML;
@interface RaceItemViewController : UITableViewController
@property (strong,nonatomic)RaceItemSearchXML *raceItemSearchXML;
@property(strong,nonatomic)NSMutableArray *mutableArray;
@property(strong,nonatomic)NSMutableArray *ItemData1;
@property(strong,nonatomic)NSMutableArray *ItemData2;
@property(strong,nonatomic)NSMutableArray *ItemData3;
@property(strong,nonatomic)NSMutableArray *GameDate;
@property(strong,nonatomic)NSMutableArray *GameProject;
@property(strong,nonatomic)NSMutableArray *GamePlace;

@end
