//
//  CultureViewController.h
//  NongYunTong
//
//  Created by Edward on 12-5-16.
//  Copyright (c) 2012年 南阳理工学院. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PeopleXML;
@class ADLivelyTableView;
@interface CultureViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
   
}
@property (strong,nonatomic) ADLivelyTableView *CultureTableView;
@property (strong,nonatomic) PeopleXML *peopleXml;
-(void)SetObject:(id)sender;
@end
