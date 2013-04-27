//
//  TopCultureViewController.h
//  NongYunTong
//
//  Created by Edward on 12-5-17.
//  Copyright (c) 2012年 南阳理工学院. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PeopleXML;
@interface TopCultureViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
}
@property (strong,nonatomic)UITableView *topTableView;
@property (strong,nonatomic)NSMutableArray *mutableArray;
@property (strong,nonatomic)PeopleXML *peopleXml;
@property (strong,nonatomic)NSMutableArray *XmlFileNameArray;
@end
