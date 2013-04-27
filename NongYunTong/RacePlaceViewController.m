//
//  RacePlaceViewController.m
//  NongYunTong
//
//  Created by Edward on 12-5-18.
//  Copyright (c) 2012年 南阳理工学院. All rights reserved.
//

#import "RacePlaceViewController.h"
#import "PlaceInfoViewController.h"
#import "RacePlaceXML.h"
#import "RacePlaceData.h"
#import "PlaceTableCell.h"
@interface RacePlaceViewController ()

@end

@implementation RacePlaceViewController
@synthesize mutableArray,racePlaceXML,raceTableView;


-(id) init{
    if (self = [super init]) {
        
        self.navigationItem.title = @"比赛场地";
        
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    racePlaceXML = [[RacePlaceXML alloc]init];
    mutableArray = [racePlaceXML XML];
    raceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 370) style:UITableViewStylePlain];
    raceTableView.delegate = self;
    raceTableView.dataSource = self;
    [self.view addSubview:raceTableView];
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 50.0f)];
    label.text = @"2012南阳全国农民运动会";
    label.textAlignment = UITextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:14.0f];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.raceTableView.tableFooterView = label;
    [label release];

    
        // Do any additional sup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated{
    
    [raceTableView reloadData];
}

#pragma mark -
#pragma mark TableView methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [mutableArray count];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
//    if (cell == nil) {
//        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"]autorelease];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    RacePlaceData *racePlaceData = [mutableArray objectAtIndex:indexPath.row];
//    cell.textLabel.text = racePlaceData.pName;
//    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",racePlaceData.pImage]];
//    cell.detailTextLabel.text = racePlaceData.pIntroduction;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    
//    return cell;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath{
    static NSString *CustomCellIdentifier = @"Cell";
    PlaceTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"PlaceTableCell" owner:self options:nil];  
        cell = [array objectAtIndex:0];  
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    RacePlaceData *racePlaceData = [mutableArray objectAtIndex:indexPath.row];
    cell.CellImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",racePlaceData.pImage]];
    cell.CellText.text = racePlaceData.pName;
    cell.CellTextDes.text = racePlaceData.pIntroduction;
    
    
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PlaceInfoViewController *placeInfoViewController = [[PlaceInfoViewController alloc]init];
    placeInfoViewController.racePlaceData = [mutableArray objectAtIndex:indexPath.row];
 
    [self.navigationController pushViewController:placeInfoViewController animated:YES];
    [placeInfoViewController release];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.0f;
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
