//
//  RaceVolunteerViewController.m
//  NongYunTong
//
//  Created by Edward on 12-5-18.
//  Copyright (c) 2012年 南阳理工学院. All rights reserved.
//

#import "RaceVolunteerViewController.h"
#import "GCSectionViewController.h"
#import "VolunteerXML.h"
#import "VolunteerData.h"
@interface RaceVolunteerViewController ()

@end

@implementation RaceVolunteerViewController

@synthesize retractableControllers,volunteerXML,dataArray;

-(id)init
{
    if (self = [super init]) 
    {
        volunteerXML = [[VolunteerXML alloc]init];
       dataArray = [volunteerXML XML];
        
    }
    return self;
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"志愿者";
    
    GCSectionViewController *sectionViewController1 = [[GCSectionViewController alloc]initWithViewController:self];
    GCSectionViewController *sectionViewController2 = [[GCSectionViewController alloc]initWithViewController:self];
    GCSectionViewController *sectionViewController3 = [[GCSectionViewController alloc]initWithViewController:self];
    GCSectionViewController *sectionViewController4 = [[GCSectionViewController alloc]initWithViewController:self];
    GCSectionViewController *sectionViewController5 = [[GCSectionViewController alloc]initWithViewController:self];
    GCSectionViewController *sectionViewController6 = [[GCSectionViewController alloc]initWithViewController:self];
    GCSectionViewController *sectionViewController7 = [[GCSectionViewController alloc]initWithViewController:self];
    GCSectionViewController *sectionViewController8 = [[GCSectionViewController alloc]initWithViewController:self];
    GCSectionViewController *sectionViewController9 = [[GCSectionViewController alloc]initWithViewController:self];
    GCSectionViewController *sectionViewController10 = [[GCSectionViewController alloc]initWithViewController:self];
    GCSectionViewController *sectionViewController11 = [[GCSectionViewController alloc]initWithViewController:self];
    GCSectionViewController *sectionViewController12 = [[GCSectionViewController alloc]initWithViewController:self];
    GCSectionViewController *sectionViewController13 = [[GCSectionViewController alloc]initWithViewController:self];
    GCSectionViewController *sectionViewController14 = [[GCSectionViewController alloc]initWithViewController:self];
    GCSectionViewController *sectionViewController15 = [[GCSectionViewController alloc]initWithViewController:self];
    NSMutableArray *array1 = [[NSMutableArray alloc]init];
        NSMutableArray *array2 = [[NSMutableArray alloc]init];
        NSMutableArray *array3 = [[NSMutableArray alloc]init];
        NSMutableArray *array4 = [[NSMutableArray alloc]init];
        NSMutableArray *array5 = [[NSMutableArray alloc]init];
        NSMutableArray *array6 = [[NSMutableArray alloc]init];
        NSMutableArray *array7 = [[NSMutableArray alloc]init];
        NSMutableArray *array8 = [[NSMutableArray alloc]init];
        NSMutableArray *array9 = [[NSMutableArray alloc]init];
        NSMutableArray *array10 = [[NSMutableArray alloc]init];
        NSMutableArray *array11 = [[NSMutableArray alloc]init];
        NSMutableArray *array12 = [[NSMutableArray alloc]init];
        NSMutableArray *array13 = [[NSMutableArray alloc]init];
        NSMutableArray *array14 = [[NSMutableArray alloc]init];
        NSMutableArray *array15 = [[NSMutableArray alloc]init];
    
                             
    for (VolunteerData *obj in dataArray) {
        if ([obj.service_area isEqualToString:@"南阳理工体育馆"]) {
            [array1 addObject:obj];
        }
        else if ([obj.service_area isEqualToString:@"市体育馆"]) {
            [array2 addObject:obj];
        }
        else if ([obj.service_area isEqualToString:@"南阳师院体育馆"]) {
            [array3 addObject:obj];
        }
        else if ([obj.service_area isEqualToString:@"南阳农业学校体育馆"]) {
            [array4 addObject:obj];
        }
        else if ([obj.service_area isEqualToString:@"南阳大桥"]) {
            [array5 addObject:obj];
        }
        else if ([obj.service_area isEqualToString:@"南阳医专体育馆"]) {
            [array6 addObject:obj];
        }
        else if ([obj.service_area isEqualToString:@"河南工业技术学院体育馆"]) {
            [array7 addObject:obj];
        }
        else if ([obj.service_area isEqualToString:@"唐河县体育馆"]) {
            [array8 addObject:obj];
        }
        else if ([obj.service_area isEqualToString:@"麒麟山庄"]) {
            [array9 addObject:obj];
        }
        else if ([obj.service_area isEqualToString:@"南召莲花温泉公园"]) {
            [array10 addObject:obj];
        }
        else if ([obj.service_area isEqualToString:@"邓州市体育馆"]) {
            [array11 addObject:obj];
        }
        else if ([obj.service_area isEqualToString:@"河南油田体育馆"]) {
            [array12 addObject:obj];
        }
        else if ([obj.service_area isEqualToString:@"内乡县滨河路"]) {
            [array13 addObject:obj];
        }
        else if ([obj.service_area isEqualToString:@"十二里河村"]) {
            [array14 addObject:obj];
        }
        else if ([obj.service_area isEqualToString:@"综合训练馆"]) {
            [array15 addObject:obj];
       }

    }
    
    sectionViewController1.desArray = array1;
        sectionViewController2.desArray = array2;
        sectionViewController3.desArray = array3;
        sectionViewController4.desArray = array4;
        sectionViewController5.desArray = array5;
        sectionViewController6.desArray = array6;
        sectionViewController7.desArray = array7;
        sectionViewController8.desArray = array8;
        sectionViewController9.desArray = array9;
        sectionViewController10.desArray = array10;
        sectionViewController11.desArray = array11;
        sectionViewController12.desArray = array12;
        sectionViewController13.desArray = array13;
        sectionViewController14.desArray = array14;
        sectionViewController15.desArray = array15;
    
    NSMutableArray *titleArray = [[NSMutableArray alloc]initWithObjects:@"南阳理工体育馆",@"市体育馆",@"南阳师院体育馆",@"南阳农业学校体育馆",@"南阳大桥",@"南阳医专体育馆",@"河南工业技术学院体育馆",@"唐河县体育馆",@"麒麟山庄",@"南召莲花温泉公园",@"邓州市体育馆",@"河南油田体育馆",@"内乡县滨河路",@"十二里河村",@"综合训练馆", nil];

    self.retractableControllers = [NSArray arrayWithObjects:sectionViewController1,sectionViewController2,sectionViewController3,sectionViewController4,sectionViewController5,sectionViewController6,sectionViewController7,sectionViewController8,sectionViewController9,sectionViewController10,sectionViewController11,sectionViewController12,sectionViewController13,sectionViewController14,sectionViewController15, nil];
    int i = 0;
    for (GCSectionViewController *obj in retractableControllers) {
        obj.title = [titleArray objectAtIndex:i];
        i++;
    }
    for (id obj in retractableControllers) {
        [obj release];
    }
    
    
	// Do any additional setup after loading the view.
}


#pragma TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
   
    return 15; 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{ 
    GCRetractableSectionController* sectionController = [self.retractableControllers objectAtIndex:section];
    return sectionController.numberOfRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GCRetractableSectionController* sectionController = [self.retractableControllers objectAtIndex:indexPath.section];
    return [sectionController cellForRow:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GCRetractableSectionController* sectionController = [self.retractableControllers objectAtIndex:indexPath.section];
    return [sectionController didSelectCellAtRow:indexPath.row];
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

-(void)dealloc{
    self.retractableControllers = nil;
    [super dealloc];
}

@end
