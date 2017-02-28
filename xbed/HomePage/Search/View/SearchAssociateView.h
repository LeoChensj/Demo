//
//  SearchAssociateView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/3.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  搜索联想View

#import <UIKit/UIKit.h>
#import "SearchRespModel.h"

//cell
@interface SearchAssociateCell : UITableViewCell
{
@private
    UILabel *_lbTitle;
    UIView *_line;
}

@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *associateContent;//变蓝

@end



//tableView
@class SearchAssociateView;
typedef void (^SearchAssociateViewDidSelectRowBlock)(SearchAssociateView *tableView, SearchModel *model, NSIndexPath *indexPath);

@interface SearchAssociateView : UITableView <UITableViewDataSource, UITableViewDelegate>
{
@private
    UILabel *_lbNoResult;
}

@property (nonatomic, strong)NSString *associateContent;
@property (nonatomic, strong)NSArray <SearchDataModel *>*dataArray;
@property (nonatomic, strong)SearchAssociateViewDidSelectRowBlock block;

- (void)addSearchAssociateViewDidSelectRowBlock:(SearchAssociateViewDidSelectRowBlock)block;

@end
