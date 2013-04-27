//
//  PlaceInfoViewController.m
//  NongYunTong
//
//  Created by Edward on 12-5-19.
//  Copyright (c) 2012年 南阳理工学院. All rights reserved.
//

#import "PlaceInfoViewController.h"

@interface PlaceInfoViewController ()

@end

@implementation PlaceInfoViewController
@synthesize racePlaceData,textView,scrollView,imageView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    scrollView.pagingEnabled = YES;
        // scrollView.backgroundColor = [UIColor blueColor];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    CGSize newSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+200.0f);
    [scrollView setContentSize:newSize];
    [self.view addSubview:scrollView];
    textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 200, 320, 480)];
    textView.text = racePlaceData.pIntroduction;
    textView.editable = NO;
    [scrollView addSubview:textView];
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, 0, 240, 200)];
    imageView.image = [UIImage imageNamed:racePlaceData.pImage];
    [scrollView addSubview:imageView];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
