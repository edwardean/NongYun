//
//  RaceItemViewController.m
//  NongYunTong
//
//  Created by Edward on 12-5-18.
//  Copyright (c) 2012年 南阳理工学院. All rights reserved.
//

#import "RaceItemViewController.h"
#import "GCSearchItemViewController.h"
#import "RaceItemSearchXML.h"
#import "RaceItemSearchData.h"
@interface RaceItemViewController ()

@end

@implementation RaceItemViewController
@synthesize mutableArray,raceItemSearchXML,ItemData1,GameDate,GamePlace,GameProject,ItemData2,ItemData3;

-(id)init
{
    if (self = [super init]) 
    {
        raceItemSearchXML = [[RaceItemSearchXML alloc]init];
        ItemData1 = [raceItemSearchXML XML:@"gameTime"];
        ItemData2 = [raceItemSearchXML XML:@"gamePlace"];
        ItemData3 = [raceItemSearchXML XML:@"gameProject"];
        
        GameDate = [[NSMutableArray alloc]initWithObjects:@"2012年10月12日-9:00",@"2012年10月12日-12:30",@"2012年10月12日-14:30",@"2012年10月12日-16:30",@"2012年10月14日-9:00",@"2012年10月14日-12:30",
                    @"2012年10月14日-14:30",@"2012年10月14日-16:30",@"2012年10月16日-9:00",@"2012年10月16日-12:30",@"2012年10月16日-14:30",@"2012年10月16日-16:30",nil ];
        GameProject = [[NSMutableArray  alloc]initWithObjects:@"田径",@"龙舟",@"篮球",@"花毽",@"乒乓球",@"摔跤",@"舞龙舞狮",@"钓鱼",@"风筝",@"中国象棋",@"秧歌",@"自行车载重",@"民兵军事三项",@"游泳",nil];
        
        GamePlace = [[NSMutableArray alloc]initWithObjects:@"南阳体育馆",@"水上运动场",@"南阳理工学院体育馆",@"南阳农业学校体育馆",@"南阳医学专科高等学校训练馆",@"南阳师范学院体育馆",@"河南工业职业技术学院体育馆",@"唐河县体育馆",@"南阳卧龙区麒麟山庄",@"南阳南召县莲花温泉公园",@"邓州市宾馆",@"河南油田体育馆",@"南阳市内乡县滨河路",@"南阳军分区民兵综合训练基地",@"综合训练馆和游泳馆",nil];
    }
    return self;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    GCSearchItemViewController *searchItemViewController1 = [[GCSearchItemViewController alloc]initWithViewController:self];
    GCSearchItemViewController *searchItemViewController2 = [[GCSearchItemViewController alloc]initWithViewController:self];
    GCSearchItemViewController *searchItemViewController3 = [[GCSearchItemViewController alloc]initWithViewController:self];
     searchItemViewController1.title = @"根据比赛时间查询";
     searchItemViewController2.title = @"根据比赛场地查询";
     searchItemViewController3.title = @"根据比赛项目查询";
    
    searchItemViewController1.searchItem = GameDate;
    searchItemViewController2.searchItem = GamePlace;
    searchItemViewController3.searchItem = GameProject;
    
    searchItemViewController1.itemgame = ItemData1;
    searchItemViewController2.itemgame = ItemData2;
    searchItemViewController3.itemgame = ItemData3;
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 50.0f)];
    label.text = @"2012南阳全国农民运动会";
    label.textAlignment = UITextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:14.0f];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.tableView.tableFooterView = label;
    [label release];
    
    self.mutableArray = [NSArray arrayWithObjects:searchItemViewController1,searchItemViewController2,searchItemViewController3,nil];
    [searchItemViewController1 release];
    [searchItemViewController2 release];
    [searchItemViewController3 release];
    
	// Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GCSearchSectionController* sectionController = [self.mutableArray objectAtIndex:section];
    return sectionController.numberOfRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GCSearchSectionController* sectionController = [self.mutableArray objectAtIndex:indexPath.section];
    return [sectionController cellForRow:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GCSearchSectionController* sectionController = [self.mutableArray objectAtIndex:indexPath.section];
    return [sectionController didSelectCellAtRow:indexPath.row];
}

- (void)dealloc
{
    self.mutableArray = nil;
    
    [super dealloc];
}

@end
