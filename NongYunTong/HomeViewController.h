//
//  HomeViewController.h
//  NongYunTong
//
//  Created by Edward on 12-5-16.
//  Copyright (c) 2012年 TuringTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PagePhotosDataSource.h"
#import "PagePhotosView.h"
@interface HomeViewController : UIViewController<PagePhotosDataSource>

-(IBAction)RaceCard:(id)sender;
-(IBAction)RaceItem:(id)sender;
-(IBAction)RaceVolunteer:(id)sender;
-(IBAction)RacePlace:(id)sender;

@end
