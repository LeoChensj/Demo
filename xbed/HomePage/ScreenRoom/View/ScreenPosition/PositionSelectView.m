//
//  PositionSelectView.m
//  xbed
//
//  Created by Leo.Chen on 16/7/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "PositionSelectView.h"

@implementation PositionSelectView

- (instancetype)init
{
    if(self = [super init])
    {
        _tableView1 = [[PositionTableView1 alloc] init];
        [self addSubview:_tableView1];
        [_tableView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(self.mas_width).multipliedBy(1.0/3);
            make.height.mas_equalTo(self.mas_height);
            make.left.top.mas_equalTo(0);
            
        }];
        
        //一级写死
        ScreenRoomTagModel *model1 = [[ScreenRoomTagModel alloc] init];
        model1.cname = @"行政区";
        model1.code = @"0";
        ScreenRoomTagModel *model2 = [[ScreenRoomTagModel alloc] init];
        model2.cname = @"商圈";
        model2.code = @"1";
        ScreenRoomTagModel *model3 = [[ScreenRoomTagModel alloc] init];
        model3.cname = @"楼宇";
        model3.code = @"2";
        _tableView1.dataArray = @[model1, model2, model3];
        
        WS(ws);
        [_tableView1 addPositionTableView1SelectBlock:^(PositionTableView1 *tableView, ScreenRoomTagModel *model, NSIndexPath *indexPath) {
            
            ws.model1 = model;
            ws.tableView2.dataArray = ws.dataArray[model.code.integerValue];
            
        }];
        
        
        
        _tableView2 = [[PositionTableView2 alloc] init];
        [self addSubview:_tableView2];
        [_tableView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(self.mas_width).multipliedBy(2.0/3);
            make.height.mas_equalTo(self.mas_height);
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(_tableView1.mas_right).offset(0);
            
        }];
        
        [_tableView2 addPositionTableView2SelectBlock:^(PositionTableView2 *tableView, ScreenRoomTagModel *model, NSIndexPath *indexPath) {
            
            ws.model2 = model;
            
            if(ws.block)
            {
                ws.block(ws.model1, model);
            }
            
        }];
    }
    
    return self;
}

- (void)addPositionSelectViewCompleteBlock:(PositionSelectViewCompleteBlock)block
{
    _block = block;
}





#pragma mark - set
- (void)setDataArray:(NSArray<NSArray<ScreenRoomTagModel *> *> *)dataArray
{
    _dataArray = dataArray;
    
    _tableView2.dataArray = _dataArray[0];
}

- (void)setModel1:(ScreenRoomTagModel *)model1
{
    _model1 = model1;
    
    if(model1)
    {
        _tableView1.code = model1.code;
        _tableView2.dataArray = _dataArray[model1.code.integerValue];
    }
    else
    {
        _tableView1.code = @"0";
        _tableView2.dataArray = _dataArray[0];
    }
}

- (void)setModel2:(ScreenRoomTagModel *)model2
{
    _model2 = model2;
    
    _tableView2.code = model2.code;
}


@end
