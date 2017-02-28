//
//  PhotoSelectCell.m
//  xbed
//
//  Created by Leo.Chen on 16/8/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "PhotoSelectCell.h"

@implementation PhotoSelectCell

- (instancetype)init
{
    if(self = [super init])
    {
        _imgvPhoto = [[UIImageView alloc] init];
        _imgvPhoto.clipsToBounds = YES;
        _imgvPhoto.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imgvPhoto];
        [_imgvPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(self.mas_width);
            make.height.mas_equalTo(self.mas_height);
            make.left.top.mas_equalTo(0);
            
        }];
        
        _imgvDelete = [[UIImageView alloc] init];
        _imgvDelete.image = [UIImage imageNamed:@"ic_evaluate_delete"];
        [self addSubview:_imgvDelete];
        [_imgvDelete mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(13);
            make.centerX.mas_equalTo(self.mas_right).offset(0);
            make.centerY.mas_equalTo(self.mas_top).offset(0);
            
        }];
        
        
        _btnDelete = [[UIButton alloc] init];
        [self addSubview:_btnDelete];
        [_btnDelete mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(50);
            make.top.right.mas_equalTo(0);
            
        }];
        
        WS(ws);
        [[_btnDelete rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            if(ws.block)
            {
                ws.block(ws);
            }
            
        }];
        
    }
    
    return self;
}

- (void)addPhotoSelectCellDeleteBlock:(PhotoSelectCellDeleteBlock)block
{
    _block = block;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    _imgvPhoto.image = image;
}

@end
