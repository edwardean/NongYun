//
//  GCSearchItemViewController.m
//  NongYunTong
//
//  Created by Edward on 12-5-19.
//  Copyright (c) 2012年 南阳理工学院. All rights reserved.
//

#import "GCSearchItemViewController.h"
#import "RaceItemSearchData.h"
#import "RaceItemViewController.h"
#import "BlockAlertView.h"
@implementation GCSearchItemViewController
@synthesize searchItem,title,itemgame;


#pragma mark -
#pragma mark Subclass



- (NSString *)titleContentForRow:(NSUInteger)row {
    return [self.searchItem objectAtIndex:row];
}

- (NSUInteger)contentNumberOfRow {
    
    return [self.searchItem count];
}

- (void)didSelectContentCellAtRow:(NSUInteger)row {
    
    RaceItemSearchData *data = [itemgame objectAtIndex:row];
    
     BlockAlertView *alert = [BlockAlertView alertWithTitle:data.gameDate message:data.gameKind];
     [alert setCancelButtonWithTitle:@"OK" block:nil];
    [alert show];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
 
}

#pragma mark -
#pragma mark Getters

- (NSArray *)searchItem {
    if (searchItem == nil) {
        searchItem = [[NSArray alloc] initWithObjects:@"根据时间查询", @"根据比赛场地查询", @"根据比赛项目查询",nil];
    }
    return searchItem;
}

- (void)dealloc {
    [searchItem release];
    
    [super dealloc];
}


@end
