//
//  RacePlaceViewController.h
//  NongYunTong
//
//  Created by Edward on 12-5-18.
//  Copyright (c) 2012年 TuringTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RacePlaceXML;
@interface RacePlaceViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView *raceTableView;
@property (strong,nonatomic)NSMutableArray *mutableArray;
@property (strong,nonatomic)RacePlaceXML *racePlaceXML;
@end
