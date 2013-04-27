//
//  DesPeopleViewController.m
//  NongYunTong
//
//  Created by Edward on 12-5-17.
//  Copyright (c) 2012年 南阳理工学院. All rights reserved.
//

#import "DesPeopleViewController.h"
#import "PeopleData.h"

@interface DesPeopleViewController ()

@end

@implementation DesPeopleViewController

@synthesize imageView,textView,scrollView,peopleData;

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    CGSize newSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+100);
    [scrollView setContentSize:newSize];
    [self.view addSubview:scrollView];
    textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 240, 320, 480)];
    textView.text = peopleData.s_Source;
    [scrollView addSubview:textView];
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, 20, 240, 200)];
    imageView.image = [UIImage imageNamed:peopleData.s_Image];
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
