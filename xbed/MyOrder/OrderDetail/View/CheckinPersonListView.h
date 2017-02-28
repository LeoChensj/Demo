//
//  CheckinPersonListView.h
//  xbed
//
//  Created by Leo.Chen on 16/10/11.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckinOrderInfoRespModel.h"

@interface CheckinPersonListCell : UITableViewCell
{
@private
    UILabel *_lbName;
    UILabel *_lbIdNo;
}

@property (nonatomic, strong)CheckinOrderCheckinerModel *model;

@end


///////////////##################////////////////

@class CheckinPersonListView;
typedef void(^CheckinPersonListViewDeleteBlock)();

@interface CheckinPersonListView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)NSMutableArray <CheckinOrderCheckinerModel *>*dataArray;
@property (nonatomic, strong)CheckinPersonListViewDeleteBlock block;
@property (nonatomic, strong)STAlertView *alertView;

- (void)addCheckinPersonListViewDeleteBlock:(CheckinPersonListViewDeleteBlock)block;

@end
