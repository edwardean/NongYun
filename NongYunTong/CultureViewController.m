//
//  CultureViewController.m
//  NongYunTong
//
//  Created by Edward on 12-5-16.
//  Copyright (c) 2012年 TuringTeam. All rights reserved.
//

#import "CultureViewController.h"
#import "DesPeopleViewController.h"
#import "ADLivelyTableView.h"
#import "TBXML.h"
#import "PeopleXML.h"
#import "PeopleData.h"
#import "AppDelegate.h"
#import "CultureTableCell.h"
@interface CultureViewController ()

@end

@implementation CultureViewController

@synthesize CultureTableView,peopleXml;

-(id) init{
    if (self = [super init]) {
       
        
    }
    return self;
    
}

-(void)SetObject:(id)sender{
    peopleXml = sender;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    CultureTableView = [[ADLivelyTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 370) style:UITableViewStylePlain];
    CultureTableView.initialCellTransformBlock = ADLivelyTransformFan;
    CultureTableView.dataSource = self;
    CultureTableView.delegate = self;
    [self.view addSubview:CultureTableView];
    // Do any additional setup after loading the view from its nib.
}



-(void) viewWillAppear:(BOOL)animated{

    [CultureTableView reloadData];
}

#pragma mark -
#pragma mark TableView methods

//指定每个分区中有多少行，默认为1
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [peopleXml.mutArray count];
}

//指定有多少个分区(Section)，默认为1
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//绘制Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath{
    CultureTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"CultureTableCell" owner:self options:nil];  
        cell = [array objectAtIndex:0]; 
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        UIView * backgroundView = [[UIView alloc] initWithFrame:cell.bounds];
        cell.backgroundView = backgroundView;
        [backgroundView release];

    }
    PeopleData *peopleData = [peopleXml.mutArray objectAtIndex:indexPath.row];
    cell.CellImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",peopleData.s_Image]];
    cell.CellLabel.text = peopleData.s_SpecialtiesCulture;
    cell.CellLabelDes.text = peopleData.s_Source;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

//选中Cell响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DesPeopleViewController *desPeopleViewController = [[DesPeopleViewController alloc]init];
    desPeopleViewController.peopleData = [peopleXml.mutArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:desPeopleViewController animated:YES];
    [desPeopleViewController release];
    
}



- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleDelete;
}

//改变行的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64.0f;
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

- (void)dealloc {
    [super dealloc];
    [CultureTableView release];
}

@end
