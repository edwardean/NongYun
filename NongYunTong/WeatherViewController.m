//
//  WeatherViewController.m
//  NongYunTong
//
//  Created by Edward on 12-5-16.
//  Copyright (c) 2012年 TuringTeam. All rights reserved.
//

#import "WeatherViewController.h"
#import "SecondViewController.h"
#import <QuartzCore/QuartzCore.h>
#define kSCNavBarImageTag 10
@interface WeatherViewController ()

@end

@implementation WeatherViewController
@synthesize theWeather;
@synthesize scrollView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"本地天气";
        self.tabBarItem.image = [UIImage imageNamed:@"Fifth.png"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}




- (IBAction)refreshWeather:(id)sender
{
    [actView setColor:[UIColor brownColor]];
    [actView startAnimating];
    [theWeather updateWeather];
    [NSTimer scheduledTimerWithTimeInterval:4.0f target:self selector:@selector(timeValue) userInfo:self repeats:YES ];
}

-(IBAction)viewInfo:(id)sender{
    secondViewController = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil]; 
    CATransition *animation = [CATransition animation];
	animation.duration = 0.4f;
	animation.delegate = self;
	animation.timingFunction = UIViewAnimationCurveEaseInOut;
	animation.type = kCATransitionPush;
	animation.subtype = kCATransitionFromLeft;
	[[self.view layer] addAnimation:animation forKey:nil];
	[self.view addSubview:secondViewController.view];	

    
    [secondViewController getWeather];
}

-(IBAction)goback:(id)sender {
    [UIView beginAnimations:Nil context:NULL];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown /*UIViewAnimationTransitionFlipFromRight */forView:self.view cache:YES];
	[infoView removeFromSuperview];
	[UIView commitAnimations];
    
    
    
}
-(void)timeValue{
    [actView stopAnimating];
}

-(void)getWeatherFinish
{
	
	//NSLog(@"目前:%@",[theWeather current_Weatherdata]);
	//NSLog(@"今天:%@",[theWeather today_Weatherdata]);
	//NSLog(@"明天:%@",[theWeather tomorrow_Weatherdata]);
	//NSLog(@"日出日落:%@",[theWeather sunriseAndsunset]);
	//NSLog(@"所在位置:%@",[theWeather location_Data]);
	
	[tmpcurrentImage removeFromSuperview];
    [tmptodayImage removeFromSuperview];
    [tmptomorrowImage removeFromSuperview];
	[actView stopAnimating];
    city.text = [theWeather.location objectForKey:@"city"];
	
	NSDateFormatter *format = [[NSDateFormatter alloc]init];
	NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US_POSIX"];
	[format setLocale:locale];
	[locale release];
	[format setDateFormat:@"hh:mm a"];
	
	//取得日出日落
	NSDate *sunRise  = [format dateFromString:[theWeather.sunriseAndsunset objectForKey:@"sunrise"]];
	NSDate *sunSet	 = [format dateFromString:[theWeather.sunriseAndsunset objectForKey:@"sunset"]];
	
	
	[format setDateFormat:@"HH"];
	int sunrise = [[format stringFromDate:sunRise]intValue];
	int sunset = [[format stringFromDate:sunSet]intValue];
	int nowtime = [[format stringFromDate:[NSDate date]]intValue];
	[format release];
	
	//code for weather picture
	int code = [[theWeather.current_Weatherdata objectForKey:@"code"]intValue];
	int code2 = [[theWeather.today_Weatherdata objectForKey:@"code"]intValue];
	int code3 = [[theWeather.tomorrow_Weatherdata objectForKey:@"code"]intValue];
    
    
    NSString *_code = [theWeather.current_Weatherdata objectForKey:@"code"];
    NSString *_code2 = [theWeather.today_Weatherdata objectForKey:@"code"];
    NSString *_code3 = [theWeather.tomorrow_Weatherdata objectForKey:@"code"];
	NSString *stringcode = [_code stringByAppendingFormat:@"d.png"];
    NSString *stringcodenight = [_code stringByAppendingFormat:@"n.png"];
    NSString *stringcode2 = [_code2 stringByAppendingFormat:@"d.png"];
    NSString *stringcode3 = [_code3 stringByAppendingFormat:@"d.png"];
	
	
    switch(code){
        case 0:
            current_Text.text=@"龙卷风";
            break;
        case 1:
            current_Text.text=@"热带风暴";
            break;
        case 2:
            current_Text.text=@"飓风";
            break;
        case 3:
            current_Text.text=@"强雷暴";
            break;
        case 4:
            current_Text.text=@"雷暴";
            break;
        case 5:
            current_Text.text=@"雨夹雪";
            break;
        case 6:
            current_Text.text=@"雨冰雹";
            break;
        case 7:
            current_Text.text=@"雨雪";
            break;
        case 8:
            current_Text.text=@"冻小雨";
            break;
        case 9:
            current_Text.text=@"小雨";
            break;
        case 10:
            current_Text.text=@"冻雨";
            break;
        case 11:
            current_Text.text=@"阵雨";
            break;
        case 12:
            current_Text.text=@"阵雨";
            break;
        case 13:
            current_Text.text=@"阵雪";
            break;
        case 14:
            current_Text.text=@"小阵雪";
            break;
        case 15:
            current_Text.text=@"风雪";
            break;
        case 16:
            current_Text.text=@"雪";
            break;
        case 17:
            current_Text.text=@"冰雹";
            break;
        case 18:
            current_Text.text=@"雨雪";
            break;
        case 19:
            current_Text.text=@"灰尘";
            break;
        case 20:
            current_Text.text=@"多雾";
            break;
        case 21:
            current_Text.text=@"薄雾";
            break;
        case 22:
            current_Text.text=@"烟";
            break;
        case 23:
            current_Text.text=@"大风";
            break;
        case 24:
            current_Text.text=@"有风";
            break;
        case 25:
            current_Text.text=@"冷";
            break;
        case 26:
            current_Text.text=@"阴天";
            break;
        case 27:
            current_Text.text=@"多云(夜间)";
            break;
        case 28:
            current_Text.text=@"多云";
            break;
        case 29:
            current_Text.text=@"晴间多云(夜间)";
            break;
        case 30:
            current_Text.text=@"晴间多云";
            break;
        case 31:
            current_Text.text=@"晴天(晚上)";
            
            break;
        case 32:
            current_Text.text=@"晴天";
            break;
        case 33:
            current_Text.text=@"晴朗(夜间)";
            break;
        case 34:
            current_Text.text=@"晴朗";
            break;
        case 35:
            current_Text.text=@"混合雨和冰雹";
            break;
        case 36:
            current_Text.text=@"热";
            break;
        case 37:
            current_Text.text=@"局部雷暴";
            break;
        case 38:
            current_Text.text=@"零散雷雨";
            break;
        case 39:
            current_Text.text=@"零散雷雨";
            break;
        case 40:
            current_Text.text=@"零星阵雨";
            break;
        case 41:
            current_Text.text=@"大雪";
            break;
        case 42:
            current_Text.text=@"零星阵雪";
            break;
        case 43:
            current_Text.text=@"大雪";
            break;
        case 44:
            current_Text.text=@"晴间多云";
            break;
        case 45:
            current_Text.text=@"雷阵雨";
            break;
        case 46:
            current_Text.text=@"阵雪";
            break;
        case 47:
            current_Text.text=@"局部雷阵雨";
            break;
        case 3200:
            current_Text.text=@"暂无数据";
            break;
    }
    
    
    NSString *today_Text;			//今天天气描述
    switch(code2){
        case 0:
            today_Text=@"龙卷风";
            break;
        case 1:
            today_Text=@"热带风暴";
            break;
        case 2:
            today_Text=@"飓风";
            break;
        case 3:
            today_Text=@"强雷暴";
            break;
        case 4:
            today_Text=@"雷暴";
            break;
        case 5:
            today_Text=@"雨夹雪";
            break;
        case 6:
            today_Text=@"雨冰雹";
            break;
        case 7:
            today_Text=@"雨雪";
            break;
        case 8:
            today_Text=@"冻小雨";
            break;
        case 9:
            today_Text=@"小雨";
            break;
        case 10:
            today_Text=@"冻雨";
            break;
        case 11:
            today_Text=@"阵雨";
            break;
        case 12:
            today_Text=@"阵雨";
            break;
        case 13:
            today_Text=@"阵雪";
            break;
        case 14:
            today_Text=@"小阵雪";
            break;
        case 15:
            today_Text=@"风雪";
            break;
        case 16:
            today_Text=@"雪";
            break;
        case 17:
            today_Text=@"冰雹";
            break;
        case 18:
            today_Text=@"雨雪";
            break;
        case 19:
            today_Text=@"灰尘";
            break;
        case 20:
            today_Text=@"多雾";
            break;
        case 21:
            today_Text=@"薄雾";
            break;
        case 22:
            today_Text=@"烟";
            break;
        case 23:
            today_Text=@"大风";
            break;
        case 24:
            today_Text=@"有风";
            break;
        case 25:
            today_Text=@"冷";
            break;
        case 26:
            today_Text=@"阴天";
            break;
        case 27:
            today_Text=@"多云(夜间)";
            break;
        case 28:
            today_Text=@"多云";
            break;
        case 29:
            today_Text=@"晴间多云(夜间)";
            break;
        case 30:
            today_Text=@"晴间多云";
            break;
        case 31:
            today_Text=@"晴天(晚上)";
            
            break;
        case 32:
            today_Text=@"晴天";
            break;
        case 33:
            today_Text=@"晴朗(夜间)";
            break;
        case 34:
            today_Text=@"晴朗";
            break;
        case 35:
            today_Text=@"混合雨和冰雹";
            break;
        case 36:
            today_Text=@"热";
            break;
        case 37:
            today_Text=@"局部雷暴";
            break;
        case 38:
            today_Text=@"零散雷雨";
            break;
        case 39:
            today_Text=@"零散雷雨";
            break;
        case 40:
            today_Text=@"零星阵雨";
            break;
        case 41:
            today_Text=@"大雪";
            break;
        case 42:
            today_Text=@"零星阵雪";
            break;
        case 43:
            today_Text=@"大雪";
            break;
        case 44:
            today_Text=@"晴间多云";
            break;
        case 45:
            today_Text=@"雷阵雨";
            break;
        case 46:
            today_Text=@"阵雪";
            break;
        case 47:
            today_Text=@"局部雷阵雨";
            break;
        case 3200:
            today_Text=@"暂无数据";
            break;
    }
    
    
    
    NSString *tomay_Text;			////明天天气描述
    switch(code3){
        case 0:
            tomay_Text=@"龙卷风";
            break;
        case 1:
            tomay_Text=@"热带风暴";
            break;
        case 2:
            tomay_Text=@"飓风";
            break;
        case 3:
            tomay_Text=@"强雷暴";
            break;
        case 4:
            tomay_Text=@"雷暴";
            break;
        case 5:
            tomay_Text=@"雨夹雪";
            break;
        case 6:
            tomay_Text=@"雨冰雹";
            break;
        case 7:
            tomay_Text=@"雨雪";
            break;
        case 8:
            tomay_Text=@"冻小雨";
            break;
        case 9:
            tomay_Text=@"小雨";
            break;
        case 10:
            tomay_Text=@"冻雨";
            break;
        case 11:
            tomay_Text=@"阵雨";
            break;
        case 12:
            tomay_Text=@"阵雨";
            break;
        case 13:
            tomay_Text=@"阵雪";
            break;
        case 14:
            tomay_Text=@"小阵雪";
            break;
        case 15:
            tomay_Text=@"风雪";
            break;
        case 16:
            tomay_Text=@"雪";
            break;
        case 17:
            tomay_Text=@"冰雹";
            break;
        case 18:
            tomay_Text=@"雨雪";
            break;
        case 19:
            tomay_Text=@"灰尘";
            break;
        case 20:
            tomay_Text=@"多雾";
            break;
        case 21:
            tomay_Text=@"薄雾";
            break;
        case 22:
            tomay_Text=@"烟";
            break;
        case 23:
            tomay_Text=@"大风";
            break;
        case 24:
            tomay_Text=@"有风";
            break;
        case 25:
            tomay_Text=@"冷";
            break;
        case 26:
            tomay_Text=@"阴天";
            break;
        case 27:
            tomay_Text=@"多云(夜间)";
            break;
        case 28:
            tomay_Text=@"多云";
            break;
        case 29:
            tomay_Text=@"晴间多云(夜间)";
            break;
        case 30:
            tomay_Text=@"晴间多云";
            break;
        case 31:
            tomay_Text=@"晴天(晚上)";
            
            break;
        case 32:
            tomay_Text=@"晴天";
            break;
        case 33:
            tomay_Text=@"晴朗(夜间)";
            break;
        case 34:
            tomay_Text=@"晴朗";
            break;
        case 35:
            tomay_Text=@"混合雨和冰雹";
            break;
        case 36:
            tomay_Text=@"热";
            break;
        case 37:
            tomay_Text=@"局部雷暴";
            break;
        case 38:
            tomay_Text=@"零散雷雨";
            break;
        case 39:
            tomay_Text=@"零散雷雨";
            break;
        case 40:
            tomay_Text=@"零星阵雨";
            break;
        case 41:
            tomay_Text=@"大雪";
            break;
        case 42:
            tomay_Text=@"零星阵雪";
            break;
        case 43:
            tomay_Text=@"大雪";
            break;
        case 44:
            tomay_Text=@"晴间多云";
            break;
        case 45:
            tomay_Text=@"雷阵雨";
            break;
        case 46:
            tomay_Text=@"阵雪";
            break;
        case 47:
            tomay_Text=@"局部雷阵雨";
            break;
        case 3200:
            tomay_Text=@"暂无数据";
            break;
    }
    if(nowtime >= sunrise && nowtime <= sunset)
	{
		UIImage *image = [UIImage imageNamed:stringcode];
        
		[current_Image setImage:image];
		
	}
	else
	{
		UIImage *image = [UIImage imageNamed:stringcodenight];
        
		[current_Image setImage:image];
		
	}
    current_Temp.text = [NSString stringWithFormat:@"%@°",[theWeather.current_Weatherdata objectForKey:@"temp"]];
    sunup.text = [NSString stringWithFormat:@"日出:%@",[theWeather.sunriseAndsunset objectForKey:@"sunrise"]];
    sundown.text =[NSString stringWithFormat:@"日落:%@",[theWeather.sunriseAndsunset objectForKey:@"sunset"]];
    humidity.text = [NSString stringWithFormat:@"湿度:%@%%",[theWeather.atmosphere objectForKey:@"humidity"]];
    wind.text = [NSString stringWithFormat:@"风速:%@km/h",[theWeather.windCondition objectForKey:@"speed"]];
    
	
	
	
    UIImage *image2 = [UIImage imageNamed:stringcode2];
	[today_Image setImage:image2];
    
    
    
    
    
    
    NSString *today_date=[NSString stringWithFormat:@"%@",[theWeather.today_Weatherdata objectForKey:@"date"]];
    NSString *today_day = [NSString stringWithFormat:@"%@",[theWeather.today_Weatherdata objectForKey:@"day"]];
    
    NSRange range15  = NSMakeRange(0, 2);
    NSString *tmpString15 = [today_date substringWithRange:range15];
    NSString *string15 = [tmpString15 stringByAppendingFormat:@"号,"];
    
    
    if ([today_day isEqualToString:@"Mon"]) 
        today_day = @"星期一";
    else if([today_day isEqualToString:@"Tue"])
        today_day = @"星期二";
    else if([today_day isEqualToString:@"Wed"])
        today_day = @"星期三";
    else if ([today_day isEqualToString:@"Thu"])
        today_day = @"星期四";
    else if ([today_day isEqualToString:@"Fri"])
        today_day = @"星期五";
    else if ([today_day isEqualToString:@"Sat"])
        today_day = @"星期六";
    else if ([today_day isEqualToString:@"Sun"])
        today_day = @"星期日";
    
    
    NSRange rangeApr = NSMakeRange(3, 3);
    NSString *stringApr = [today_date substringWithRange:rangeApr];
    if([stringApr isEqualToString:@"Jan"])
        stringApr = @"一月";
    else if([stringApr isEqualToString:@"Feb"])
        stringApr = @"二月";
    else if([stringApr isEqualToString:@"Mar"])
        stringApr = @"三月";
    else if([stringApr isEqualToString:@"Apr"])
        stringApr = @"四月";
    else if([stringApr isEqualToString:@"May"])
        stringApr = @"五月";
    else if([stringApr isEqualToString:@"June"])
        stringApr = @"六月";
    else if([stringApr isEqualToString:@"July"])
        stringApr = @"七月";
    else if([stringApr isEqualToString:@"Aug"])
        stringApr = @"八月";
    else if([stringApr isEqualToString:@"Sept"])
        stringApr = @"九月";
    else if([stringApr isEqualToString:@"Oct"])
        stringApr = @"十月";
    else if([stringApr isEqualToString:@"Nov"])
        stringApr = @"十一月";
    else if([stringApr isEqualToString:@"Dec"])
        stringApr = @"十二月";
    NSString *apr15 = [stringApr stringByAppendingFormat:string15];
    NSString *apr15Sun  =[apr15 stringByAppendingFormat:today_day];
    NSLog(@"日期是:%@",apr15Sun);
    today_Date.text = apr15Sun;
    
    
    
    NSString *_today_Temp = [NSString stringWithFormat:@" %@°~%@°",[theWeather.today_Weatherdata objectForKey:@"high"],[theWeather.today_Weatherdata objectForKey:@"low"]];
	today_Temp.text = [today_Text stringByAppendingString:_today_Temp];
	
	
	
    
    
    
    
    
    
    
    
    
    
    
    
    
    UIImage *image3 = [UIImage imageNamed:stringcode3];
	[tomorrow_Image setImage:image3];
	NSString *_tomorrow_Temp = [NSString stringWithFormat:@" %@°~%@°",[theWeather.tomorrow_Weatherdata objectForKey:@"high"],[theWeather.tomorrow_Weatherdata objectForKey:@"low"]];
	tomorrow_Temp.text = [tomay_Text stringByAppendingString:_tomorrow_Temp];
	
    
    
    NSString *tom_date=[NSString stringWithFormat:@"%@",[theWeather.tomorrow_Weatherdata objectForKey:@"date"]];
    NSString *tom_day = [NSString stringWithFormat:@"%@",[theWeather.tomorrow_Weatherdata objectForKey:@"day"]];
    
    NSRange range16  = NSMakeRange(0, 2);
    NSString *tmpString16 = [tom_date substringWithRange:range16];
    NSString *string16 = [tmpString16 stringByAppendingFormat:@"号,"];
    
    
    if ([tom_day isEqualToString:@"Mon"]) 
        tom_day = @"星期一";
    else if([tom_day isEqualToString:@"Tue"])
        tom_day = @"星期二";
    else if([tom_day isEqualToString:@"Wed"])
        tom_day = @"星期三";
    else if ([tom_day isEqualToString:@"Thu"])
        tom_day = @"星期四";
    else if ([tom_day isEqualToString:@"Fri"])
        tom_day = @"星期五";
    else if ([tom_day isEqualToString:@"Sat"])
        tom_day = @"星期六";
    else if ([tom_day isEqualToString:@"Sun"])
        tom_day = @"星期日";
    
    
    
    NSRange tomrangeApr = NSMakeRange(3, 3);
    NSString *tomstringApr = [tom_date substringWithRange:tomrangeApr];
    if([tomstringApr isEqualToString:@"Jan"])
        tomstringApr = @"一月";
    else if([tomstringApr isEqualToString:@"Feb"])
        tomstringApr = @"二月";
    else if([tomstringApr isEqualToString:@"Mar"])
        tomstringApr = @"三月";
    else if([tomstringApr isEqualToString:@"Apr"])
        tomstringApr = @"四月";
    else if([tomstringApr isEqualToString:@"May"])
        tomstringApr = @"五月";
    else if([tomstringApr isEqualToString:@"June"])
        tomstringApr = @"六月";
    else if([tomstringApr isEqualToString:@"July"])
        tomstringApr = @"七月";
    else if([tomstringApr isEqualToString:@"Aug"])
        tomstringApr = @"八月";
    else if([tomstringApr isEqualToString:@"Sept"])
        tomstringApr = @"九月";
    else if([tomstringApr isEqualToString:@"Oct"])
        tomstringApr = @"十月";
    else if([tomstringApr isEqualToString:@"Nov"])
        tomstringApr = @"十一月";
    else if([tomstringApr isEqualToString:@"Dec"])
        tomstringApr = @"十二月";
    NSString *tomapr15 = [tomstringApr stringByAppendingFormat:string16];
    NSString *apr16Sun  =[tomapr15 stringByAppendingFormat:tom_day];
    NSLog(@"日期是:%@",apr16Sun);
    tomorrow_Date.text = apr16Sun;
    
    
    
    
    
    
    
    
    
    NSString *_freshDate = [theWeather.current_Weatherdata objectForKey:@"date"];
    
    
    NSRange range2  = NSMakeRange(5, 2);
    NSString *_sun15 = [_freshDate substringWithRange:range2];
    NSString *sun15 = [_sun15 stringByAppendingFormat:@"日"];
    NSRange range3 = NSMakeRange(8, 3);
    NSString *apr =[_freshDate substringWithRange:range3];
    if([apr isEqualToString:@"Jan"])
        apr = @"一月";
    else if([apr isEqualToString:@"Feb"])
        apr = @"二月";
    else if([apr isEqualToString:@"Mar"])
        apr = @"三月";
    else if([apr isEqualToString:@"Apr"])
        apr = @"四月";
    else if([apr isEqualToString:@"May"])
        apr = @"五月";
    else if([apr isEqualToString:@"June"])
        apr = @"六月";
    else if([apr isEqualToString:@"July"])
        apr = @"七月";
    else if([apr isEqualToString:@"Aug"])
        apr = @"八月";
    else if([apr isEqualToString:@"Sept"])
        apr = @"九月";
    else if([apr isEqualToString:@"Oct"])
        apr = @"十月";
    else if([apr isEqualToString:@"Nov"])
        apr = @"十一月";
    else if([apr isEqualToString:@"Dec"])
        apr = @"十二月";
    NSRange pm = NSMakeRange(17, 7);
    NSString *time = [_freshDate substringWithRange:pm];
    NSString *tmp1 = @"数据更新:";
   
    NSString *tmp2 = [[[tmp1 stringByAppendingFormat:@"%@",apr] stringByAppendingFormat:@"%@",sun15]  stringByAppendingFormat:@"%@",time];
    
    freshDate.text = tmp2;
    
    
}
-(void)getWeatherError
{
	//NSLog(@"错误!");
}



-(void)stopLoad{
    [refreshView stopLoading];
}
-(void)startLoading {
    [refreshView startLoading];
    [theWeather updateWeather];
    [self performSelector:@selector(stopLoad)
               withObject:nil afterDelay:3];
}

-(void)refresh{
    [self startLoading];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView_ {
    [refreshView scrollViewWillBeginDragging:scrollView_];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView_ {
    [refreshView scrollViewDidScroll:scrollView_];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView_ willDecelerate:(BOOL)decelerate{
    [refreshView scrollViewDidEndDragging:scrollView_ willDecelerate:decelerate];
    
}
#pragma mark - RefreshViewDelegate
- (void)refreshViewDidCallBack {
    [self refresh];
}





#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *nils = [[NSBundle mainBundle]loadNibNamed:@"RefreshView" owner:self options:nil]; 
    refreshView = [[nils objectAtIndex:0]retain]; 
    scrollView.contentSize = CGSizeMake(320, 460);
    scrollView.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);//将RefreshView嵌入到ScrollView中
    
    [refreshView setupWithOwner:scrollView delegate:self];
    [self refresh];
    
    
    WeatherObject *_theWeather = [[WeatherObject alloc]init];
	[_theWeather setDelegate:self];
	self.theWeather = _theWeather;
	[_theWeather release];
    
    
    UINavigationBar *nav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
	UIImage *img =[UIImage imageNamed:@"back.jpg"];
    [self SetNavBarBg:nav GetImg:img];
	UINavigationItem *NavTitle = [[UINavigationItem alloc] initWithTitle:@"本地天气"];
    [nav pushNavigationItem:NavTitle animated:YES];
    [self.view addSubview:nav];
	[NavTitle release];
	
	/*UIButton *infoBtn = [[[UIButton alloc] initWithFrame:CGRectMake(0.0, 110.0, 62.0, 29.0)] autorelease];
     [infoBtn setImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateNormal];
     [infoBtn addTarget:self action:@selector(refreshWeather:) forControlEvents:UIControlEventTouchUpInside];
     UIBarButtonItem *BackBarBtn = [[[UIBarButtonItem alloc] initWithCustomView:infoBtn] autorelease];
     nav.topItem.rightBarButtonItem = BackBarBtn;*/	
	//[infoBtn release];
	//[BackBarBtn release];
    
    
    
    
    
    
    UINavigationBar *infonav = [[[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] autorelease];
	UIImage *image =[UIImage imageNamed:@"back.jpg"];
	[self SetNavBarBg:infonav GetImg:image];
	UINavigationItem *navTitle = [[[UINavigationItem alloc] initWithTitle:@"简介"] autorelease];
	[infonav pushNavigationItem:navTitle animated:YES];
    
	UIButton *BackBtn = [[[UIButton alloc] initWithFrame:CGRectMake(0.0, 110.0, 62.0, 29.0)] autorelease];
	[BackBtn setImage:[UIImage imageNamed:@"backBar.png"] forState:UIControlStateNormal];
    [BackBtn addTarget:self action:@selector(goback:) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *BarBtn = [[[UIBarButtonItem alloc] initWithCustomView:BackBtn] autorelease];
	infonav.topItem.leftBarButtonItem = BarBtn;	
    [infoView addSubview:infonav];
	//[navTitle release];
    
	//[BackBtn release];
	//[BarBtn release];
    
    
    
    
    
    
    
    infoView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    infoTextView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
    UIImage *_Image = [UIImage imageNamed:@"44n.png"];
    current_Image = [[UIImageView alloc]initWithFrame:CGRectMake(80, 0, 250, 180)];
    current_Image.image = _Image;
    [scrollView addSubview:current_Image];
    
    
    today_Image  =[[UIImageView alloc]initWithFrame:CGRectMake(0, 180, 250, 180)];
    today_Image.image = _Image;
    [scrollView addSubview:today_Image];
    
    tomorrow_Image = [[UIImageView alloc]initWithFrame:CGRectMake(180, 165, 250, 180)];
    tomorrow_Image.image = _Image;
    [scrollView addSubview:tomorrow_Image];
    
    
    
    
    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
	[actView startAnimating];
	[theWeather updateWeather];
    

    
    if ([nav respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
        { 
                //if iOS 5.0 and later 
            [nav setBackgroundImage:[UIImage imageNamed:@"navigationBarBackgroundRetro.png"] forBarMetrics:UIBarMetricsDefault];
        } 
    else 
        { 
            UIImageView *imageView = (UIImageView *)[infonav viewWithTag:kSCNavBarImageTag];
            if (imageView == nil) 
                { 
                    imageView = [[UIImageView alloc] initWithImage: 
                                 [UIImage imageNamed:@"navigationBarBackgroundRetro.png"]];
                    [imageView setTag:kSCNavBarImageTag]; 
                    [nav insertSubview:imageView atIndex:0];
                    [imageView release]; 
                } 
        } 
    
	// Do any additional setup after loading the view, typically from a nib.
}


-(void)SetNavBarBg:(UINavigationBar *)_nav GetImg:(UIImage *)image {
    [_nav addSubview:[[UIImageView alloc]initWithImage:image]];
}

- (void)viewDidUnload
{
    current_Image = nil;
    today_Image = nil;
    tomorrow_Image = nil;
    city = nil;
    current_Temp = nil;
    sunup = nil;
    sundown = nil;
    humidity = nil;
    wind = nil;
    today_Date = nil;
    today_Temp = nil;
    tomorrow_Date = nil;
    tomorrow_Temp = nil;
    //nav = nil;
    actView = nil;
    refreshView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
-(void)dealloc
{
    
    [current_Image release];
    [today_Image release];
    [tomorrow_Image release];
    [city release];
    [current_Temp release];
    [sunup release];
    [sundown release];
    [humidity release];
    [wind release];
    [today_Date release];
    [today_Temp release];
    [tomorrow_Date release];
    [scrollView release];
    [refreshView release];
    [super dealloc];
    
}
@end
