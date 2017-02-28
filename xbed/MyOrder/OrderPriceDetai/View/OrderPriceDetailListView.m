//
//  OrderPriceDetailListView.m
//  xbed
//
//  Created by Leo.Chen on 16/9/22.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "OrderPriceDetailListView.h"

@implementation OrderPriceDetailListView

- (instancetype)initWithRentType:(NSInteger)rentType
{
    if(self = [super init])
    {
        self.rentType = rentType;
        self.backgroundColor = [UIColor whiteColor];
        
        _lbDate = [[UILabel alloc] init];
        _lbDate.text = @"日期";
        _lbDate.textColor = Main_Text_Color;
        _lbDate.font = FontBold(14);
        [self addSubview:_lbDate];
        [_lbDate mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(48);
            make.top.mas_equalTo(20);
            
        }];
        
        _lbPrice = [[UILabel alloc] init];
        _lbPrice.text = @"房费";
        _lbPrice.textColor = Main_Text_Color;
        _lbPrice.textAlignment = NSTextAlignmentRight;
        _lbPrice.font = FontBold(14);
        [self addSubview:_lbPrice];
        [_lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(14);
            make.right.mas_equalTo(-38);
            make.top.mas_equalTo(20);
            
        }];
        
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        if(rentType==0)
        {
            [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64-(20+14+20)-(49*3+10));
                make.left.mas_equalTo(0);
                make.top.mas_equalTo(_lbDate.mas_bottom).offset(20);
                
            }];
        }
        else
        {
            [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64-(20+14+20)-(49*4+10));
                make.left.mas_equalTo(0);
                make.top.mas_equalTo(_lbDate.mas_bottom).offset(20);
                
            }];
        }
        
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = Seg_Line_Color;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_scrollView.mas_bottom).offset(0);
            
        }];
        
        
        
        
        NSString *depositTitle = @"押金 （退房后退还）";
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:depositTitle];
        [attrStr addAttribute:(NSString *)NSForegroundColorAttributeName value:Red_Color range:NSMakeRange(2, depositTitle.length-2)];
        
        _cellDeposit = [[OrderPriceDetailCell alloc] init];
        _cellDeposit.attrTitle = (NSAttributedString *)attrStr;
        [self addSubview:_cellDeposit];
        
        if(rentType==1)//长租
        {
            _cellDeposit.hidden = NO;
            [_cellDeposit mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                make.height.mas_equalTo(49);
                make.left.mas_equalTo(0);
                make.top.mas_equalTo(line.mas_bottom).offset(0);
                
            }];
        }
        else//短租 无押金
        {
            _cellDeposit.hidden = YES;
            [_cellDeposit mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.mas_equalTo(0);
                make.height.mas_equalTo(0);
                make.left.mas_equalTo(0);
                make.top.mas_equalTo(line.mas_bottom).offset(0);
                
            }];
        }
        
        
        
        
        
        _cellTotalPrice = [[OrderPriceDetailCell alloc] init];
        _cellTotalPrice.title = @"总房费";
        [self addSubview:_cellTotalPrice];
        [_cellTotalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_cellDeposit.mas_bottom).offset(0);
            
        }];
        
        _cellDiscount = [[OrderPriceDetailCell alloc] init];
        _cellDiscount.title = @"优惠";
        [self addSubview:_cellDiscount];
        [_cellDiscount mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_cellTotalPrice.mas_bottom).offset(0);
            
        }];
        
        _cellActualPrice = [[OrderPriceDetailCell alloc] init];
        _cellActualPrice.title = @"应付金额";
        _cellActualPrice.valueColor = Blue_Color;
        [self addSubview:_cellActualPrice];
        [_cellActualPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_cellDiscount.mas_bottom).offset(0);
            
        }];
        
    }
    
    return self;
}

- (void)setPayInfo:(CheckinOrderPayInfoModel *)payInfo
{
    _payInfo = payInfo;
    
    _scrollView.contentSize = CGSizeMake(MAIN_SCREEN_WIDTH, 49*payInfo.curPriceList.count);
    for (NSInteger i=0;i<payInfo.curPriceList.count;i++)
    {
        OrderPriceDetailCell *cell = [[OrderPriceDetailCell alloc] init];
        cell.title = [NSString stringWithFormat:@"%ld.%02ld.%02ld", payInfo.curPriceList[i].curDate.year, payInfo.curPriceList[i].curDate.month, payInfo.curPriceList[i].curDate.day];
        cell.value = [NSString stringWithFormat:@"￥%@", [NSNumber numberWithFloat:payInfo.curPriceList[i].price.floatValue/100]];
        [_scrollView addSubview:cell];
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(i*49);
            
        }];
    }
    
    if(payInfo.changeRoom.boolValue)
    {
        [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64-(20+14+20)-(49+10));
            
        }];
        
        [_cellDeposit mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(0);
            
        }];
        
        [_cellTotalPrice mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(0);
            
        }];
        
        [_cellDiscount mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(0);
            
        }];
        
        _cellDeposit.hidden = YES;
        _cellTotalPrice.hidden = YES;
        _cellDiscount.hidden = YES;
        _cellActualPrice.value = [NSString stringWithFormat:@"￥%@", [NSNumber numberWithFloat:payInfo.waitPay.integerValue*0.01]];
    }
    else
    {
        _cellDeposit.value = [NSString stringWithFormat:@"￥%@", [NSNumber numberWithFloat:payInfo.bargainMoney.integerValue*0.01]];
        _cellTotalPrice.value = [NSString stringWithFormat:@"￥%@", [NSNumber numberWithFloat:payInfo.price.integerValue*0.01]];
        _cellDiscount.value = [NSString stringWithFormat:@"－￥%@", [NSNumber numberWithFloat:payInfo.discount.integerValue*0.01]];
    }
}

- (void)setActualPrice:(NSNumber *)actualPrice
{
    _actualPrice = actualPrice;
    
    if(self.payInfo.changeRoom==nil || self.payInfo.changeRoom.boolValue==NO)
    {
        _cellActualPrice.value = [NSString stringWithFormat:@"￥%@", [NSNumber numberWithFloat:actualPrice.integerValue*0.01]];
    }
}


@end
