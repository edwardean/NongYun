//
//  DesLifeViewController.m
//  NongYunTong
//
//  Created by Edward on 12-5-22.
//  Copyright (c) 2012年 TuringTeam. All rights reserved.
//

#import "DesLifeViewController.h"
#import "LifeData.h"
@interface DesLifeViewController ()

@end

@implementation DesLifeViewController
@synthesize imageView,textView,lifeData,scrollView,label;
- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        label = [[UILabel alloc]initWithFrame:CGRectMake(0, 2, 320, 40)];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [UIFont fontWithName:@"STHeitiTC-Medium" size:20.0f];
        
        scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        CGSize newSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+100);
        [scrollView setContentSize:newSize];

        textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 210, 320, 480)];
        
        textView.font = [UIFont fontWithName:@"Arial" size:14.0f];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        textView.textColor = [UIColor blackColor];

        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, 15, 240, 200)];
        
        [self.view addSubview:scrollView];
        [scrollView addSubview:textView];
        [scrollView addSubview:imageView];
        [scrollView addSubview:label];

    }
    return self;
}


- (void)viewDidLoad
{
    // Do any additional setup after loading the view from its nib.
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
