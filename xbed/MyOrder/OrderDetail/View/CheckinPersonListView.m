//
//  CheckinPersonListView.m
//  xbed
//
//  Created by Leo.Chen on 16/10/11.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CheckinPersonListView.h"
#import "DelCheckinPersonRequest.h"

@implementation CheckinPersonListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        _lbName = [[UILabel alloc] init];
        _lbName.textColor = Main_Text_Color;
        _lbName.font = Font(13);
        [self.contentView addSubview:_lbName];
        [_lbName mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
            make.height.mas_equalTo(13);
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(self.mas_centerY).offset(-5);
            
        }];
        
        
        _lbIdNo = [[UILabel alloc] init];
        _lbIdNo.textColor = Secondary_Text_Color;
        _lbIdNo.font = Font(12);
        [self.contentView addSubview:_lbIdNo];
        [_lbIdNo mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
            make.height.mas_equalTo(12);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(self.mas_centerY).offset(5);
            
        }];
        
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = Seg_Line_Color;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.bottom.mas_equalTo(0);
            
        }];
        
    }
    
    return self;
}

- (void)setModel:(CheckinOrderCheckinerModel *)model
{
    _model = model;
    
    _lbName.text = model.name;
    _lbIdNo.text = model.idNo;
}

@end






@implementation CheckinPersonListView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.dataSource = self;
        self.delegate = self;
        self.rowHeight = 70;
        self.showsVerticalScrollIndicator = NO;
        self.scrollEnabled = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return self;
}

- (void)addCheckinPersonListViewDeleteBlock:(CheckinPersonListViewDeleteBlock)block
{
    _block = block;
}

- (void)setDataArray:(NSMutableArray<CheckinOrderCheckinerModel *> *)dataArray
{
    _dataArray = dataArray;
    
    [self reloadData];
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(70*dataArray.count);
        
    }];
}



#pragma mark - UITableView DataSource Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[CheckinPersonListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(CheckinPersonListCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.model = _dataArray[indexPath.row];
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle==UITableViewCellEditingStyleDelete)
    {
        WS(ws);
        self.alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:@"确定删除该入住人吗，删除后将不能看到该订单" cancelButtonTitle:@"取消" otherButtonTitle:@"确定删除" cancelButtonBlock:nil otherButtonBlock:^{
            
            [LoadingView show];
            DelCheckinPersonRequestModel *model = [[DelCheckinPersonRequestModel alloc] init];
            model.infoId = ws.dataArray[indexPath.row].infoId;
            model.id = ws.dataArray[indexPath.row].id;
            DelCheckinPersonRequest *request = [[DelCheckinPersonRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                NSLog(@"删除成功");
                
                [ws.dataArray removeObjectAtIndex:indexPath.row];//删除数组的元素
                [ws mas_updateConstraints:^(MASConstraintMaker *make) {
                    
                    make.height.mas_equalTo(70*_dataArray.count);
                    
                }];
                [tableView  deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];//删除对应的cell
                
                if(ws.block)
                {
                    ws.block();
                }
                
            } failure:^(__kindof LeoBaseRequest *request) {
                
                NSLog(@"删除失败");
                [LoadingView close];
                [[UIApplication sharedApplication].keyWindow makeToast:[request getErrorMsg]];
                
            }];
            
        }];
        [self.alertView show];
        
        
    }
}





@end
