//
//  BlockBackground.m
//  arrived
//
//  Created by Gustavo Ambrozio on 29/11/11.
//  Copyright (c) 2011 N/A. All rights reserved.
//

#import "BlockBackground.h"

@implementation BlockBackground

@synthesize backgroundImage = _backgroundImage;
@synthesize vignetteBackground = _vignetteBackground;

static BlockBackground *_sharedInstance = nil;

+ (BlockBackground*)sharedInstance   //??????????????????
{
    if (_sharedInstance != nil)
    {
        return _sharedInstance;
    }

    @synchronized(self)
    {
        if (_sharedInstance == nil)
        {
            [[[self alloc] init] autorelease];
        }
    }

    return _sharedInstance;
}

+ (id)allocWithZone:(NSZone*)zone
{
    @synchronized(self) 
    {
        if (_sharedInstance == nil) 
        {
            _sharedInstance = [super allocWithZone:zone];
            return _sharedInstance;
        }
    }
    NSAssert(NO, @ "[BlockBackground alloc] explicitly called on singleton class."); //?????????
    return nil;
}

- (id)copyWithZone:(NSZone*)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (unsigned)retainCount
{
    return UINT_MAX;
}

- (oneway void)release
{
}

- (id)autorelease
{
    return self;
}

- (id)init
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self)
    {
        self.windowLevel = UIWindowLevelStatusBar;   //??????????????
        self.hidden = YES;   //如果没有这句话时 点击完选项后窗口不会下去就是被隐藏 再点击按钮时 cell对应的位置的选项被选中 重新上来一个sheet窗口并覆盖掉现在显示的窗口
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.5f];  //如果没有这句话时出现sheet时上面为黑屏 这句话是为了让cell依然能被人看见
        self.vignetteBackground = NO;
    }
    return self;
}

- (void)addToMainWindow:(UIView *)view
{
    if (self.hidden)
    {
        _previousKeyWindow = [[[UIApplication sharedApplication] keyWindow] retain];
        self.alpha = 0.0f;
        self.hidden = NO;   //如果这里为YES则sheet窗口不会出现
        self.userInteractionEnabled = YES;
        [self makeKeyWindow];
    }
    
    if (self.subviews.count > 0)
    {
        ((UIView*)[self.subviews lastObject]).userInteractionEnabled = NO;
    }
    
    if (_backgroundImage)
    {
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:_backgroundImage];
        backgroundView.frame = self.bounds;
        backgroundView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:backgroundView];
        [backgroundView release];
        [_backgroundImage release];
        _backgroundImage = nil;
    }
    
    [self addSubview:view];
}

- (void)reduceAlphaIfEmpty 
{
    if (self.subviews.count == 1 || (self.subviews.count == 2 && [[self.subviews objectAtIndex:0] isKindOfClass:[UIImageView class]]))
    {
        self.alpha = 0.0f;
        self.userInteractionEnabled = NO;
    }
}

- (void)removeView:(UIView *)view
{
    [view removeFromSuperview];  //如果删除掉的话第一次点击sheet后正常消失 但第二次时或多次时就出现异常

    UIView *topView = [self.subviews lastObject];
    if ([topView isKindOfClass:[UIImageView class]])  //？？？？？？？？？？？？？？？
    {
        // It's a background. Remove it too
        [topView removeFromSuperview];
    }
    
    if (self.subviews.count == 0)  //如果没有异常的情况下就执行这段话
    {
        self.hidden = YES;
        [_previousKeyWindow makeKeyWindow];
        [_previousKeyWindow release];
        _previousKeyWindow = nil;
    }
    else
    {
        ((UIView*)[self.subviews lastObject]).userInteractionEnabled = YES;
    }
}

- (void)drawRect:(CGRect)rect 
{    
    if (_backgroundImage || !_vignetteBackground) return;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
	size_t locationsCount = 2;
	CGFloat locations[2] = {0.0f, 1.0f};
	CGFloat colors[8] = {0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.75f}; 
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, locations, locationsCount);
	CGColorSpaceRelease(colorSpace);
	
	CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
	float radius = MIN(self.bounds.size.width , self.bounds.size.height) ;
	CGContextDrawRadialGradient (context, gradient, center, 0, center, radius, kCGGradientDrawsAfterEndLocation);
	CGGradientRelease(gradient);
}

@end
