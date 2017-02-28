//
//  IssueInvoiceInfoView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/30.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "IssueInvoiceInfoView.h"

@implementation IssueInvoiceInfoView

- (instancetype)init
{
    if(self = [super init])
    {
        self.normalColor = [UIColor whiteColor];
        self.touchColor = White_Click_COLOR;
        
        UILabel *lbTitle = [[UILabel alloc] init];
        lbTitle.text = @"发票信息";
        lbTitle.textColor = Main_Text_Color;
        lbTitle.font = Font(13);
        [self addSubview:lbTitle];
        [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(15);
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textAlignment = NSTextAlignmentRight;
        _lbTitle.textColor = Secondary_Text_Color;
        _lbTitle.font = Font(13);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-70-27);
            make.height.mas_equalTo(13);
            make.right.mas_equalTo(-27);
            make.top.mas_equalTo(8);
            
        }];
        
        _lbPerson = [[UILabel alloc] init];
        _lbPerson.textAlignment = NSTextAlignmentRight;
        _lbPerson.textColor = Secondary_Text_Color;
        _lbPerson.font = Font(13);
        [self addSubview:_lbPerson];
        [_lbPerson mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-70-27);
            make.height.mas_equalTo(13);
            make.right.mas_equalTo(-27);
            make.bottom.mas_equalTo(-8);
            
        }];
        
        
        UIImageView *imgvArrow = [[UIImageView alloc] init];
        imgvArrow.image = [UIImage imageNamed:@"ic_search_into"];
        [self addSubview:imgvArrow];
        [imgvArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(8);
            make.height.mas_equalTo(14);
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-10);
            
        }];
        
    }
    
    return self;
}

- (void)setModel:(InvoiceModel *)model
{
    _model = model;
    
    if(model)
    {
        _lbTitle.text = model.title;
        _lbPerson.text = model.realname;
    }
    else
    {
        _lbTitle.text = @"发票抬头";
        _lbPerson.text = @"收件人";
    }
}

@end
