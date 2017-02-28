//
//  PositionTableView2.h
//  xbed
//
//  Created by Leo.Chen on 16/7/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PositionCell2.h"

@class PositionTableView2;
typedef void (^PositionTableView2SelectBlock)(PositionTableView2 *tableView, ScreenRoomTagModel *model, NSIndexPath *indexPath);


@interface PositionTableView2 : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)NSArray <ScreenRoomTagModel *>*dataArray;
@property (nonatomic, strong)PositionTableView2SelectBlock block;
@property (nonatomic, strong)NSString *code;//设置code就会选中


- (void)addPositionTableView2SelectBlock:(PositionTableView2SelectBlock)block;

@end
