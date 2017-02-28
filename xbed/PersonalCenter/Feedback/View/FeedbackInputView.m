//
//  FeedbackInputView.m
//  xbed
//
//  Created by Leo.Chen on 16/9/24.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "FeedbackInputView.h"

@implementation FeedbackInputView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _textView = [[FSTextView alloc] init];
        _textView.textColor = Main_Text_Color;
        _textView.font = Font(13);
        _textView.placeholder = @"请输入您的意见（500字以内）";
        _textView.placeholderColor = Secondary_Text_Color2;
        _textView.placeholderFont = Font(13);
        _textView.returnKeyType = UIReturnKeyDefault;
        _textView.maxLength = 500;
        [self addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(5);
            make.right.mas_equalTo(-5);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(-(10+12+5));
            
        }];
        
        _lbRemind = [[UILabel alloc] init];
        _lbRemind.text = @"0/500";
        _lbRemind.textColor = Secondary_Text_Color2;
        _lbRemind.textAlignment = NSTextAlignmentRight;
        _lbRemind.font = Font(12);
        [self addSubview:_lbRemind];
        [_lbRemind mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(12);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-10);
            
        }];
        
        
        WS(ws);
        [_textView addTextDidChangeHandler:^(FSTextView *textView) {
            
            ws.content = textView.text;
            
            ws.lbRemind.text = [NSString stringWithFormat:@"%ld/500", textView.text.length];
            
        }];
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [super layoutIfNeeded];
}

@end
