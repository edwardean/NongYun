//
//  HomeViewController.m
//  NongYunTong
//
//  Created by Edward on 12-5-16.
//  Copyright (c) 2012年 TuringTeam. All rights reserved.
//

#import "HomeViewController.h"
#import "RaceCardViewController.h"
#import "RaceItemViewController.h"
#import "RacePlaceViewController.h"
#import "RaceVolunteerViewController.h"
#import <QuartzCore/QuartzCore.h>
#define kSCNavBarImageTag 10
@interface HomeViewController ()

@end

@implementation HomeViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        self.tabBarItem.title = @"农运首页";
        self.tabBarItem.image = [UIImage imageNamed:@"First.png"];
            // UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"12.png"]];
            //imageView.frame = CGRectMake(0, 0, 50, 50);
            //self.navigationItem.titleView = imageView;
        self.navigationItem.title = @"农运首页";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bac1.png"]];
//    
//    imageView.frame = CGRectMake(0, 130, 320, 300);
//    imageView.userInteractionEnabled = YES;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bac2.jpg"]];

    
    PagePhotosView *pagePhotosView = [[PagePhotosView alloc] initWithFrame: CGRectMake(0, 0,320,130) withDataSource: self];
    [self.view addSubview:pagePhotosView];
    [pagePhotosView release];
    UINavigationBar *navBar = self.navigationController.navigationBar;

    if ([navBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) 
        //使用5.0中新提供的UINavigationBar的方法setBackgroundImage:forBarMetrics:来设置背景。
    { 
        //if iOS 5.0 and later    
        [navBar setBackgroundImage:[UIImage imageNamed:@"navigationBarBackgroundRetro.png"] forBarMetrics:UIBarMetricsDefault];
    } 
    else 
    { 
        UIImageView *imageView = (UIImageView *)[navBar viewWithTag:kSCNavBarImageTag];
        if (imageView == nil) 
        { 
                imageView = [[UIImageView alloc] initWithImage: 
                                 [UIImage imageNamed:@"navigationBarBackgroundRetro.png"]];
                [imageView setTag:kSCNavBarImageTag]; 
                [navBar insertSubview:imageView atIndex:0];
                [imageView release]; 
        } 
    } 
    // Do any additional setup after loading the view from its nib.
}

    // 有多少页
    //
- (int)numberOfPages
{
	return 8;
}

    // 每页的图片
    //
- (UIImage *)imageAtIndex:(int)index 
{
	NSString *imageName = [NSString stringWithFormat:@"%d.jpg", index + 1];
	return [UIImage imageNamed:imageName];
}

-(IBAction)RaceCard:(id)sender  //实时赛程
{
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f; //间隔时间
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //动画开始与结束的快慢
    transition.type = @"cube";  //各种动画效果  立方体效果
    transition.subtype = kCATransitionFromRight;  //动画方向
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    RaceCardViewController *raceCardViewController = [[RaceCardViewController alloc]init];
    [self.navigationController pushViewController:raceCardViewController animated:YES];
    [raceCardViewController release];
}
-(IBAction)RaceItem:(id)sender  //比赛项目
{
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"cube";
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    RaceItemViewController *raceItemViewController = [[RaceItemViewController alloc]init];
    [self.navigationController pushViewController:raceItemViewController animated:YES];
    [raceItemViewController release];
}
-(IBAction)RaceVolunteer:(id)sender //志愿者
{
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"cube";
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    RaceVolunteerViewController *raceVolunteerViewController = [[RaceVolunteerViewController alloc]init];
    [self.navigationController pushViewController:raceVolunteerViewController animated:YES];
    [raceVolunteerViewController release];
}
-(IBAction)RacePlace:(id)sender   //比赛场地
{
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"cube";
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    RacePlaceViewController *racePlaceViewController = [[RacePlaceViewController alloc]init];
    [self.navigationController pushViewController:racePlaceViewController animated:YES];
    [racePlaceViewController release];
}





- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
