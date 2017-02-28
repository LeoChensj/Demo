//
//  OrderDetailPriceView.m
//  xbed
//
//  Created by Leo.Chen on 16/9/21.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "OrderDetailPriceView.h"

@implementation OrderDetailPriceView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        
        NSString *depositTitle = @"押金 （退房后退还）";
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:depositTitle];
        [attrStr addAttribute:(NSString *)NSForegroundColorAttributeName value:Red_Color range:NSMakeRange(2, depositTitle.length-2)];
        
        _cellDeposit = [[OrderDetailPriceCell alloc] init];
        _cellDeposit.attrTitle = (NSAttributedString *)attrStr;
        [self addSubview:_cellDeposit];
        [_cellDeposit mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.top.mas_equalTo(0);
            
        }];
        
        _cellTotalPrice = [[OrderDetailPriceCell alloc] init];
        _cellTotalPrice.title = @"总房费";
        _cellTotalPrice.haveLine = NO;
        [self addSubview:_cellTotalPrice];
        [_cellTotalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_cellDeposit.mas_bottom).offset(0);
            
        }];
        
        _cellDiscount = [[OrderDetailPriceCell alloc] init];
        _cellDiscount.title = @"优惠";
        _cellDiscount.haveLine = YES;
        [self addSubview:_cellDiscount];
        [_cellDiscount mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_cellTotalPrice.mas_bottom).offset(0);
            
        }];
        
        _cellActualPrice = [[OrderDetailPriceCell alloc] init];
        _cellActualPrice.title = @"应付金额";
        _cellActualPrice.valueColor = Blue_Color;
        _cellActualPrice.haveLine = NO;
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
    
    if(payInfo.changeRoom.boolValue)
    {
        _cellTotalPrice.hidden = YES;
        _cellDiscount.hidden = YES;
        
        [_cellTotalPrice mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(0);
            
        }];
        
        [_cellDiscount mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(0);
            
        }];
        
        _cellActualPrice.value = [NSString stringWithFormat:@"￥%@", [NSNumber numberWithFloat:payInfo.waitPay.integerValue*0.01]];
    }
    else
    {
        _cellTotalPrice.hidden = NO;
        _cellDiscount.hidden = NO;
        
        [_cellTotalPrice mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(49);
            
        }];
        
        [_cellDiscount mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(49);
            
        }];
        
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
- (void)setRentType:(NSInteger)rentType
{
    _rentType = rentType;
    
    if(rentType==0)//短租
    {
        _cellDeposit.hidden = YES;
        [_cellDeposit mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(0);
            
        }];
    }
    else
    {
        _cellDeposit.hidden = NO;
        [_cellDeposit mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(49);
            
        }];
    }
}
- (void)setOrderType:(NSNumber *)orderType
{
    _orderType = orderType;
    
    if(orderType)
    {
        if(orderType.integerValue==0)//已取消
        {
            self.hidden = NO;
            
            _cellTotalPrice.hidden = YES;
            _cellDiscount.hidden = YES;
            
            [_cellTotalPrice mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.height.mas_equalTo(0);
                
            }];
            
            [_cellDiscount mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.height.mas_equalTo(0);
                
            }];
            
            if(self.rentType==0)
            {
                _myHeight = 49;
            }
            else
            {
                _myHeight = 49*2;
            }
            
            
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.height.mas_equalTo(_myHeight);
                
            }];
        }
        else if(orderType.integerValue==1)//待支付
        {
            self.hidden = NO;
            
            if(self.payInfo.changeRoom.boolValue)
            {
                _cellTotalPrice.hidden = YES;
                _cellDiscount.hidden = YES;
                
                [_cellTotalPrice mas_updateConstraints:^(MASConstraintMaker *make) {
                    
                    make.height.mas_equalTo(0);
                    
                }];
                
                [_cellDiscount mas_updateConstraints:^(MASConstraintMaker *make) {
                    
                    make.height.mas_equalTo(0);
                    
                }];
                
                if(self.rentType==0)
                {
                    _myHeight = 49;
                }
                else
                {
                    _myHeight = 49*2;
                }
            }
            else
            {
                _cellTotalPrice.hidden = NO;
                _cellDiscount.hidden = NO;
                
                [_cellTotalPrice mas_updateConstraints:^(MASConstraintMaker *make) {
                    
                    make.height.mas_equalTo(49);
                    
                }];
                
                [_cellDiscount mas_updateConstraints:^(MASConstraintMaker *make) {
                    
                    make.height.mas_equalTo(49);
                    
                }];
                
                if(self.rentType==0)
                {
                    _myHeight = 49*3;
                }
                else
                {
                    _myHeight = 49*4;
                }
            }
            
            
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.height.mas_equalTo(_myHeight);
                
            }];
        }
        else
        {
            self.hidden = YES;
        }
    }
}



@end
