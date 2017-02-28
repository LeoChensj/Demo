//
//  SearchRecordView.h
//  xbed
//
//  Created by Leo.Chen on 16/7/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "TouchEventTableView.h"
#import "SearchRecordManager.h"

//cell
@interface SearchRecordCell : UITableViewCell
{
@private
    UIImageView *_imgvIcon;
    UILabel *_lbRecord;
    UIView *_line;
}

@property (nonatomic, strong)SearchRecordModel *model;

@end


//tableView
@class SearchRecordView;
typedef void (^SearchRecordViewDidSelectRowBlock)(SearchRecordView *tableView, SearchRecordModel *model, NSIndexPath *indexPath);
typedef void (^SearchRecordViewDidClearBlock)();

@interface SearchRecordView : TouchEventTableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)NSArray <SearchRecordModel *>*dataArray;
@property (nonatomic, strong)SearchRecordViewDidSelectRowBlock block;
@property (nonatomic, strong)SearchRecordViewDidClearBlock blockClear;


- (void)addSearchRecordViewDidSelectRowBlock:(SearchRecordViewDidSelectRowBlock)block didClearBlock:(SearchRecordViewDidClearBlock)blockClear;

@end








