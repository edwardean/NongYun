

#import <QuartzCore/QuartzCore.h>
#import "SplashViewController.h"
#import "AppDelegate.h"

@implementation SplashViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    // If you create your views manually, you MUST override this method and use it to create your views.
    // If you use Interface Builder to create your views, then you must NOT override this method.
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) //判断设备   UIView *_animationBookCoverView;
    {
        _animationBookCoverView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
    }
    else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {          
        if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation))
        {
            _animationBookCoverView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default-Landscape.png"]];            
        }
        else
        {
            _animationBookCoverView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default-Portrait.png"]];
        }
    }
    
    // Offset by the status bar on iPad. We don't on iPhone because splashscreens take up the full height.
    // No idea why Apple did this differently for iPhone and iPad.
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        _animationBookCoverView.frame = CGRectMake(0, 20,
                                                   _animationBookCoverView.frame.size.width,
                                                   _animationBookCoverView.frame.size.height);
    }
    
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    self.view.backgroundColor = [UIColor clearColor];
    _animationBookCoverView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_animationBookCoverView];
    
    // Credit to this smart cookie:
    // http://mo7amedfouad.com/2011/12/book-cover-flip-animation-like-in-path-app/
    
    _animationBookCoverView.layer.anchorPoint = CGPointMake(0.0, 0.5); //0,0表示左下角,1,1表示右上角，0.5,0.5表示图片的中心点. 所有的图片都是以矩形来界定的.
    //第一个0.0表示图片的最左端那条边如果是0.5的话表示的是图片的中间那条线1.0表示图片最右端的那条线  后面的0.5表示的是图片的中间的那个点在屏幕的中心位置 0.0表示图片的最上端的那条线在屏幕的中心位置 1.0表示图片的最下端的那个店在屏幕的中间位置  如果没有了这句代码只有下面的代码的话 中间的一条线在最左端 向左翻   但是如果没有下面的一句话光有这句话的话图片的左边线会在屏幕的中间中线在最右端  如果把上面的一句话去掉然后再去掉- _animationBookCoverView.bounds.size.width/2.0f 图片会以中间的线为基准来进行反转  如果只把- _animationBookCoverView.bounds.size.width/2.0f这一句话去掉 不去掉上面的一句话则图片的中线在屏幕的中间
   _animationBookCoverView.center = CGPointMake(_animationBookCoverView.center.x - _animationBookCoverView.bounds.size.width/2.0f, _animationBookCoverView.center.y);
    [UIView beginAnimations:@"openBook" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)]; //设置消息给动画代理当动画停止的时候
    [UIView setAnimationDuration:3.0];
    [UIView setAnimationDelay:0];
    CATransform3D _3Dt = CATransform3DIdentity;   //???????????????????????????
    _3Dt = CATransform3DMakeRotation(M_PI/2.0, 0.0f, -1.0f, 0.0f);
    _3Dt.m34 = 0.001f; // Perspective  ???????????????????????????  立体感
    /*iOS中的CALayer的3D本质上并不能算真正的3D(其视点即观察点或者所谓的照相机的位置是无法变换的),而只是3D在二维平面上的投影，投影平面就是手机屏幕也就是xy轴组成的平面(注意iOS中为左手坐标系)，那么视点的位置是如何确定的呢？可以通过CATransform3D中的m34来间接指定， m34 = -1/z,其中z为观察点在z轴上的值,而Layer的z轴的位置则是通过anchorPoint来指定的，所谓的anchorPoint(锚点)就是在变换中保持不变的点，也就是某个Layer在变换中的原点,xyz三轴相交于此点。在iOS中，Layer的anchorPoint使用unit coordinate space来描述，unit coordinate space无需指定具体真实的坐标点而是使用layer bounds中的相对位置，下图展示了一个Layer中的几个特殊的锚点, m34 = -1/z中，当z为正的时候，是我们人眼观察现实世界的效果，即在投影平面上表现出近大远小的效果，z越靠近原点则这种效果越明显，越远离原点则越来越不明显，当z为正无穷大的时候，则失去了近大远小的效果，此时投影线垂直于投影平面，也就是视点在无穷远处，CATransform3D中m34的默认值为0，即视点在无穷远处.*/

    _animationBookCoverView.layer.transform = _3Dt;
    [UIView commitAnimations];
    
    // Super hack. Adding a view to the window in Landscape on an iPad just doesn't work.
    // Used this guy's approach to manually rotate it:
    // http://stackoverflow.com/questions/1484799/only-first-uiview-added-view-addsubview-shows-correct-orientation/2694563#2694563
    // And then I learned that LandscapeLeft and PortraitUpsideDown need to be rotated an extra 180
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        CGAffineTransform rotate;

        if (self.interfaceOrientation == UIInterfaceOrientationLandscapeRight)
        {
            rotate = CGAffineTransformMakeRotation(M_PI/2.0);
        }
        else if (self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
        {
            rotate = CGAffineTransformMakeRotation(M_PI);
        }
        else if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        {
            rotate = CGAffineTransformMakeRotation(1.5 * M_PI);
        }
        else
        {
            // UIInterfaceOrientationPortrait - Only one that works without hacks
            return;
        }
        
        [self.view setTransform:rotate];
        self.view.frame = CGRectMake(0, 0, 1024, 768);
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag context:(void *)context  //??????????????????
{
    [self.view removeFromSuperview];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


@end
