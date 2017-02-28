//
//  CardIdPhotoView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CardIdPhotoView.h"
#import "PhotoAlbumUtil.h"

@implementation CardIdPhotoView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = Background_Color;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 3;
        
        _imgvAddPhoto = [[UIImageView alloc] init];
        _imgvAddPhoto.image = [UIImage imageNamed:@"ic_add"];
        [self addSubview:_imgvAddPhoto];
        [_imgvAddPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(50);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(self.mas_centerY).offset(-42);
            
        }];
        
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = Secondary_Text_Color2;
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.font = Font(13);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(13);
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(self.mas_centerY).offset(42);
            
        }];
        
        
        _lbDesc = [[UILabel alloc] init];
        _lbDesc.text = @"仅用于公安部审核";
        _lbDesc.textColor = Red_Color;
        _lbDesc.textAlignment = NSTextAlignmentCenter;
        _lbDesc.font = Font(12);
        [self addSubview:_lbDesc];
        [_lbDesc mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(110);
            make.height.mas_equalTo(12);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(_lbTitle.mas_bottom).offset(15);
            
        }];
        
        
        _imgvPhoto = [[UIImageView alloc] init];
        _imgvPhoto.backgroundColor = [UIColor clearColor];
        _imgvPhoto.clipsToBounds = YES;
        _imgvPhoto.contentMode = UIViewContentModeScaleAspectFill;
        _imgvPhoto.layer.masksToBounds = YES;
        _imgvPhoto.layer.cornerRadius = 3;
        [self addSubview:_imgvPhoto];
        [_imgvPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(self.mas_width);
            make.height.mas_equalTo(self.mas_height);
            make.center.mas_equalTo(0);
            
        }];
        
        
        
        WS(ws);
        [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            PhotoAlbumUtil *photoAlbumUtil = [PhotoAlbumUtil getInstance];
            photoAlbumUtil.title = @"选择图片";
            photoAlbumUtil.allowsEditing = YES;
            [photoAlbumUtil selectTakePhotoOrAlbum];
            [photoAlbumUtil addPhotoAlbumUtilBlock:^(UIImage * _Nullable image) {
                
                ws.imgvPhoto.hidden = NO;
                ws.imgvAddPhoto.hidden = YES;
                ws.lbTitle.hidden = YES;
                ws.lbDesc.hidden = YES;
                
                ws.image = ws.imgvPhoto.image = image;
                [ws addWatermarkImageView];
                
            }];
            
        }];
        
    }
    
    return self;
}



- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _lbTitle.text = title;
}

- (void)setPhoto:(NSString *)photo
{
    _photo = photo;
    
    if(photo && photo.length>0)
    {
        _imgvPhoto.hidden = NO;
        _imgvAddPhoto.hidden = YES;
        _lbTitle.hidden = YES;
        _lbDesc.hidden = YES;
        
        WS(ws);
        [_imgvPhoto sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:PlaceholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            //加水印
            if(image)
            {
                [ws addWatermarkImageView];
            }
            
        }];
    }
    else
    {
        _imgvPhoto.hidden = YES;
        _imgvAddPhoto.hidden = NO;
        _lbTitle.hidden = NO;
        _lbDesc.hidden = NO;
    }
}

//加水印
- (void)addWatermarkImageView
{
    for (UIImageView *imgv in _imgvPhoto.subviews)
    {
        [imgv removeFromSuperview];
    }
    
    UIImageView *imgvWatermark = [[UIImageView alloc] init];
    imgvWatermark.image = [UIImage imageNamed:@"pic_id_card"];
    imgvWatermark.clipsToBounds = YES;
    imgvWatermark.contentMode = UIViewContentModeScaleAspectFill;
    imgvWatermark.layer.masksToBounds = YES;
    imgvWatermark.layer.cornerRadius = 3;
    [_imgvPhoto addSubview:imgvWatermark];
    [imgvWatermark mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(self.mas_height);
        make.center.mas_equalTo(0);
        
    }];
}

@end
