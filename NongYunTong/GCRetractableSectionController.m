//
//  GCRetractableSectionController.m
//  Mtl mobile
//
//  Created by Guillaume Campagna on 09-10-19.
//  Copyright 2009 LittleKiwi. All rights reserved.
//

#import "GCRetractableSectionController.h"

@interface GCRetractableSectionController ()

@property (nonatomic, assign) UIViewController *viewController;

- (void) setAccessoryViewOnCell:(UITableViewCell*) cell;

@end

@implementation GCRetractableSectionController

@synthesize useOnlyWhiteImages, titleTextColor, titleAlternativeTextColor;
@synthesize viewController;
@synthesize open;

#pragma mark -
#pragma mark Initialisation

- (id) initWithViewController:(UIViewController*) givenViewController 
{
	if ((self = [super init]))
    {
        if (![givenViewController respondsToSelector:@selector(tableView)]) 
        {
            //The view controller MUST have a tableView proprety 视图控制器必须有一个tableView的属性
            [NSException raise:@"Wrong view controller" 
                        format:@"The passed view controller to GCRetractableSectionController must respond to the tableView proprety"];
            
        }
        
		self.viewController = givenViewController;
		self.open = NO;
        self.useOnlyWhiteImages = NO;
	}
	return self;
}

#pragma mark -
#pragma mark Getters

- (UITableView*) tableView
{
	return [self.viewController performSelector:@selector(tableView)];
}

- (NSUInteger) numberOfRow   //在下一个类中有调用
{
    return (self.open) ? self.contentNumberOfRow + 1 : 1;  //NSUInteger  contentNumberOfRow
}

- (NSUInteger) contentNumberOfRow     //content 目录的行数量
{
	return 0;
}

- (NSString*) title 
{
	return NSLocalizedString(@"No title",);
}

- (NSString*) titleContentForRow:(NSUInteger) row
{
	return NSLocalizedString(@"No title",);
}

#pragma mark -
#pragma mark Cells

- (UITableViewCell *) cellForRow:(NSUInteger)row   //下一个类中有调用
{
	UITableViewCell* cell = nil;
	
	if (row == 0) cell = [self titleCell];   
	else cell = [self contentCellForRow:row - 1];
	
	return cell;
}

- (UITableViewCell *) titleCell  //指的是总的cell视图
{
	NSString* titleCellIdentifier = [NSStringFromClass([self class]) stringByAppendingString:@"title"];
	
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:titleCellIdentifier];
	if (cell == nil) 
    {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:titleCellIdentifier] autorelease];
	}
	
	cell.textLabel.text = self.title;
	if (self.contentNumberOfRow != 0) 
    {
		cell.detailTextLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%i名志愿者可以为您服务",), self.contentNumberOfRow];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:10.0f];
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        [self setAccessoryViewOnCell:cell];   //如果去掉了这句话 则只有选中的行有打对钩  其他的行则没有对钩
	}
	else 
    {
		cell.detailTextLabel.text = NSLocalizedString(@"No item",);
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryView = nil;
        cell.textLabel.textColor = [UIColor blackColor];
	}
	
	return cell;
}

- (UITableViewCell *) contentCellForRow:(NSUInteger)row  //指的是每一行下面的小分cell视图
{
	NSString* contentCellIdentifier = [NSStringFromClass([self class]) stringByAppendingString:@"content"];
	
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:contentCellIdentifier];
	if (cell == nil) 
    {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:contentCellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	cell.textLabel.text = [self titleContentForRow:row];  //这句话是显示了志愿者的名字？？？？？
    if ([[self imageSex:row] isEqualToString:@"男"])
    {
        cell.imageView.image = [UIImage imageNamed:@"boy.png"];
    }
    
    else 
    {
        cell.imageView.image = [UIImage imageNamed:@"girl.png"];
    }
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"特长:%@         点击即可为您服务",[self detailVolunteer:row]];//????????
    cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:0 green:0 blue:255 alpha:1];
    
	
	return cell;
}

- (void) setAccessoryViewOnCell:(UITableViewCell*) cell
{
	NSString* path = nil;
	if (self.open)
    {
        NSLog(@"duanduanduanduan\n\n\n");
		path = @"UpAccessory";
        if (self.titleAlternativeTextColor == nil) 
        {
             NSLog(@"yayayayayaya");
             cell.textLabel.textColor =  [UIColor colorWithRed:0.191 green:0.264 blue:0.446 alpha:1.000];  
             //展开之后改变总的cell上字体上的颜色  有黑变为蓝色
        }
        else cell.textLabel.textColor = self.titleAlternativeTextColor;
	}	
	else 
    {
		path = @"DownAccessory";
		cell.textLabel.textColor = (self.titleTextColor == nil ? [UIColor blackColor] : self.titleTextColor);
	}
	
	UIImage* accessoryImage = [UIImage imageNamed:path];
	UIImage* whiteAccessoryImage = [UIImage imageNamed:[[path stringByDeletingPathExtension] stringByAppendingString:@"White"]];
	
	UIImageView* imageView;
	if (cell.accessoryView != nil) //accessoryView 是指行右边的按钮换成带图片的
    {
		imageView = (UIImageView*) cell.accessoryView;
		imageView.image = (self.useOnlyWhiteImages ? whiteAccessoryImage : accessoryImage);
		imageView.highlightedImage = whiteAccessoryImage;
    }
	else 
    {
		imageView = [[UIImageView alloc] initWithImage:(self.useOnlyWhiteImages ? whiteAccessoryImage : accessoryImage)];
		imageView.highlightedImage = whiteAccessoryImage;
		cell.accessoryView = imageView;
		[imageView release];
	}
}

#pragma mark -
#pragma mark Select Cell

- (void) didSelectCellAtRow:(NSUInteger)row 
{
	if (row == 0) [self didSelectTitleCell];
	else [self didSelectContentCellAtRow:row - 1];
}
- (void) didSelectTitleCell 
{
	self.open = !self.open;
	if (self.contentNumberOfRow != 0) [self setAccessoryViewOnCell:[self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]]];  //删掉之后没影响
	
	NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
	NSUInteger section = indexPath.section;
	NSUInteger contentCount = self.contentNumberOfRow;
	
	[self.tableView beginUpdates];
	
	NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
	for (NSUInteger i = 1; i < contentCount + 1; i++) 
    {
		NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
		[rowToInsert addObject:indexPathToInsert];
	}
	
	if (self.open) [self.tableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
	else [self.tableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
	[rowToInsert release];
	
	[self.tableView endUpdates];
	
	if (self.open) [self.tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) didSelectContentCellAtRow:(NSUInteger)row {}

@end
