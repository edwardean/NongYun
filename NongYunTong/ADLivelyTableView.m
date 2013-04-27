//
//  ADLivelyTableView.m
//  ADLivelyTableView
//
//  Created by Romain Goyet on 18/04/12.
//  Copyright (c) 2012 Applidium. All rights reserved.
//

#import "ADLivelyTableView.h"
#import <QuartzCore/QuartzCore.h>

NSTimeInterval ADLivelyDefaultDuration = 0.2;  //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型

CGFloat CGFloatSign(CGFloat value) 
{
    if (value < 0) 
    {
        return -1.0f;
    }
    return 1.0f;
}

ADLivelyTransform ADLivelyTransformCurl = ^(CALayer * layer, float speed)  //卷曲 旋度
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0 / -500;       //m34 一定要写在CATransform3DRotate 前面
    transform = CATransform3DTranslate(transform, -layer.bounds.size.width/2.0f, 0.0f, 0.0f);   //平移
    transform = CATransform3DRotate(transform, M_PI/2, 0.0f, 1.0f, 0.0f); 
                                     //针对X轴旋转，就是1，0，0，针对Y轴旋转就是0，1，0 旋转
    layer.transform = CATransform3DTranslate(transform, layer.bounds.size.width/2.0f, 0.0f, 0.0f); 
                                     //CATransform3D 和上面定义的意识tongige变量
    return ADLivelyDefaultDuration;
};

ADLivelyTransform ADLivelyTransformFade = ^(CALayer * layer, float speed)  //消退
{
    if (speed != 0.0f)
    { // Don't animate the initial state
        layer.opacity = 1.0f - fabs(speed);  //fabs绝对值 opacity不透明
    }
    return 2 * ADLivelyDefaultDuration;
};

ADLivelyTransform ADLivelyTransformFan = ^(CALayer * layer, float speed)
{
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, -layer.bounds.size.width/2.0f, 0.0f, 0.0f);
    transform = CATransform3DRotate(transform, -M_PI/2 * speed, 0.0f, 0.0f, 1.0f);
    layer.transform = CATransform3DTranslate(transform, layer.bounds.size.width/2.0f, 0.0f, 0.0f);
    layer.opacity = 1.0f - fabs(speed);
    return ADLivelyDefaultDuration;
};

ADLivelyTransform ADLivelyTransformFlip = ^(CALayer * layer, float speed)  //翻转变换
{
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0.0f, CGFloatSign(speed) * layer.bounds.size.height/2.0f, 0.0f);
    transform = CATransform3DRotate(transform, CGFloatSign(speed) * M_PI/2, 1.0f, 0.0f, 0.0f);
    layer.transform = CATransform3DTranslate(transform, 0.0f, -CGFloatSign(speed) * layer.bounds.size.height/2.0f, 0.0f);
    layer.opacity = 1.0f - fabs(speed);
    return 2 * ADLivelyDefaultDuration;
};

ADLivelyTransform ADLivelyTransformHelix = ^(CALayer * layer, float speed)  //螺旋
{
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0.0f, CGFloatSign(speed) * layer.bounds.size.height/2.0f, 0.0f);
    transform = CATransform3DRotate(transform, M_PI, 0.0f, 1.0f, 0.0f);
    layer.transform = CATransform3DTranslate(transform, 0.0f, -CGFloatSign(speed) * layer.bounds.size.height/2.0f, 0.0f);
    layer.opacity = 1.0f - 0.2*fabs(speed);
    return 2 * ADLivelyDefaultDuration;
};
 
ADLivelyTransform ADLivelyTransformTilt = ^(CALayer * layer, float speed)  //倾斜
{
    if (speed != 0.0f)
    { // Don't animate the initial state
        layer.transform = CATransform3DMakeScale(0.8f, 0.8f, 0.8f);
        layer.opacity = 1.0f - fabs(speed);
    }
    return 2 * ADLivelyDefaultDuration;
};

ADLivelyTransform ADLivelyTransformWave = ^(CALayer * layer, float speed)  //波动
{
    if (speed != 0.0f) 
    { // Don't animate the initial state
        layer.transform = CATransform3DMakeTranslation(-layer.bounds.size.width/2.0f, 0.0f, 0.0f);
    }
    return ADLivelyDefaultDuration;
};

@implementation ADLivelyTableView
#pragma mark - NSObject
- (void)dealloc 
{
    Block_release(_transformBlock);
    [super dealloc];
}

#pragma mark - UIView
+ (Class)layerClass 
{
    // This lets us rotate cells in the tableview's 3D space
    return [CATransformLayer class];
}

#pragma mark - UITableView
- (void)setDelegate:(id<UITableViewDelegate>)delegate 
{
    // The order here is important, as there seem to be some observing done on setDelegate:
    if (delegate == self) 
    {
        _preLivelyDelegate = nil;
    } 
    else 
    {
        _preLivelyDelegate = delegate;
    }
    [super setDelegate:self];
}

- (BOOL)respondsToSelector:(SEL)aSelector 
{
    return [super respondsToSelector:aSelector] || [_preLivelyDelegate respondsToSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([_preLivelyDelegate respondsToSelector:[anInvocation selector]]) 
    {
        [anInvocation invokeWithTarget:_preLivelyDelegate];  
        //激活anInvocation中的消息，但是消息的响应者是_preLivelyDelegate，而不是默认的self。
    } 
    else 
    {
        [super forwardInvocation:anInvocation];
    }
}

#pragma mark - ADLivelyTableView
- (CGPoint)scrollSpeed 
{
    return CGPointMake(_lastScrollPosition.x - _currentScrollPosition.x,
                       _lastScrollPosition.y - _currentScrollPosition.y);
}

- (void)setInitialCellTransformBlock:(ADLivelyTransform)block 
{
    CATransform3D transform = CATransform3DIdentity;
    if (block != nil) 
    {
        transform.m34 = -1.0/self.bounds.size.width;   //？？？？？？？？？
    }
    self.layer.transform = transform;

    if (block != _transformBlock) 
    {
        Block_release(_transformBlock);
        _transformBlock = Block_copy(block);
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView 
{
    if ([_preLivelyDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) 
    {
        [_preLivelyDelegate scrollViewDidScroll:scrollView];  //拖动
    }
    _lastScrollPosition = _currentScrollPosition;
    _currentScrollPosition = [scrollView contentOffset];
    /*contentOffset是scrollview当前显示区域顶点相对于frame顶点的偏移量，比如上个例子你拉到最下面，contentoffset就是(0 ,480)，也就是y偏移了480,contentInset是scrollview的contentview的顶点相对于scrollview的位置，例如你的contentInset = (0 ,100)，那么你的contentview就是从scrollview的(0 ,100)开始显示*/
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if ([_preLivelyDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)])
    {
        [_preLivelyDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }

    float speed = self.scrollSpeed.y;
    float normalizedSpeed = MAX(-1.0f, MIN(1.0f, speed/20.0f));

    dispatch_async(dispatch_get_main_queue(), ^{
        if (_transformBlock) 
        {
            NSTimeInterval animationDuration = _transformBlock(cell.layer, normalizedSpeed);
            // The block-based equivalent doesn't play well with iOS 4
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:animationDuration];
        }
        cell.layer.transform = CATransform3DIdentity;
        cell.layer.opacity = 1.0f;
        if (_transformBlock) 
        {
            [UIView commitAnimations];
        }
    });
}
@end
