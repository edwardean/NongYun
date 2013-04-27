//
//  TopCultureViewController.m
//  NongYunTong
//
//  Created by Edward on 12-5-17.
//  Copyright (c) 2012年 南阳理工学院. All rights reserved.
//

#import "TopCultureViewController.h"
#import "CultureViewController.h"
#import "PeopleXML.h"
#define kSCNavBarImageTag 10
@interface TopCultureViewController ()

@end

@implementation TopCultureViewController
@synthesize topTableView,mutableArray,peopleXml,XmlFileNameArray;
//

-(id) init{
    if (self = [super init]) {
        self.tabBarItem.title = @"南阳文化";
        self.navigationItem.title = @"南阳文化";
        self.tabBarItem.image = [UIImage imageNamed:@"Second.png"];
        XmlFileNameArray = [[NSMutableArray alloc]initWithObjects:@"people",@"te",@"wen",@"fe",@"other",nil];
        peopleXml = [[PeopleXML alloc]init];
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    topTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStyleGrouped];
    topTableView.delegate = self;
    topTableView.dataSource = self;
    [self.view addSubview:topTableView];
    mutableArray = [[NSMutableArray alloc]initWithObjects:@"历史人文",@"各种特产",@"文化精粹",@"名吃美食",@"其他", nil];
    UINavigationBar *navBar = self.navigationController.navigationBar;
    
    if ([navBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
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
    
	// Do any additional sup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated{
    [topTableView reloadData];
}

#pragma mark -
#pragma mark TableView methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [mutableArray count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"]autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    cell.textLabel.text = [mutableArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CultureViewController *cultureViewController = [[CultureViewController alloc]init];
    [peopleXml XML:[XmlFileNameArray objectAtIndex:indexPath.row]];
    [cultureViewController SetObject:peopleXml];
    [self.navigationController pushViewController:cultureViewController animated:YES];
    [cultureViewController release];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{	
    
    
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleDelete;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
