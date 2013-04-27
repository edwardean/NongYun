//
//  GCSectionViewController.m
//  NongYunTong
//
//  Created by Edward on 12-5-18.
//  Copyright (c) 2012年 TuringTeam. All rights reserved.
//

#import "GCSectionViewController.h"
#import "VolunteerData.h"    
#import "BlockAlertView.h"
#import "BlockActionSheet.h"
#import "BlockTextPromptAlertView.h"
@interface GCSectionViewController ()

@end

@implementation GCSectionViewController
@synthesize title,desArray;




#pragma mark -
#pragma mark Subclass




- (NSString *)titleContentForRow:(NSUInteger)row 
{
    VolunteerData *data = [desArray objectAtIndex:row];  //这个类指的是VolunteerData 我所写的那个详细 supportArray
    return data.name;
}

-(NSString *)imageSex:(NSUInteger)row                 //没有这个
{
    VolunteerData *data = [desArray objectAtIndex:row];
    return data.sex;
}

-(NSString *)detailVolunteer:(NSUInteger)row
{
    VolunteerData *data = [desArray objectAtIndex:row];
    return data.speciality;
}

- (NSUInteger)contentNumberOfRow 
{
    return [desArray count];
}

- (void)didSelectContentCellAtRow:(NSUInteger)row 
{
        //Reaction to the selection
    VolunteerData *data = [desArray objectAtIndex:row];
//    BlockAlertView *alert = [BlockAlertView alertWithTitle:@"帮助" message:@"%@ 竭诚为您服务，如您需要志愿者的帮助，您可以通过以下方式联系到我。"];
//    [alert setCancelButtonWithTitle:@"OK" block:nil];
//    [alert show];
    
    //把这个地方改为即将要加载的视图


    BlockActionSheet *sheet = [BlockActionSheet sheetWithTitle:[NSString stringWithFormat:@"%@ 竭诚为您服务，如您需要志愿者的帮助，您可以通过以下方式联系到我。",data.name]];
    [sheet setCancelButtonWithTitle:@"返回" block:nil];
    [sheet setDestructiveButtonWithTitle:@"拨打志愿者服务电话" block:^{
         NSString *num = [[NSString alloc] initWithFormat:@"tel://4006011604"];
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
    }];
    [sheet addButtonWithTitle:@"拨打官方服务电话" block:^{
        NSString *num = [[NSString alloc] initWithFormat:@"tel://4006011604"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
    }];
    [sheet showInView:self.tableView];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

#pragma mark -
#pragma mark Getters



- (void)dealloc 
{
    [desArray release];
    
    [super dealloc];
}





- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
