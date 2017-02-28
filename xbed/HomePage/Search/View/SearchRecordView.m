//
//  SearchRecordView.m
//  xbed
//
//  Created by Leo.Chen on 16/7/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "SearchRecordView.h"

@implementation SearchRecordCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *selectedBackgroundView = [[UIView alloc] init];
        selectedBackgroundView.backgroundColor = White_Click_COLOR;
        self.selectedBackgroundView = selectedBackgroundView;
        
        _imgvIcon = [[UIImageView alloc] init];
        _imgvIcon.image = [UIImage imageNamed:@"ic_search_history"];
        [self.contentView addSubview:_imgvIcon];
        [_imgvIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(18);
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        _lbRecord = [[UILabel alloc] init];
        _lbRecord.textColor = Main_Text_Color;
        _lbRecord.font = Font(13);
        [self.contentView addSubview:_lbRecord];
        [_lbRecord mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(18);
            make.left.mas_equalTo(_imgvIcon.mas_right).offset(10);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = Seg_Line_Color;
        [self.contentView addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            
        }];
        
    }
    
    return self;
}

- (void)setModel:(SearchRecordModel *)model
{
    _model = model;
    
    if([model.cname isEqualToString:model.city])
    {
        _lbRecord.text = [NSString stringWithFormat:@"%@", model.city];
    }
    else
    {
        _lbRecord.text = [NSString stringWithFormat:@"%@ · %@", model.cname, model.city];
    }
}

@end



@implementation SearchRecordView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor clearColor];
        self.alwaysBounceVertical = YES;
        self.dataSource = self;
        self.delegate = self;
        self.rowHeight = 49;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        WS(ws);
        [RACObserve(self, dataArray) subscribeNext:^(NSArray <SearchRecordModel *>*x) {
            
            if(x && x.count>0)
            {
                ws.hidden = NO;
                [ws reloadData];
            }
            else
            {
                ws.hidden = YES;
            }
            
        }];
    }
    
    return self;
}

- (void)addSearchRecordViewDidSelectRowBlock:(SearchRecordViewDidSelectRowBlock)block didClearBlock:(SearchRecordViewDidClearBlock)blockClear
{
    _block = block;
    _blockClear = blockClear;
}



#pragma - TableView DataSourse Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    SearchRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[SearchRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(SearchRecordCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.model = _dataArray[indexPath.row];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 42;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = Background_Color;
    
    UILabel *lbTitle = [[UILabel alloc] init];
    lbTitle.textColor = Main_Text_Color;
    lbTitle.font = Font(14);
    lbTitle.text = @"搜索历史";
    [headerView addSubview:lbTitle];
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
        
    }];
    
    return headerView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"清除搜索记录" forState:UIControlStateNormal];
    [button setTitleColor:Secondary_Text_Color forState:UIControlStateNormal];
    button.titleLabel.font = Font(14);
    [footerView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        
    }];
    
    WS(ws);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        if(ws.blockClear)
        {
            ws.blockClear();
        }
        
    }];
    
    
    return footerView;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self deselectRowAtIndexPath:indexPath animated:NO];//取消选中状态
    
    if(_block)
    {
        _block(self, _dataArray[indexPath.row], indexPath);
    }
}






@end
