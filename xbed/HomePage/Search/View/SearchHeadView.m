//
//  SearchHeadView.m
//
//
//  Created by Leo.Chen on 16/7/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "SearchHeadView.h"

@implementation SearchHeadView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _searchBar = [[UIView alloc] init];
        _searchBar.backgroundColor = Background_Color;
        _searchBar.layer.masksToBounds = YES;
        _searchBar.layer.cornerRadius = 15;
        [self addSubview:_searchBar];
        [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-10-45);
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-8);
            
        }];
        
        _imgvIcon = [[UIImageView alloc] init];
        _imgvIcon.image = [UIImage imageNamed:@"ic_search_enlarge"];
        [_searchBar addSubview:_imgvIcon];
        [_imgvIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(14);
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        _tfSearch = [[UITextField alloc] init];
        _tfSearch.textColor = Main_Text_Color;
        _tfSearch.font = Font(12);
        _tfSearch.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索区域、楼宇、商圈" attributes:@{NSForegroundColorAttributeName:Secondary_Text_Color, NSFontAttributeName:Font(12)}];
        _tfSearch.clearButtonMode = UITextFieldViewModeWhileEditing;
        _tfSearch.borderStyle = UITextBorderStyleNone;
        _tfSearch.returnKeyType = UIReturnKeyDone;
        [_searchBar addSubview:_tfSearch];
        [_tfSearch mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(_imgvIcon.mas_right).offset(10);
            make.right.mas_equalTo(-5);
            make.centerY.mas_equalTo(0);
            
        }];
        [_tfSearch becomeFirstResponder];
        
        
        _btnCancel = [[UIButton alloc] init];
        [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [_btnCancel setTitleColor:Main_Text_Color forState:UIControlStateNormal];
        _btnCancel.titleLabel.font = Font(13);
        [self addSubview:_btnCancel];
        [_btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(45);
            make.height.mas_equalTo(30);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-8);
            
        }];
        
        
    }
    
    return self;
}

@end
