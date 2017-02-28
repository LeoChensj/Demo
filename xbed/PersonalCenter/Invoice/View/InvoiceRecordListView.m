//
//  InvoiceRecordListView.m
//  xbed
//
//  Created by Leo.Chen on 16/9/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "InvoiceRecordListView.h"

@implementation InvoiceRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *selectView = [[UIView alloc] init];
        selectView.backgroundColor = White_Click_COLOR;
        self.selectedBackgroundView = selectView;
        
        _lbPrice = [[UILabel alloc] init];
        _lbPrice.textColor = Blue_Color;
        _lbPrice.font = Font(16);
        [self.contentView addSubview:_lbPrice];
        [_lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(16);
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(self.mas_centerY).offset(-5);
            
        }];
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.font = Font(13);
        [self.contentView addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-100);
            make.height.mas_equalTo(13);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(self.mas_centerY).offset(5);
            
        }];
        
        _lbState = [[UILabel alloc] init];
        _lbState.textAlignment = NSTextAlignmentRight;
        _lbState.font = Font(13);
        [self.contentView addSubview:_lbState];
        [_lbState mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(13);
            make.right.mas_equalTo(-28);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        UIImageView *imgvArrow = [[UIImageView alloc] init];
        imgvArrow.image = [UIImage imageNamed:@"ic_search_into"];
        [self.contentView addSubview:imgvArrow];
        [imgvArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(8);
            make.height.mas_equalTo(14);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            
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

- (void)setModel:(InvoiceRecordModel *)model
{
    _model = model;
    
    _lbPrice.text = [NSString stringWithFormat:@"￥%@", [NSNumber numberWithFloat:model.price.floatValue/100]];
    _lbTitle.text = model.title;
    
    if(model.postStatus.integerValue==1)
    {
        _lbState.text = @"未寄出";
        _lbState.textColor = Main_Text_Color;
    }
    else if(model.postStatus.integerValue==2)
    {
        _lbState.text = @"已寄出";
        _lbState.textColor = Blue_Color;
    }
    else if(model.postStatus.integerValue==3)
    {
        _lbState.text = @"派送中";
        _lbState.textColor = Blue_Color;
    }
    else if(model.postStatus.integerValue==4)
    {
        _lbState.text = @"已签收";
        _lbState.textColor = Blue_Color;
    }
}

@end



@implementation InvoiceRecordListView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor clearColor];
        self.dataSource = self;
        self.delegate = self;
        self.rowHeight = 55;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
        
        
        _lbNoRecord = [[UILabel alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH*0.5-75, 15, 150, 13)];
        _lbNoRecord.text = @"暂无开票记录";
        _lbNoRecord.textAlignment = NSTextAlignmentCenter;
        _lbNoRecord.textColor = Secondary_Text_Color2;
        _lbNoRecord.font = Font(13);
        [self addSubview:_lbNoRecord];
        _lbNoRecord.hidden = YES;
        
        
        //---loadmore------//
        WS(ws);
        _footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            if(ws.blockLoadmore)
            {
                ws.blockLoadmore(ws);
            }
            
        }];
        _footer.stateLabel.textColor = Secondary_Text_Color2;
        [_footer setTitle:@"加载更多..." forState:MJRefreshStateRefreshing];
        [_footer setTitle:@"" forState:MJRefreshStateIdle];
        self.mj_footer = _footer;
        //---loadmore------//
        
    }
    
    return self;
}

- (void)addInvoiceRecordListViewSelectItemBlock:(InvoiceRecordListViewSelectItemBlock)blockSelectItem invoiceRecordListViewLoadmoreBlock:(InvoiceRecordListViewLoadmoreBlock)blockLoadmore
{
    _blockSelectItem = blockSelectItem;
    _blockLoadmore = blockLoadmore;
}

- (void)setDataArray:(NSArray<InvoiceRecordModel *> *)dataArray
{
    _dataArray = dataArray;
    
    [self reloadData];
    
    if(dataArray && dataArray.count)
    {
        _lbNoRecord.hidden = YES;
    }
    else
    {
        _lbNoRecord.hidden = NO;
    }
}


#pragma - TableView DataSourse Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    InvoiceRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[InvoiceRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(InvoiceRecordCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.model = _dataArray[indexPath.row];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if(_blockSelectItem)
    {
        _blockSelectItem(self, _dataArray[indexPath.row], indexPath);
    }
}






@end
