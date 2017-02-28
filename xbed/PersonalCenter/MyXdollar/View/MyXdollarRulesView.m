//
//  MyXdollarRulesView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/24.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "MyXdollarRulesView.h"

@implementation MyXdollarRulesView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = Background_Color;
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.text = @"积分规则";
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.font = FontBold(14);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(20);
            
        }];
        
        _labels = [NSMutableArray array];
        
    }
    
    return self;
}

- (void)setRules:(NSArray<NSString *> *)rules
{
    _rules = rules;
    
    if(rules==nil || rules.count==0)
    {
        self.hidden = YES;
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(0);
            
        }];
    }
    else
    {
        self.hidden = NO;
        
        CGFloat myHeight = 20+14+20;
        
        for (NSInteger i=0;i<rules.count;i++)
        {
            UILabel *label = [[UILabel alloc] init];
            label.text = rules[i];
            label.lineSpace = 4;
            label.textColor = Secondary_Text_Color;
            label.font = Font(12);
            [self addSubview:label];
            
            CGSize sizeLabel = [label labelSize:MAIN_SCREEN_WIDTH-20];
            if(i==0)
            {
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
                    make.height.mas_equalTo(sizeLabel.height);
                    make.left.mas_equalTo(10);
                    make.top.mas_equalTo(_lbTitle.mas_bottom).offset(20);
                    
                }];
                
                myHeight = myHeight+sizeLabel.height;
            }
            else
            {
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
                    make.height.mas_equalTo(sizeLabel.height);
                    make.left.mas_equalTo(10);
                    make.top.mas_equalTo(_labels[i-1].mas_bottom).offset(10);
                    
                }];
                
                myHeight = myHeight+10+sizeLabel.height;
            }
            
            [_labels addObject:label];
            
        }
        
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(myHeight);
            
        }];
        
    }
}

@end
