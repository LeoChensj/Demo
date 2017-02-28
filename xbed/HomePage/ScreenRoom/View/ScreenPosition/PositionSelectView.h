//
//  PositionSelectView.h
//  xbed
//
//  Created by Leo.Chen on 16/7/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PositionTableView1.h"
#import "PositionTableView2.h"

typedef void (^PositionSelectViewCompleteBlock)(ScreenRoomTagModel *model1, ScreenRoomTagModel *model2);

@interface PositionSelectView : UIView

@property (nonatomic, strong, readonly)PositionTableView1 *tableView1;
@property (nonatomic, strong, readonly)PositionTableView2 *tableView2;

@property (nonatomic, strong)ScreenRoomTagModel *model1;
@property (nonatomic, strong)ScreenRoomTagModel *model2;
@property (nonatomic, strong)NSArray <NSArray <ScreenRoomTagModel *>*>*dataArray;
@property (nonatomic, strong)PositionSelectViewCompleteBlock block;


- (void)addPositionSelectViewCompleteBlock:(PositionSelectViewCompleteBlock)block;

@end
