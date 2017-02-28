//
//  RoomEvaluateContentView.m
//  xbed
//
//  Created by Leo.Chen on 2016/12/22.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomEvaluateContentView.h"

@implementation RoomEvaluateContentView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = Background_Color;
        
        UIImageView *imgv1 = [[UIImageView alloc] init];
        imgv1.image = [UIImage imageNamed:@"pic_comment_quotes_left"];
        [self addSubview:imgv1];
        [imgv1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(17);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(10);
            
        }];
        
        UIImageView *imgv2 = [[UIImageView alloc] init];
        imgv2.image = [UIImage imageNamed:@"pic_comment_quotes_right"];
        [self addSubview:imgv2];
        [imgv2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(17);
            make.height.mas_equalTo(14);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(-10);
            
        }];
        
        
        _lbContent = [[UILabel alloc] init];
        _lbContent.numberOfLines = 0;
        _lbContent.textColor = Main_Text_Color;
        _lbContent.textAlignment = NSTextAlignmentCenter;
        _lbContent.font = Font(13);
        [self addSubview:_lbContent];
        [_lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-120);
            make.height.mas_equalTo(13);
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            
        }];
        
    }
    
    return self;
}

- (void)setContent:(NSString *)content
{
    _content = content;
    
    if(content && content.length)
    {
        self.hidden = NO;
        
        _lbContent.text = content;
        _lbContent.lineSpace = 3;
        CGSize size = [_lbContent labelSize:(MAIN_SCREEN_WIDTH-120)];
        [_lbContent mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(size.height);
            
        }];
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(size.height+100);
            
        }];
    }
    else
    {
        self.hidden = YES;
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(0);
            
        }];
    }
}



@end
