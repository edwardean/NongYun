//
//  WeatherViewController.h
//  NongYunTong
//
//  Created by Edward on 12-5-16.
//  Copyright (c) 2012年 南阳理工学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherObject.h"
#import "RefreshView.h"
#import "SecondViewController.h"
@class SecondViewController;
@interface WeatherViewController : UIViewController<WeatherDelegate,UINavigationControllerDelegate,RefreshViewDelegate>{
    WeatherObject *theWeather;
	SecondViewController *secondViewController;
    RefreshView *refreshView;
    UIScrollView *scrollView;
    
    
	UIImageView *current_Image;	
	UIImageView *today_Image;		
	UIImageView *tomorrow_Image;
    
    IBOutlet UIView *infoView;
    IBOutlet UITextView *infoTextView;
    IBOutlet UIToolbar *infoToolBar;
    
    
	
    IBOutlet UILabel *city;
    IBOutlet UILabel *current_Temp;			//目前温度
	IBOutlet UILabel *current_Text;			//目前天气
    IBOutlet UILabel *sunup;
    IBOutlet UILabel *sundown;
    IBOutlet UILabel *humidity;
    IBOutlet UILabel *wind;
    IBOutlet UIImageView *tmpcurrentImage;
	
	IBOutlet UILabel *today_Date;			//今天日期
	IBOutlet UILabel *today_Temp;			//今天天气
	
    IBOutlet UIImageView *tmptodayImage;
	
	IBOutlet UILabel *tomorrow_Date;		//明天日期
	IBOutlet UILabel *tomorrow_Temp;		//明天天氣
    IBOutlet UIImageView *tmptomorrowImage;
	
	IBOutlet UIActivityIndicatorView *actView; 
    IBOutlet UILabel *freshDate;
}
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic, retain)WeatherObject *theWeather;
-(void)SetNavBarBg:(UINavigationBar *)nav GetImg:(UIImage *)image;


- (IBAction)refreshWeather:(id)sender;		//更新
- (IBAction)viewInfo:(id)sender;
-(IBAction)goback:(id)sender;
@end
