//
//  RoomPriceAnnotationView.m
//  xbed
//
//  Created by Leo.Chen on 16/7/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomPriceAnnotationView.h"

@implementation RoomPriceAnnotationView

@synthesize selected = _selected;

- (id)initWithAnnotation:(id <MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier])
    {
        self.image = [UIImage imageNamed:@"pic_price_box"];//138*81pic_price_box_select
        self.centerOffset = CGPointMake(0, -20);
        
        _lbPrice = [[UILabel alloc] init];
        _lbPrice.textColor = [UIColor whiteColor];
        _lbPrice.textAlignment = NSTextAlignmentCenter;
        _lbPrice.font = Font(14);
        [self addSubview:_lbPrice];
        [_lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(20);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(6);
            
        }];
        
    }
    
    return self;
}


- (void)setPrice:(NSNumber *)price
{
    _price = price;
    
    NSString *priceStr = [NSString stringWithFormat:@"￥%@起", price];
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:priceStr];
    [attString addAttribute:(NSString *)NSFontAttributeName value:Font(10) range:NSMakeRange(0, 1)];
    [attString addAttribute:(NSString *)NSFontAttributeName value:Font(10) range:NSMakeRange(priceStr.length-1, 1)];
    
    _lbPrice.attributedText = attString;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    
    if(selected)
    {
        self.image = [UIImage imageNamed:@"pic_price_box_select"];
    }
    else
    {
        self.image = [UIImage imageNamed:@"pic_price_box"];
    }
}


@end
