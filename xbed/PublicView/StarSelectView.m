//
//  StarSelectView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "StarSelectView.h"

@implementation StarSelectView

- (instancetype)init
{
    if(self = [super init])
    {
        self.clipsToBounds = YES;
        
        _starArray = [NSMutableArray arrayWithCapacity:5];
        
        _enable = YES;
        
        for (NSInteger i=0;i<5;i++)
        {
            NSInteger offset = i-2;
            
            LeoRadioButton *star = [[LeoRadioButton alloc] init];
            star.tag = 372+i;
            star.normalImage = [UIImage imageNamed:@"ic_start_not_click"];
            star.selectImage = [UIImage imageNamed:@"ic_start_click"];
            [self addSubview:star];
            [star mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.height.mas_equalTo(28);
                make.top.mas_equalTo(0);
                make.centerX.mas_equalTo(offset*38);
                
            }];
            
            [star addTarget:self action:@selector(starValueChangedFunc:) forControlEvents:UIControlEventValueChanged];
            
            [_starArray addObject:star];
        }
        
        
        _lbValue = [[UILabel alloc] init];
        _lbValue.textColor = Orange_Color;
        _lbValue.textAlignment = NSTextAlignmentCenter;
        _lbValue.font = Font(10);
        [self addSubview:_lbValue];
        [_lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(10);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(_starArray[0].mas_bottom).offset(20);
            
        }];
        
        
        WS(ws);
        
        _signalSelect = [RACSignal combineLatest:@[RACObserve(self, star)] reduce:^id(NSNumber *star){
            
            return @(star!=nil);
            
        }];
        
        
        [_signalSelect subscribeNext:^(NSNumber *x) {
            
            if(x.boolValue)
            {
                ws.lbValue.hidden = NO;
                
                if(ws.star.integerValue==1)
                {
                    ws.lbValue.text = @"不爽";
                }
                else if(ws.star.integerValue==2)
                {
                    ws.lbValue.text = @"有瑕疵，需要改进";
                }
                else if(ws.star.integerValue==3)
                {
                    ws.lbValue.text = @"还过得去";
                }
                else if(ws.star.integerValue==4)
                {
                    ws.lbValue.text = @"还可以，请保持";
                }
                else if(_star.integerValue==5)
                {
                    ws.lbValue.text = @"很棒，鼓励一下";
                }
                
                
                [ws mas_updateConstraints:^(MASConstraintMaker *make) {
                    
                    make.height.mas_equalTo(28+30);
                    
                }];
                
            }
            else
            {
                ws.lbValue.hidden = YES;
            }
            
        }];
        
        
        
    }
    
    return self;
}



- (void)starValueChangedFunc:(LeoRadioButton *)button
{
    NSInteger index = button.tag-372;
    NSInteger star = index+1;
    
    self.star = [NSNumber numberWithInteger:star];
}


- (void)setStar:(NSNumber *)star
{
    _star = star;
    
    if(star)
    {
        for (NSInteger i=0;i<5;i++)
        {
            if(i<=(star.integerValue-1))
            {
                _starArray[i].on = YES;
            }
            else
            {
                _starArray[i].on = NO;
            }
        }
    }
}


- (void)setEnable:(BOOL)enable
{
    _enable = enable;
    
    for (NSInteger i=0;i<5;i++)
    {
        _starArray[i].enabled = enable;
    }
}


@end
