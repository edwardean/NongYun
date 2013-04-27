//
//  SecondViewController.m
//  nmnmkj
//
//  Created by 航 李 on 12-4-3.
//  Copyright (c) 2012年 南阳理工学院. All rights reserved.
//

#import "SecondViewController.h"
#import <QuartzCore/QuartzCore.h>
#define WEBURL @"http://www.webxml.com.cn/WebServices/WeatherWebService.asmx/getWeatherbyCityName?theCityName="
@implementation SecondViewController

@synthesize city;
@synthesize date;
@synthesize detail;
@synthesize image;
@synthesize Element;
@synthesize Elements;
@synthesize cityName;
@synthesize data;
@synthesize scoreView;
@synthesize searchbar;
@synthesize actity;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"生活提醒", @"生活提醒");
        self.tabBarController.view.backgroundColor = [UIColor redColor];
        self.tabBarItem.image = [UIImage imageNamed:@"forecast"];
    }
    return self;
}
-(IBAction)go_back:(id)sender{
    weatherViewController = [[WeatherViewController alloc] initWithNibName:@"WeatherViewController" bundle:nil];
    CATransition *animation = [CATransition animation];
	animation.duration = 0.4f;
	animation.delegate = self;
	animation.timingFunction =UIViewAnimationCurveEaseInOut;
	animation.type = kCATransitionPush;
	animation.subtype = kCATransitionFromRight;
	[[self.view layer] addAnimation:animation forKey:nil];
    [self.view removeFromSuperview];
   /* [UIView beginAnimations:Nil context:NULL];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
	//[infoView removeFromSuperview];*/
	//[self.view addSubview:weatherViewController.view];
	//[UIView commitAnimations];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}





-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
   [data setLength:0];
     
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)incomingData {
   
    [data appendData:incomingData];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data];
    [parser setDelegate:self];
    Elements = [NSMutableArray arrayWithCapacity:0];
    [parser parse];
    [parser release];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
   // NSLog(@"数据加载失败:%@",[error localizedDescription]);
   
}
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    Element = @"";
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    [Elements addObject:Element];
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    Element = [Element stringByAppendingString:string];
}
-(void)parserDidEndDocument:(NSXMLParser *)parser {
    
    city.text = [Elements objectAtIndex:1];
    date.text = [Elements objectAtIndex:6];
    NSString *imagePath = [[Elements objectAtIndex:9] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    UILabel *lable = [[UILabel alloc] init];
    lable.text= [[[[[Elements objectAtIndex:10]stringByAppendingString:@"\n"]stringByAppendingString:[Elements objectAtIndex:11]]stringByAppendingString:@"\n城市简介 :\n"]stringByAppendingString:[Elements objectAtIndex:22]];
    detail.text = @"";
    detail.text = lable.text;
    [lable release];
    
    
    
    CGRect rect = CGRectMake(235, 4,35, 35);
    image = [[UIImageView alloc]initWithFrame:rect];
    UIImage *image1 =[UIImage imageNamed:imagePath];
    [image setImage:image1];
    image.hidden=NO;
    [self.view addSubview:image];
    [image release];
    //NSLog(@"city:%@",city.text);
    //NSLog(@"date:%@",date.text);
    //NSLog(@"detail:%@",detail.text);
}




#pragma mark - View lifecycle

- (void)viewDidLoad
{
	
    self.cityName = @"南阳";
    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    CGRect rect = CGRectMake(0, 40, 320, 402);
    detail = [[UITextView alloc]initWithFrame:rect];
    detail.textColor = [UIColor blackColor];//设置textview里面的字体颜色  

    detail.font = [UIFont fontWithName:@"Arial" size:16.0];//设置字体名字和字体大小  
    
    detail.delegate = self;//设置它的委托方法  
     
    detail.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];//设置它的背景颜色
    
    detail.editable = NO; 
    detail.scrollEnabled = YES;//是否可以拖动  
    [detail isUserInteractionEnabled];
    
    [self.view addSubview:detail];
    [self performSelector:@selector(getWeatherInfo)];
   
    [super viewDidLoad];
	
}
-(void)getWeather {
    [self viewDidLoad];
}
-(void)getWeatherInfo
{
    
    NSString *urlString=[WEBURL stringByAppendingString:cityName];
   // NSLog(@"First url is:%@",urlString);
    NSURL  *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"The url is:%@",url);
    NSURLRequest *requst = [[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60.0] autorelease];
    data = [[NSMutableData data] retain];
    [NSURLConnection connectionWithRequest:requst delegate:self];
    
}









-(IBAction)searchCity:(id)sender {
    searchbar =[[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)]autorelease];
    searchbar.delegate = self;
    UIView *segment = [searchbar.subviews objectAtIndex:0];
    [segment removeFromSuperview];
    searchbar.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
    searchbar.showsCancelButton=NO;
    searchbar.barStyle=UIBarStyleDefault;
    searchbar.placeholder=@"输入城市名 如:南阳";
    searchbar.keyboardType=UIKeyboardTypeDefault;
    image.hidden=YES;
    [self.view addSubview:searchbar];
    
    
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
    
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    image.hidden=NO;
    searchBar.text=@"";
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    [searchBar removeFromSuperview];
    
}
-(void)stopactity{
    [actity stopAnimating];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    self.cityName = searchBar.text;
    [searchBar resignFirstResponder];
    [self  performSelector:@selector(getWeatherInfo)];
    [searchbar removeFromSuperview];
    [actity startAnimating];
    [self performSelector:@selector(stopactity)
     withObject:nil afterDelay:1.5];
    
}






- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.cityName = textField.text;
   // NSLog(@"%@",cityName);
    [self performSelector:@selector(getWeatherInfo)];
    [textField resignFirstResponder];
    [textField removeFromSuperview];
    return YES;
}








- (void)viewDidUnload
{
    city = nil;
    date = nil;
    detail = nil;
    image = nil;
    data = nil;
    cityName = nil;
    Element = nil;
    Elements = nil;
    actity = nil;
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
    [Element release];
    [Elements release];
    [city release];
    [detail release];
    [date release];
    [data release];
    [image release];
    [cityName release];
    [actity release];
    [super dealloc];
}
@end
