//
//  PriceView.m
//  xbed
//
//  Created by Leo.Chen on 16/7/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "PriceView.h"

@implementation PriceView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        
        _lbRMB = [[UILabel alloc] init];
        _lbRMB.text = @"￥";
        _lbRMB.textColor = [UIColor whiteColor];
        _lbRMB.font = Font(12);
        [self addSubview:_lbRMB];
        [_lbRMB mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(12);
            make.left.mas_equalTo(15);
            make.bottom.mas_equalTo(-10);
            
        }];
        
        _lbPrice = [[UILabel alloc] init];
        _lbPrice.textColor = [UIColor whiteColor];
        _lbPrice.font = Font(18);
        [self addSubview:_lbPrice];
        [_lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(18);
            make.left.mas_equalTo(_lbRMB.mas_right).offset(0);
            make.bottom.mas_equalTo(-10);
            
        }];
        
        
    }
    
    return self;
}

- (void)setPrice:(NSNumber *)price
{
    _price = price;
    
    if(price)
    {
        self.hidden = NO;
        
        NSNumber *priceRMB = [NSNumber numberWithFloat:price.floatValue*0.01];
        
        if(self.rentType==0)
        {
            _lbPrice.text = [NSString stringWithFormat:@"%@", priceRMB];
        }
        else
        {
            _lbPrice.text = [NSString stringWithFormat:@"%@/月", priceRMB];
        }
        
        CGSize priceSize = [_lbPrice labelSize:100];
        [_lbPrice mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(priceSize.width+5);
            
        }];
        
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(5+15+12+priceSize.width+5+5);
            
        }];
    }
    else
    {
        self.hidden = YES;
    }
}

- (void)setRentType:(NSInteger)rentType
{
    _rentType = rentType;
    
    if(self.price)
    {
        NSNumber *priceRMB = [NSNumber numberWithFloat:self.price.floatValue*0.01];
        
        if(rentType==0)
        {
            _lbPrice.text = [NSString stringWithFormat:@"%@", priceRMB];
        }
        else
        {
            _lbPrice.text = [NSString stringWithFormat:@"%@/月", priceRMB];
        }
        
        CGSize priceSize = [_lbPrice labelSize:100];
        [_lbPrice mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(priceSize.width+5);
            
        }];
        
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(5+15+12+priceSize.width+5+5);
            
        }];
    }
}





@end
