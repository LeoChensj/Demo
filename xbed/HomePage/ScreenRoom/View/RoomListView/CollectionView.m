//
//  CollectionView.m
//  xbed
//
//  Created by Leo.Chen on 16/7/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CollectionView.h"

@implementation CollectionView

- (instancetype)init
{
    if(self = [super init])
    {
        _imgvIcon = [[UIImageView alloc] init];
        [self addSubview:_imgvIcon];
        [_imgvIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(29);
            make.height.mas_equalTo(25);
            make.center.mas_equalTo(0);
            
        }];
        
        WS(ws);
        
        [RACObserve(self, states) subscribeNext:^(NSNumber *x) {
            
            if(x.integerValue==1)
            {
                ws.imgvIcon.image = [UIImage imageNamed:ws.collectionImage];
            }
            else
            {
                ws.imgvIcon.image = [UIImage imageNamed:ws.normalImage];
            }
            
        }];
        
        
        [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            [ws changeStatesWithAnimate:YES];
            
            //self.enabled = NO;
            
            if(!ws.flag)
            {
                ws.flag = YES;
                
                if([DBManager getInstance].isLogin)//已登录
                {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        if(ws.block)
                        {
                            ws.block(ws, (ws.states==1));
                        }
                        
                        ws.flag = NO;
                        
                    });
                }
                else//未登录
                {
                    [ws changeStatesWithAnimate:YES];
                    
                    if(ws.block)
                    {
                        ws.block(ws, (_states==1));
                    }
                    
                    ws.flag = NO;
                }
                
            }
            
        }];
        
    }
    
    return self;
}


- (void)addCollectionViewTouchBlock:(CollectionViewTouchBlock)block
{
    _block = block;
}

- (void)changeStatesWithAnimate:(BOOL)animate
{
    self.states = (_states+1)%2;
    
    if(animate)
    {
        [UIView animateWithDuration:0.1 animations:^{
            
            _imgvIcon.transform = CGAffineTransformMakeScale(1.3, 1.3);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.1 animations:^{
                
                _imgvIcon.transform = CGAffineTransformMakeScale(1, 1);
                
            }];
            
        }];
    }
}

@end
