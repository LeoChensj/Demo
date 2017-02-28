//
//  RoomImagesView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/4.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomImagesView.h"

@implementation RoomImagesView

- (instancetype)init
{
    if(self = [super initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, RoomImagesViewHeight)])
    {
        self.backgroundColor = Background_Color;
        self.interval = 4;
        self.placeholderImage = PlaceholderImage;
        
        _lbIndex = [[UILabel alloc] init];
        _lbIndex.textColor = [UIColor whiteColor];
        _lbIndex.textAlignment = NSTextAlignmentRight;
        _lbIndex.font = Font(12);
        [self addSubview:_lbIndex];
        [_lbIndex mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(88);
            make.height.mas_equalTo(12);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-15);
            
        }];
        _lbIndex.hidden = YES;
        
    }
    
    return self;
}

- (void)setIndex:(NSInteger)index
{
    [super setIndex:index];
    
    _lbIndex.text = [NSString stringWithFormat:@"%ld / %ld", index+1, self.pageCount];
}

- (void)setDataArray2:(NSArray<NSString *> *)dataArray2
{
    [super setDataArray2:dataArray2];
    
    if(dataArray2 && dataArray2.count>0)
    {
        self.hidden = NO;
        _lbIndex.hidden = NO;
    }
    else
    {
        self.hidden = YES;
        _lbIndex.hidden = YES;
    }
}

- (UIImage *)coverImage
{
    UIImage *image = nil;
    
    if(self.dataArray2.count)
    {
        NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:self.dataArray2[0]]];
        image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:key];
    }
    
    return image;
}


@end
