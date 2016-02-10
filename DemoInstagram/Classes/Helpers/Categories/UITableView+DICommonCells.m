//
//  UITableView+DICommonCells.m
//  DemoInstagram
//
//  Created by Anatoliy Afanasev on 1/6/16.
//  Copyright © 2016 Anatoliy Afanasev. All rights reserved.
//

#import "UITableView+DICommonCells.h"
#import "DILoadingTableViewCell.h"
#import "DICommonTextCell.h"

@implementation UITableView (DICommonCells)

- (DILoadingTableViewCell *)dequeueUFLoadingCell {
    NSString *identifier = NSStringFromClass([DILoadingTableViewCell class]);
    DILoadingTableViewCell *loadingTableViewCell = [self dequeueReusableCellWithIdentifier:identifier];
    
    if (!loadingTableViewCell) {
        [self registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellReuseIdentifier:identifier];
        loadingTableViewCell = [self dequeueReusableCellWithIdentifier:identifier];
    }
    
    [loadingTableViewCell.activityIndicatorView startAnimating];
    return loadingTableViewCell;
}

- (UITableViewCell *)dequeueUFCommonNoResultCell{
    return [self dequeueUFCommonCellWithText:@"No Content Found"];
}

- (UITableViewCell *)dequeueUFNoConnectionCell{
    return [self dequeueUFCommonCellWithText:@"Connection problem.\nMake sure Airplane Mode is turned Off and check your internet connection."];
}

#pragma mark - Private

- (UITableViewCell *)dequeueUFCommonCellWithText:(NSString *)text {
    NSString *identifier = NSStringFromClass([DICommonTextCell class]);
    DICommonTextCell *cell = [self dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        [self registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellReuseIdentifier:identifier];
        cell = [self dequeueReusableCellWithIdentifier:identifier];
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.label setText:text];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    [cell setUserInteractionEnabled:NO];
    
    return cell;
}

@end
