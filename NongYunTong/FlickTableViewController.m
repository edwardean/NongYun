//
//  FlickTableViewController.m
//  FlickTabControl
//
//  Created by Shaun Harrison on 2/10/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import "FlickTableViewController.h"
#import "ADLivelyTableView.h"

@implementation FlickTableViewController
@synthesize tableView=_tableView, flickTabView=_flickTabView;
//ADLivelyTableView 在.h中定义 是一个文件在下面有它的.h .m  是制作动画效果的    这个类是用来支持首页上滑动8张图片的那个

//contentsize是scrollview可以滚动的区域，比如frame=(0,0,320,480) contentSize=(320,960),代表你的scrollview可以上下滚动，滚动的区域为frame大小的两倍
//contentOffset是scrollview当前显示区域顶点相对于frame顶点的偏移量，比如上个例子你拉到最下面，contentOffset就是(0,480),也就是y偏移了480
//contentInset是scrollerview的contentview的顶点相对于scrollerview的位置，例如你的contentInset=(0,100),那么你的contentview就是从scrollview的(0,100)开始显示
//pagingEnabled当值是YES,会自动滚动到subview的边界,默认是NO 控制控件是否整页翻动
- (void)loadView
{
	[super loadView];
	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
	
    
    self.tableView = [[ADLivelyTableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.initialCellTransformBlock = ADLivelyTransformHelix ; 
              //绕着y轴螺旋 在ADLivelyTableView.m中定义 initialCellTransformBlock ？？？？？？？？？？
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
	self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	
	[self.view addSubview:self.tableView];
	
	FlickTabView* aFlickTabView = [[FlickTabView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 43.0f)];
	self.flickTabView = aFlickTabView;
	[aFlickTabView release];
	
	self.flickTabView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
	self.flickTabView.delegate = self;
	self.flickTabView.dataSource = self;
	
	self.flickTabView.scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.flickTabView.frame.size.width, self.flickTabView.frame.size.height)] autorelease];
	self.flickTabView.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
	self.flickTabView.scrollView.directionalLockEnabled = YES;  //默认是NO，可以在垂直和水平方向同时运动，当值是YES，假如一开始是垂直或者是水平运动，那么接下来会锁定另外一个方向的滚动，假如一开始是对角方向滚动，则不会禁止某个方向
	self.flickTabView.scrollView.alwaysBounceVertical = NO;  //控制垂直方向遇到边框是否反弹
	self.flickTabView.scrollView.alwaysBounceHorizontal = YES;//控制水平方向遇到边框是否反弹
	self.flickTabView.scrollView.showsVerticalScrollIndicator = NO;//滚动时，是否显示垂直滚动条
	self.flickTabView.scrollView.showsHorizontalScrollIndicator = NO; //滚动时，是否显示水平滚动条
	self.flickTabView.scrollView.bounces = YES; //默认是yes,就是滚动超过边界，会反弹有反弹回来的效果，假如是NO，那么滚动到达边界，那么会连忙停止 bouncesZoom 和bounces类似，区别在于，这个效果反映在缩放上面，假如缩放超过最大缩放，那么会反弹效果，假如是NO，会立即停止
	self.flickTabView.scrollView.contentInset = UIEdgeInsetsMake(0.0f, 20.0f, 0.0f, 20.0f); // top left,bottom, right
	self.flickTabView.scrollView.delegate = self.flickTabView;
	
	self.flickTabView.backgroundColor = [UIColor colorWithHue:0.573816156f saturation:0.03f brightness:0.91f alpha:1.0f];
	
	UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.flickTabView.frame.size.width, self.flickTabView.frame.size.height)];
	imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
	imageView.image = [UIImage imageNamed:@"flick-tab-bck.png"];
	
	[self.flickTabView addSubview:imageView];
	[imageView release];
	
	[self.flickTabView addSubview:self.flickTabView.scrollView];
	
	UIImageView* leftCap = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 39.0f, 43.0f)];
	leftCap.image = [UIImage imageNamed:@"flick-fade-lt.png"];
	leftCap.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
	self.flickTabView.leftCap = leftCap;   //????????????????
	[leftCap release];
	
	UIImageView* rightCap = [[UIImageView alloc] initWithFrame:CGRectMake(self.flickTabView.frame.size.width-39.0f, 0.0f, 39.0f, 43.0f)];
	rightCap.image = [UIImage imageNamed:@"flick-fade-rt.png"];
	rightCap.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
	self.flickTabView.rightCap = rightCap;
	[rightCap release];
	
	[self.flickTabView addSubview:self.flickTabView.leftCap];
	[self.flickTabView addSubview:self.flickTabView.rightCap];
	
	[self.flickTabView awakeFromNib];  //?????????????????
	
	self.tableView.tableHeaderView = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 1.0f, 43.0f)] autorelease];             //??????????????????
	
	[self.view addSubview:self.flickTabView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if(scrollView == self.tableView) 
    {
		float y = (-scrollView.contentOffset.y); //上面解释的有
		float height = y > 0.0f ? 43.0f + y : 43.0f;
		y = y > 0.0f ? 0.0f : y;
		self.flickTabView.frame = CGRectMake(0.0f, y, self.tableView.frame.size.width, height);
		
		float inset = 0.0f;
		if(scrollView.contentOffset.y < 44.0f)
        {
			inset = 44.0f + -scrollView.contentOffset.y;
		}
		
		self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(inset, 0.0f, 0.0f, 0.0f); //设置滚动条的位置
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath //????????
{
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollTabView:(FlickTabView*)scrollTabView didSelectedTabAtIndex:(NSInteger)index {
	// Subclass
}

- (NSInteger)numberOfTabsInScrollTabView:(FlickTabView*)scrollTabView 
{
	return 0;
}

- (NSString*)scrollTabView:(FlickTabView*)scrollTabView titleForTabAtIndex:(NSInteger)index {
	return nil;
}


- (void)dealloc {
	self.flickTabView = nil;
	self.tableView = nil;
    [super dealloc];
}


@end

