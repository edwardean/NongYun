//
//  GCSearchItemViewController.h
//  NongYunTong
//
//  Created by Edward on 12-5-19.
//  Copyright (c) 2012年 南阳理工学院. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCSearchSectionController.h"
@interface GCSearchItemViewController : GCSearchSectionController
@property (strong,nonatomic) NSArray *searchItem;
@property (nonatomic, copy, readwrite) NSString* title;
@property (strong,nonatomic)NSMutableArray *itemgame;
@end
