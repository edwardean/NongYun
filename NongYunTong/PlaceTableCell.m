//
//  PlaceTableCell.m
//  NongYunTong
//
//  Created by Edward on 12-5-23.
//  Copyright (c) 2012年 TuringTeam. All rights reserved.
//

#import "PlaceTableCell.h"

@implementation PlaceTableCell
@synthesize CellImage,CellText,CellTextDes;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
