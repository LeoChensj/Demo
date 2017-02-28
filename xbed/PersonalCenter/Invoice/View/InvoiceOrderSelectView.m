//
//  InvoiceOrderSelectView.m
//  xbed
//
//  Created by Leo.Chen on 2016/12/5.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "InvoiceOrderSelectView.h"

@implementation InvoiceOrderSelectHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithReuseIdentifier:reuseIdentifier])
    {
        _vWhite = [[UIView alloc] init];
        _vWhite.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_vWhite];
        [_vWhite mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(34);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(10);
            
        }];
        
        _btnSelect = [[LeoRadioButton alloc] init];
        _btnSelect.normalImage = [UIImage imageNamed:@"ic_inoive_uncheck"];
        _btnSelect.selectImage = [UIImage imageNamed:@"ic_inoive_check"];
        [_vWhite addSubview:_btnSelect];
        [_btnSelect mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(18);
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        WS(ws);
        [[_btnSelect rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(LeoRadioButton *x) {
            
            if(ws.block)
            {
                ws.block(ws, x.on);
            }
            
        }];
        
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.font = Font(14);
        [_vWhite addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-38-10);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(_btnSelect.mas_right).offset(10);
            make.centerY.mas_equalTo(0);
            
        }];
        
    }
    
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _lbTitle.text = title;
}
- (void)setState:(BOOL)state
{
    _btnSelect.on = state;
}

- (void)addInvoiceOrderSelectHeaderViewSelectBlock:(InvoiceOrderSelectHeaderViewSelectBlock)block
{
    self.block = block;
}

@end






@implementation InvoiceOrderSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *selectedBackgroundView = [[UIView alloc] init];
        selectedBackgroundView.backgroundColor = White_Click_COLOR;
        self.selectedBackgroundView = selectedBackgroundView;
        
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = Seg_Line_Color;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            
        }];
        
        
        _imgvRoom = [[UIImageView alloc] init];
        _imgvRoom.clipsToBounds = YES;
        _imgvRoom.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_imgvRoom];
        [_imgvRoom mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(135);
            make.height.mas_equalTo(135*2/3);
            make.left.mas_equalTo(38);
            make.top.mas_equalTo(line.mas_bottom).offset(10);
            
        }];
        
        
        _lbDate = [[UILabel alloc] init];
        _lbDate.textColor = Main_Text_Color;
        _lbDate.font = Font(14);
        [self.contentView addSubview:_lbDate];
        [_lbDate mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-38-135-10-10);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(_imgvRoom.mas_right).offset(10);
            make.top.mas_equalTo(line.mas_bottom).offset(10);
            
        }];
        
        
        _lbDesc = [[UILabel alloc] init];
        _lbDesc.textColor = Secondary_Text_Color2;
        _lbDesc.font = Font(12);
        [self.contentView addSubview:_lbDesc];
        [_lbDesc mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-38-135-10-10);
            make.height.mas_equalTo(12);
            make.left.mas_equalTo(_imgvRoom.mas_right).offset(10);
            make.top.mas_equalTo(_lbDate.mas_bottom).offset(10);
            
        }];
        
        
        _lbPrice = [[UILabel alloc] init];
        _lbPrice.textColor = Main_Text_Color;
        _lbPrice.font = Font(14);
        [self.contentView addSubview:_lbPrice];
        [_lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-38-135-10-10);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(_imgvRoom.mas_right).offset(10);
            make.bottom.mas_equalTo(_imgvRoom.mas_bottom).offset(0);
            
        }];
    }
    
    return self;
}

- (void)setModel:(CheckinOrderListModel *)model
{
    _model = model;
    
    [_imgvRoom sd_setImageWithURL:[NSURL URLWithString:model.roomInfo.picture] placeholderImage:PlaceholderImage];
    
    
    NSDate *checkinDate = [CalendarHandle dateHandle2:model.checkinDate];
    NSDate *checkoutDate = [CalendarHandle dateHandle2:model.checkoutDate];
    NSInteger dayNight = 0;
    if([checkinDate isEqualToDay:checkoutDate])
    {
        dayNight = 1;
    }
    else
    {
        dayNight = [CalendarHandle dayNightFromStart:checkinDate End:checkoutDate];
    }
    _lbDate.text = [NSString stringWithFormat:@"%02ld/%02ld-%02ld/%02ld 共%ld晚", checkinDate.month, checkinDate.day, checkoutDate.month, checkoutDate.day, dayNight];
    
    
    if(model.roomInfo.roomFloor)
    {
        _lbDesc.text = [NSString stringWithFormat:@"%@楼%@", model.roomInfo.roomFloor, model.roomInfo.custRoomNo];
    }
    else
    {
        _lbDesc.text = [NSString stringWithFormat:@"%@", model.roomInfo.custRoomNo];
    }
    
    
    _lbPrice.text = [NSString stringWithFormat:@"应付金额：￥%@", [NSNumber numberWithFloat:model.price.floatValue/100]];
}

@end









@implementation InvoiceOrderSelectView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = Background_Color;
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
        self.showsVerticalScrollIndicator = NO;
        self.allowsSelection = NO;
        
        
        WS(ws);
        _footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            NSLog(@"加载更多");
            
            if(ws.loadmoreBlock)
            {
                ws.loadmoreBlock(ws.footer);
            }
            
        }];
        _footer.stateLabel.textColor = Secondary_Text_Color2;
        [_footer setTitle:@"加载更多..." forState:MJRefreshStateRefreshing];
        [_footer setTitle:@"" forState:MJRefreshStateIdle];
        self.mj_footer = _footer;
        
        
        self.selectOrder = [NSMutableArray array];
        self.invoicePrice = 0;
    }
    
    return self;
}

- (void)setDataArray:(NSArray<OrderListContnetModel *> *)dataArray
{
    _dataArray = dataArray;
    
    [self reloadData];
}

- (void)addInvoiceOrderSelectViewLoadmoreBlock:(InvoiceOrderSelectViewLoadmoreBlock)loadmoreBlock
{
    self.loadmoreBlock = loadmoreBlock;
}



#pragma - TableView DataSourse Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray[section].checkinOrderList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10+34;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headIdentifier = @"head";
    InvoiceOrderSelectHeaderView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headIdentifier];
    
    if(headView==nil)
    {
        headView = [[InvoiceOrderSelectHeaderView alloc] initWithReuseIdentifier:headIdentifier];
    }
    
    return headView;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(InvoiceOrderSelectHeaderView *)view forSection:(NSInteger)section
{
    view.tintColor = Background_Color;
    view.title = _dataArray[section].checkinOrderList[0].roomInfo.custRoomName;
    view.state = _dataArray[section].state.boolValue;
    
    //重要
    WS(ws);
    [view addInvoiceOrderSelectHeaderViewSelectBlock:^(InvoiceOrderSelectHeaderView *view, BOOL state) {
        
        ws.dataArray[section].state = [NSNumber numberWithBool:state];
        
        if(state)
        {
            [ws.selectOrder addObject:ws.dataArray[section]];
            ws.invoicePrice = [NSNumber numberWithInteger:ws.invoicePrice.integerValue+ws.dataArray[section].checkinOrderList[0].price.integerValue];
        }
        else
        {
            [ws.selectOrder removeObject:ws.dataArray[section]];
            ws.invoicePrice = [NSNumber numberWithInteger:ws.invoicePrice.integerValue-ws.dataArray[section].checkinOrderList[0].price.integerValue];
        }
        
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    InvoiceOrderSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[InvoiceOrderSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(InvoiceOrderSelectCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.model = _dataArray[indexPath.section].checkinOrderList[indexPath.row];
}


//取消表头悬停
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //去掉UItableview的section的headerview黏性
    CGFloat sectionHeaderHeight = 10+34;
    if (scrollView.contentOffset.y<=sectionHeaderHeight && scrollView.contentOffset.y>=0)
    {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 40, 0);
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight)
    {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 40, 0);
    }
}




@end










