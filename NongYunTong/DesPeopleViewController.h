//
//  DesPeopleViewController.h
//  NongYunTong
//
//  Created by Edward on 12-5-17.
//  Copyright (c) 2012年 南阳理工学院. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PeopleData;
@interface DesPeopleViewController : UIViewController<UIScrollViewDelegate>
@property (strong,nonatomic)PeopleData *peopleData;
@property (strong,nonatomic)UIImageView *imageView;
@property (strong,nonatomic)UITextView *textView;
@property (strong,nonatomic)UIScrollView *scrollView;

@end
