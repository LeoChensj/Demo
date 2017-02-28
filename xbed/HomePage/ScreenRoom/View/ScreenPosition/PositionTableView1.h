//
//  PositionTableView1.h
//  xbed
//
//  Created by Leo.Chen on 16/7/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PositionCell1.h"

@class PositionTableView1;
typedef void (^PositionTableView1SelectBlock)(PositionTableView1 *tableView, ScreenRoomTagModel *model, NSIndexPath *indexPath);


@interface PositionTableView1 : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)NSArray <ScreenRoomTagModel *>*dataArray;
@property (nonatomic, strong)PositionTableView1SelectBlock block;
@property (nonatomic, strong)NSString *code;//设置code就会选中


- (void)addPositionTableView1SelectBlock:(PositionTableView1SelectBlock)block;

@end
