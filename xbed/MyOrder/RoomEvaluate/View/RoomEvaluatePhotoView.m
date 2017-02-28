//
//  RoomEvaluatePhotoView.m
//  xbed
//
//  Created by Leo.Chen on 2016/12/22.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomEvaluatePhotoView.h"

#define PhotoWidth (MAIN_SCREEN_WIDTH-30-20*3)/4

@implementation RoomEvaluatePhotoView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *lbTitle = [[UILabel alloc] init];
        lbTitle.text = @"有图有真相";
        lbTitle.textColor = Main_Text_Color;
        lbTitle.textAlignment = NSTextAlignmentCenter;
        lbTitle.font = FontBold(14);
        [self addSubview:lbTitle];
        [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(14);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(30);
            
        }];
        
    }
    
    return self;
}


- (void)setDataArray:(NSArray<NSString *> *)dataArray
{
    _dataArray = dataArray;
    
    if(dataArray && dataArray.count)
    {
        self.hidden = NO;
        
        for (NSInteger i=0;i<dataArray.count;i++)
        {
            NSString *url = [NSString stringWithFormat:@"%@?imageView2/2/w/150", dataArray[i]];
            
            UIImageView *imgv = [[UIImageView alloc] init];
            [imgv sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:PlaceholderImage];
            [self addSubview:imgv];
            [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.height.mas_equalTo(PhotoWidth);
                make.top.mas_equalTo(65);
                make.left.mas_equalTo(15+(PhotoWidth+20)*i);
                
            }];
        }
        
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(175);
            
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
