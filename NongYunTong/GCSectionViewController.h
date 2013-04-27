//
//  GCSectionViewController.h
//  NongYunTong
//
//  Created by Edward on 12-5-18.
//  Copyright (c) 2012年 TuringTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCRetractableSectionController.h"
@interface GCSectionViewController : GCRetractableSectionController
@property (nonatomic, copy, readwrite) NSString* title;
@property (strong, nonatomic) NSMutableArray* desArray;
@end
