//
//  SearchLocateView.m
//  xbed
//
//  Created by Leo.Chen on 16/7/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "SearchLocateView.h"
#import "LocateUtil.h"

@implementation SearchLocateView

- (instancetype)init
{
    if(self = [super init])
    {
        self.normalColor = [UIColor whiteColor];
        self.touchColor = White_Click_COLOR;
        
        _imgvLocate = [[UIImageView alloc] init];
        _imgvLocate.image = [UIImage imageNamed:@"ic_search_nearest"];
        [self addSubview:_imgvLocate];
        [_imgvLocate mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(16);
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.text = @"搜索附近房源";
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.font = Font(13);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(_imgvLocate.mas_right).offset(10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        _imgvArrow = [[UIImageView alloc] init];
        _imgvArrow.image = [UIImage imageNamed:@"ic_search_into"];
        [self addSubview:_imgvArrow];
        [_imgvArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(8);
            make.height.mas_equalTo(14);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        _lbCity = [[UILabel alloc] init];
        _lbCity.textColor = Secondary_Text_Color;
        _lbCity.textAlignment = NSTextAlignmentRight;
        _lbCity.font = Font(13);
        [self addSubview:_lbCity];
        [_lbCity mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(20);
            make.right.mas_equalTo(_imgvArrow.mas_left).offset(-10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        WS(ws);
        [RACObserve([LocateUtil getInstance], locality) subscribeNext:^(NSString *x) {
            
            if(x && x.length>0)
            {
                ws.lbCity.text = x;
                ws.locateCity = x;
                ws.enabled = YES;
            }
            else
            {
                ws.enabled = NO;
            }
            
        }];
        
        RAC(self, longitude) = RACObserve([LocateUtil getInstance], longitude);
        RAC(self, latitude) = RACObserve([LocateUtil getInstance], latitude);
        
    }
    
    return self;
}


- (void)startLocate
{
    LocateUtil *locateUtil = [LocateUtil getInstance];
    [locateUtil startLocate];
}







@end
