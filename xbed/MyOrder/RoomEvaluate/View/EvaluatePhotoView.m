//
//  EvaluatePhotoView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "EvaluatePhotoView.h"
#import "PhotoAlbumUtil.h"

@implementation EvaluatePhotoView

- (instancetype)initWithViewController:(XbedViewController *)viewController
{
    if(self = [super init])
    {
        self.viewController = viewController;
        
        self.backgroundColor = [UIColor whiteColor];
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.text = @"有图有真相";
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.font = FontBold(14);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(14);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(30);
            
        }];
        
        _lbRemind = [[UILabel alloc] init];
        _lbRemind.text = @"最多支持四张图";
        _lbRemind.textColor = Secondary_Text_Color2;
        _lbRemind.textAlignment = NSTextAlignmentCenter;
        _lbRemind.font = Font(12);
        [self addSubview:_lbRemind];
        [_lbRemind mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(12);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(_lbTitle.mas_bottom).offset(10);
            
        }];
        
        _photoSelectView = [[PhotoSelectView alloc] initWithViewController:self.viewController];
        [self addSubview:_photoSelectView];
        [_photoSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(PhotoSelectCellWidth);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_lbRemind.mas_bottom).offset(20);
            
        }];
        
        
        
        WS(ws);
        [RACObserve(_photoSelectView, images) subscribeNext:^(NSArray <UIImage *>*x) {
            
            NSMutableArray <NSData *>*mArray = [NSMutableArray array];
            for (NSInteger i=0;i<x.count;i++)
            {
                NSData *data = [PhotoAlbumUtil dataFromImage:[PhotoAlbumUtil imageWithImage:x[i] scaledToSize:CGSizeMake(500, 500)]];
                [mArray addObject:data];
            }
            ws.datas = mArray;
            
        }];
        
    }
    
    return self;
}

@end
