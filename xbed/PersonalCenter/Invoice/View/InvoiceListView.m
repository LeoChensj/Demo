//
//  InvoiceListView.m
//  xbed
//
//  Created by Leo.Chen on 16/9/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "InvoiceListView.h"

@implementation InvoiceListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *selectView = [[UIView alloc] init];
        selectView.backgroundColor = White_Click_COLOR;
        self.selectedBackgroundView = selectView;
        
        
        _imgvIcon = [[UIImageView alloc] init];
        _imgvIcon.image = [UIImage imageNamed:@"ic_progress_dot_unfinished"];
        [self.contentView addSubview:_imgvIcon];
        [_imgvIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(17);
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(10);
            
        }];
        
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.font = Font(13);
        [self.contentView addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-(37+30));
            make.height.mas_equalTo(13);
            make.bottom.mas_equalTo(self.contentView.mas_centerY).offset(-7.5);
            make.left.mas_equalTo(_imgvIcon.mas_right).offset(10);
            
        }];
        
        
        _lbPerson = [[UILabel alloc] init];
        _lbPerson.textColor = Main_Text_Color;
        _lbPerson.font = Font(13);
        [self.contentView addSubview:_lbPerson];
        [_lbPerson mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-(37+30));
            make.height.mas_equalTo(13);
            make.top.mas_equalTo(self.contentView.mas_centerY).offset(7.5);
            make.left.mas_equalTo(_imgvIcon.mas_right).offset(10);
            
        }];
        
        
        UIImageView *imgvArrow = [[UIImageView alloc] init];
        imgvArrow.image = [UIImage imageNamed:@"ic_search_into"];
        [self.contentView addSubview:imgvArrow];
        [imgvArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(8);
            make.height.mas_equalTo(14);
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-10);
            
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = Seg_Line_Color;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.bottom.mas_equalTo(0);
            
        }];
        
        
        _button = [[UIButton alloc] init];
        [self.contentView addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(40);
            make.centerX.mas_equalTo(_imgvIcon.mas_centerX);
            make.centerY.mas_equalTo(0);
            
        }];
        
        WS(ws);
        [[_button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            if(ws.block)
            {
                ws.block(ws, ws.model);
            }
            
        }];
        
    }
    
    return self;
}

- (void)addInvoiceListCellBlock:(InvoiceListCellBlock)block
{
    _block = block;
}

- (void)setModel:(InvoiceModel *)model
{
    _model = model;
    
    _lbTitle.text = [NSString stringWithFormat:@"发票抬头：%@", model.title];
    _lbPerson.text = [NSString stringWithFormat:@"收件人：%@", model.realname];
    
    if(model.flag.boolValue)
    {
        _imgvIcon.image = [UIImage imageNamed:@"ic_progress_dot_done"];
    }
    else
    {
        _imgvIcon.image = [UIImage imageNamed:@"ic_progress_dot_unfinished"];
    }
}

@end





@implementation InvoiceListView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor clearColor];
        self.dataSource = self;
        self.delegate = self;
        self.rowHeight = 74;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
    }
    
    return self;
}

- (void)addInvoiceListViewSelectIconBlock:(InvoiceListViewSelectIconBlock)blockIcon invoiceListViewSelectIntoBlock:(InvoiceListViewSelectIntoBlock)blockInto
{
    _blockIcon = blockIcon;
    _blockInto = blockInto;
}

- (void)setDataArray:(NSArray<InvoiceModel *> *)dataArray
{
    _dataArray = dataArray;
    
    [self reloadData];
}


#pragma - TableView DataSourse Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    InvoiceListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[InvoiceListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(InvoiceListCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.model = _dataArray[indexPath.row];
    
    WS(ws);
    [cell addInvoiceListCellBlock:^(InvoiceListCell *cell, InvoiceModel *model) {
        
        for (NSInteger i=0;i<ws.dataArray.count;i++)
        {
            if([model.addressId isEqual:ws.dataArray[i].addressId])
            {
                ws.dataArray[i].flag = [NSNumber numberWithBool:YES];
            }
            else
            {
                ws.dataArray[i].flag = [NSNumber numberWithBool:NO];
            }
        }
        
        [ws reloadData];
        
        if(ws.blockIcon)
        {
            ws.blockIcon(ws, model, indexPath);
        }
        
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if(_blockInto)
    {
        _blockInto(self, _dataArray[indexPath.row], indexPath);
    }
}



@end
