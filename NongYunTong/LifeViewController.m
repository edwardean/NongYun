//
//  LifeViewController.m
//  NongYunTong
//
//  Created by Edward on 12-5-16.
//  Copyright (c) 2012年 TuringTeam. All rights reserved.
//

#import "LifeViewController.h"
#import "DesLifeViewController.h"
#import "BlockActionSheet.h"
#import "LifeData.h"
#import "LifeXML.h"
#import "TravelCell.h"
#import "TrainsCell.h"
#import "AirCell.h"
#import "BusCell.h"
#define kSCNavBarImageTag 10
@interface LifeViewController ()

@end

@implementation LifeViewController
@synthesize lifeXML,mutableArray1,mutableArray2,mutableArray3,mutableArray4,mutableArray5,mutableArray6,mutableArray7,mutableArray8;

-(id) init{
    if (self = [super init]) {
        self.tabBarItem.title = @"便利向导";
        self.tabBarItem.image = [UIImage imageNamed:@"Fourth.png"];
        self.navigationItem.title = @"便利向导";
    }
    return self;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    lifeXML = [[LifeXML alloc]init];
    mutableArray1 = [lifeXML XML:@"scenery"];
    mutableArray2 = [lifeXML XML:@"clothesing"];
    mutableArray3 = [lifeXML XML:@"winshop"];

    mutableArray5 = [lifeXML XML:@"hotel"];
    mutableArray6 = [lifeXML XML:@"Trains"];
    mutableArray7 = [lifeXML XML:@"bus"];
    mutableArray8 = [lifeXML XML:@"air"];
	self.title = @"便利向导";
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
    // Do any additional setup after loading the view from its nib.
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


    // Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.flickTabView.selectedTabIndex == 0) {
        return [mutableArray1 count];
    }
    else if (self.flickTabView.selectedTabIndex == 1) {
        return [mutableArray2 count];
    }
    else if (self.flickTabView.selectedTabIndex == 2) {
        return [mutableArray3 count];
    }
    else if (self.flickTabView.selectedTabIndex == 3) {
       return [mutableArray5 count];
    }
    else if (self.flickTabView.selectedTabIndex == 4) {
        return [mutableArray6 count];
    }
    else if (self.flickTabView.selectedTabIndex == 5) {
        return [mutableArray7 count];
    }
    else if (self.flickTabView.selectedTabIndex == 6) {
        return [mutableArray8 count];
    }

}


    // Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.flickTabView.selectedTabIndex == 0) {
        
        TravelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TravelCell"];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"TravelCell" owner:self options:nil];  
            cell = [array objectAtIndex:0]; 
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            UIView * backgroundView = [[UIView alloc] initWithFrame:cell.bounds];
            cell.backgroundView = backgroundView;
            [backgroundView release];
        }
        
        LifeData *data = [mutableArray1 objectAtIndex:indexPath.row];
        cell.CellImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",data.Des3]];
        NSLog(@"%@",data.Des3);
        cell.CellLabel.text = data.Des2;
        cell.CellLabelDes.text = data.Des4;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    else if (self.flickTabView.selectedTabIndex == 1) {
        
        TravelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TravelCell"];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"TravelCell" owner:self options:nil];  
            cell = [array objectAtIndex:0]; 
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            UIView * backgroundView = [[UIView alloc] initWithFrame:cell.bounds];
            cell.backgroundView = backgroundView;
            [backgroundView release];
        }
        
        LifeData *data = [mutableArray2 objectAtIndex:indexPath.row];
        cell.CellImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",data.Des5]];
        cell.CellLabel.text = data.Des1;
        cell.CellLabelDes.text = data.Des3;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    else if (self.flickTabView.selectedTabIndex == 2) {
        
        TravelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TravelCell"];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"TravelCell" owner:self options:nil];  
            cell = [array objectAtIndex:0]; 
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            UIView * backgroundView = [[UIView alloc] initWithFrame:cell.bounds];
            cell.backgroundView = backgroundView;
            [backgroundView release];
        }
        
        LifeData *data = [mutableArray3 objectAtIndex:indexPath.row];
        cell.CellImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",data.Des7]];
        cell.CellLabel.text = data.Des1;
        cell.CellLabelDes.text = data.Des5;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    else if (self.flickTabView.selectedTabIndex == 3) {
        
        TravelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TravelCell"];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"TravelCell" owner:self options:nil];  
            cell = [array objectAtIndex:0]; 
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            UIView * backgroundView = [[UIView alloc] initWithFrame:cell.bounds];
            cell.backgroundView = backgroundView;
            [backgroundView release];
        }
        
        LifeData *data = [mutableArray5 objectAtIndex:indexPath.row];
        cell.CellImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",data.Des7]];
        cell.CellLabel.text = data.Des1;
        cell.CellLabelDes.text = data.Des5;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    else if (self.flickTabView.selectedTabIndex == 4) {
        
        TrainsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrainsCell"];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"TrainsCell" owner:self options:nil];  
            cell = [array objectAtIndex:0]; 
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            UIView * backgroundView = [[UIView alloc] initWithFrame:cell.bounds];
            cell.backgroundView = backgroundView;
            [backgroundView release];
        }
        LifeData *data = [mutableArray6 objectAtIndex:indexPath.row];
        cell.label1.text = data.Des1;
        cell.label2.text = data.Des2;
        cell.label3.text = data.Des3;
        cell.label4.text = data.Des8;
        cell.label5.text = data.Des4;
        cell.label6.text = data.Des5;
        cell.CellImage.image = [UIImage imageNamed:@"huoche.png"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
       
    }
    else if (self.flickTabView.selectedTabIndex == 5) {
        
        BusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusCell"];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"BusCell" owner:self options:nil];  
            cell = [array objectAtIndex:0]; 
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            UIView * backgroundView = [[UIView alloc] initWithFrame:cell.bounds];
            cell.backgroundView = backgroundView;
            [backgroundView release];
        }
        LifeData *data = [mutableArray7 objectAtIndex:indexPath.row];
        cell.label1.text = data.Des2;
        cell.label2.text = data.Des4;
        cell.label3.text = data.Des7;
        cell.imageView.image = [UIImage imageNamed:@"Bus.jpg"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
        
    }
    else if (self.flickTabView.selectedTabIndex == 6) {
        
        AirCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AirCell"];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"AirCell" owner:self options:nil];  
            cell = [array objectAtIndex:0]; 
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            UIView * backgroundView = [[UIView alloc] initWithFrame:cell.bounds];
            cell.backgroundView = backgroundView;
            [backgroundView release];
        }
        LifeData *data = [mutableArray8 objectAtIndex:indexPath.row];
        cell.label1.text = data.Des1;
        cell.label2.text = data.Des2;
        cell.label3.text = data.Des4;
        cell.label4.text = data.Des7;
        cell.label5.text = data.Des8;
        cell.label6.text = data.Des5;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.flickTabView.selectedTabIndex == 0) {
        LifeData *data = [mutableArray1 objectAtIndex:indexPath.row];
        BlockActionSheet *sheet = [BlockActionSheet sheetWithTitle:[NSString stringWithFormat:@"%@欢迎您,如需购票，您可以通过如下方式预定景点门票,门票价格:%@元",data.Des2,data.Des5]];
        [sheet setCancelButtonWithTitle:@"返回" block:nil];
        [sheet setDestructiveButtonWithTitle:@"通过南阳旅游网预定门票" block:^{
            NSString *num = [[NSString alloc] initWithFormat:@"www.110.com",data.Des6];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
        }];
        [sheet addButtonWithTitle:@"查看此景点详细信息" block:^{
            DesLifeViewController *desLifeViewController = [[DesLifeViewController alloc]init];
            desLifeViewController.label.text = data.Des2;
            desLifeViewController.textView.text = data.Des4;
            desLifeViewController.imageView.image = [UIImage imageNamed:data.Des3];
            [self.navigationController pushViewController:desLifeViewController animated:YES];
        }];
        [sheet showInView:self.tableView];
    }
    else if (self.flickTabView.selectedTabIndex == 1) {
        LifeData *data = [mutableArray2 objectAtIndex:indexPath.row];
        BlockActionSheet *sheet = [BlockActionSheet sheetWithTitle:[NSString stringWithFormat:@"%@欢迎您,商场位于%@",data.Des1,data.Des2]];
        [sheet setCancelButtonWithTitle:@"返回" block:nil];
        [sheet setDestructiveButtonWithTitle:@"查看商场详细介绍" block:^{
            DesLifeViewController *desLifeViewController = [[DesLifeViewController alloc]init];
            desLifeViewController.label.text = data.Des1;
            desLifeViewController.textView.text = data.Des3;
            desLifeViewController.imageView.image = [UIImage imageNamed:data.Des5];
            [self.navigationController pushViewController:desLifeViewController animated:YES];
        }];
        
        [sheet showInView:self.tableView];
    }
    else if (self.flickTabView.selectedTabIndex == 2) {
        LifeData *data = [mutableArray3 objectAtIndex:indexPath.row];
        BlockActionSheet *sheet = [BlockActionSheet sheetWithTitle:[NSString stringWithFormat:@"%@欢迎您,酒店位于%@,星级:%@",data.Des1,data.Des2,data.Des3]];
        [sheet setCancelButtonWithTitle:@"返回" block:nil];
        [sheet setDestructiveButtonWithTitle:@"拨打酒店订餐电话" block:^{
            NSString *num = [[NSString alloc] initWithFormat:@"tel://4006011604",data.Des4];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
        }];
        [sheet addButtonWithTitle:@"查看酒店详细信息" block:^{
            DesLifeViewController *desLifeViewController = [[DesLifeViewController alloc]init];
            desLifeViewController.label.text = data.Des1;
            desLifeViewController.textView.text = data.Des5;
            desLifeViewController.imageView.image = [UIImage imageNamed:data.Des7];
            [self.navigationController pushViewController:desLifeViewController animated:YES];
        }];
        [sheet showInView:self.tableView];

    }
    else if (self.flickTabView.selectedTabIndex == 3) {
        LifeData *data = [mutableArray5 objectAtIndex:indexPath.row];
        BlockActionSheet *sheet = [BlockActionSheet sheetWithTitle:[NSString stringWithFormat:@"%@欢迎您,宾馆位于%@,星级:%@,",data.Des1,data.Des2,data.Des3]];
        [sheet setCancelButtonWithTitle:@"返回" block:nil];
        [sheet setDestructiveButtonWithTitle:@"拨打宾馆订房热线" block:^{
            NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",data.Des4];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
        }];
        [sheet addButtonWithTitle:@"查看宾馆详细信息" block:^{
            DesLifeViewController *desLifeViewController = [[DesLifeViewController alloc]init];
            desLifeViewController.label.text = data.Des1;
            desLifeViewController.textView.text = data.Des5;
            desLifeViewController.imageView.image = [UIImage imageNamed:data.Des7];
            [self.navigationController pushViewController:desLifeViewController animated:YES];

        }];
        [sheet showInView:self.tableView];
    }
    else if (self.flickTabView.selectedTabIndex == 4) {
        LifeData *data = [mutableArray6 objectAtIndex:indexPath.row];
        BlockActionSheet *sheet = [BlockActionSheet sheetWithTitle:[NSString stringWithFormat:@"欢迎乘坐%@次列车,本次列车车票价格:%@元,行车时间共:%@,如需乘坐本次列车，您可以通过如下方式预定火车票,",data.Des1,data.Des7,data.Des6]];
        [sheet setCancelButtonWithTitle:@"返回" block:nil];
        [sheet setDestructiveButtonWithTitle:@"拨打全国火车票订票电话" block:^{
            NSString *num = [[NSString alloc] initWithFormat:@"tel://4006011604"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
        }];
        [sheet addButtonWithTitle:@"通过铁道部官网进行订票" block:^{
            NSString *num = [[NSString alloc] initWithFormat:@"www.110.com"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
        }];
        [sheet showInView:self.tableView];
    }
    else if (self.flickTabView.selectedTabIndex == 5) {
        LifeData *data = [mutableArray7 objectAtIndex:indexPath.row];
        BlockActionSheet *sheet = [BlockActionSheet sheetWithTitle:[NSString stringWithFormat:@"%@欢迎您,如需乘坐本次客车，您可以通过如下方式预定车票,车票价格:%@元",data.Des2,data.Des5]];
        [sheet setCancelButtonWithTitle:@"返回" block:nil];
        [sheet setDestructiveButtonWithTitle:@"拨打当地客车订票电话" block:^{
            NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",data.Des6];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
        }];
        [sheet showInView:self.tableView];

    }
    else if (self.flickTabView.selectedTabIndex == 6) {
        LifeData *data = [mutableArray8 objectAtIndex:indexPath.row];
        BlockActionSheet *sheet = [BlockActionSheet sheetWithTitle:[NSString stringWithFormat:@"%@欢迎您,此次航班航行时间:%@,如需乘坐%@次航班,您可以通过如下方式预定机票",data.Des2,data.Des6,data.Des1]];
        [sheet setCancelButtonWithTitle:@"返回" block:nil];
        [sheet setDestructiveButtonWithTitle:@"拨打当地机场进行订票" block:^{
            NSString *num = [[NSString alloc] initWithFormat:@"tel://114"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
        }];
        [sheet showInView:self.tableView];
    }

}


#pragma mark -
#pragma mark FlickTabView Delegate & Data Source

- (void)scrollTabView:(FlickTabView*)scrollTabView didSelectedTabAtIndex:(NSInteger)index {
	[self.tableView reloadData];
}

- (NSInteger)numberOfTabsInScrollTabView:(FlickTabView*)scrollTabView {
    
	return 7;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}



- (NSString*)scrollTabView:(FlickTabView*)scrollTabView titleForTabAtIndex:(NSInteger)index {
   NSMutableArray  *titleArray = [[NSMutableArray alloc]initWithObjects:@"旅游",@"购物",@"酒店",@"宾馆",@"火车",@"汽车",@"飞机", nil];
    NSString *title = [titleArray objectAtIndex:index];

	return title;
}


#pragma mark -


- (void)dealloc {
    [super dealloc];
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
