//
//  SecondViewController.h
//  nmnmkj
//
//  Created by 航 李 on 12-4-3.
//  Copyright (c) 2012年 南阳理工学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherViewController.h"
@class WeatherViewController;
@interface SecondViewController : UIViewController<NSXMLParserDelegate,UISearchBarDelegate,UITextViewDelegate>{
    WeatherViewController *weatherViewController;
    IBOutlet UILabel *city;
    IBOutlet UILabel *date;
    IBOutlet  UITextView *detail;
    IBOutlet UIScrollView *scoreView;
    IBOutlet UIView *infoView;
    UIActivityIndicatorView *actity;
    UISearchBar *searchbar;
    UIImageView *image;
    NSMutableData *data;
    NSString *cityName;
    NSString *Element;
    NSMutableArray *Elements;
}
@property (nonatomic, retain) IBOutlet UILabel *city;
@property (nonatomic, retain) IBOutlet UILabel *date;
@property (nonatomic, retain) IBOutlet UITextView *detail;
@property (nonatomic, retain) UIImageView *image;
@property (nonatomic, retain) IBOutlet UIScrollView *scoreView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *actity;
@property (nonatomic, retain) NSMutableArray *Elements;
@property (nonatomic, retain) NSString *Element;
@property (nonatomic, retain) UISearchBar *searchbar;
@property (nonatomic, retain) NSMutableData *data;
@property (nonatomic, retain) NSString *cityName;
-(IBAction)searchCity:(id)sender;
-(IBAction)go_back:(id)sender;
-(void)getWeather;
@end
