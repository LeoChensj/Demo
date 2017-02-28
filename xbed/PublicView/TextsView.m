//
//  TextsView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/9.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "TextsView.h"
#import "HTMLReader.h"

@implementation TextsView

- (instancetype)init
{
    if(self = [super init])
    {
        _tvArray = [NSMutableArray array];
    }
    
    return self;
}


- (void)setContent:(NSString *)content
{
    _content = content;
    
    if(content && content.length>0)
    {
        HTMLDocument *document = [HTMLDocument documentWithString:content];
        NSArray <HTMLElement *>*contentArr = [document nodesMatchingSelector:@"span"];
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger i=0;i<contentArr.count;i++)
        {
            [array addObject:contentArr[i].textContent];
        }
        
        [self setupContentArray:array];
    }
}

- (void)setContent2:(NSString *)content2
{
    _content2 = content2;
    
    if(content2 && content2.length>0)
    {
        HTMLDocument *document = [HTMLDocument documentWithString:content2];
        NSArray <HTMLElement *>*contentArr = [document nodesMatchingSelector:@"span"];
        
        NSInteger count = 0;
        
        if(contentArr.count>3)
            count = 3;
        else
            count = contentArr.count;
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger i=0;i<count;i++)
        {
            [array addObject:contentArr[i].textContent];
        }
        
        [self setupContentArray:array];
    }
}

- (void)setContentArray:(NSArray<NSString *> *)contentArray
{
    _contentArray = contentArray;
    
    [_tvArray removeAllObjects];
    
    for (NSInteger i=0;i<_contentArray.count;i++)
    {
        TextView *tv = [[TextView alloc] init];
        tv.pointColor = _pointColor;
        tv.textColor = _textColor;
        tv.contentWidth = _contentWidth;
        [self addSubview:tv];
        if(i==0)
        {
            [tv mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.mas_equalTo(_contentWidth);
                make.height.mas_equalTo(16);
                make.centerX.mas_equalTo(0);
                make.top.mas_equalTo(0);
                
            }];
        }
        else
        {
            [tv mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.mas_equalTo(_contentWidth);
                make.height.mas_equalTo(16);
                make.centerX.mas_equalTo(0);
                make.top.mas_equalTo(_tvArray[i-1].mas_bottom).offset(12);
                
            }];
        }
        tv.content = _contentArray[i];
        
        [_tvArray addObject:tv];
        
        CGFloat heightContent = 0;
        for (NSInteger i=0;i<_tvArray.count;i++)
        {
            heightContent = heightContent+_tvArray[i].height+12;
        }
        
        _height = heightContent-12;
        
        if(_height<0)
            _height = 0;
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(_height);
            
        }];
    }
}


#pragma mark - Helper
- (void)setupContentArray:(NSMutableArray <NSString *>*)array
{
    _contentArray = (NSArray <NSString *>*)array;
    [_tvArray removeAllObjects];
    
    for (NSInteger i=0;i<_contentArray.count;i++)
    {
        TextView *tv = [[TextView alloc] init];
        tv.pointColor = _pointColor;
        tv.textColor = _textColor;
        tv.contentWidth = _contentWidth;
        [self addSubview:tv];
        if(i==0)
        {
            [tv mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.mas_equalTo(_contentWidth);
                make.height.mas_equalTo(16);
                make.centerX.mas_equalTo(0);
                make.top.mas_equalTo(0);
                
            }];
        }
        else
        {
            [tv mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.mas_equalTo(_contentWidth);
                make.height.mas_equalTo(16);
                make.centerX.mas_equalTo(0);
                make.top.mas_equalTo(_tvArray[i-1].mas_bottom).offset(12);
                
            }];
        }
        tv.content = _contentArray[i];
        
        [_tvArray addObject:tv];
        
        CGFloat heightContent = 0;
        for (NSInteger i=0;i<_tvArray.count;i++)
        {
            heightContent = heightContent+_tvArray[i].height+12;
        }
        
        _height = heightContent-12;
        
        if(_height<0)
            _height = 0;
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(_height);
            
        }];
    }
}






@end
