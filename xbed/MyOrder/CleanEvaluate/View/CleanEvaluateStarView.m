//
//  CleanEvaluateStarView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CleanEvaluateStarView.h"

@implementation CleanEvaluateStarView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.text = @"清洁评分";
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
        
        
        _starSelectView = [[StarSelectView alloc] init];
        [self addSubview:_starSelectView];
        [_starSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(28);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(_lbTitle.mas_bottom).offset(20);
            
        }];
        
        
        _tagSelectCollectionView = [[TagSelectCollectionView alloc] init];
        [self addSubview:_tagSelectCollectionView];
        [_tagSelectCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(100);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_starSelectView.mas_bottom).offset(20);
            
        }];
        
        
        WS(ws);
        [_starSelectView.signalSelect subscribeNext:^(NSNumber *x) {
            
            if(x.boolValue)
            {
                ws.selectTags = nil;
                
                NSInteger index = ws.starSelectView.star.integerValue-1;
                ws.starId = ws.cleanStarTerm[index].starId;//选择的星Id
                if(ws.cleanStarTerm[index].termList.count>0)//标签数组不为空
                {
                    NSMutableArray <TagModel *>*dataArray = [NSMutableArray array];
                    for (NSInteger i=0;i<ws.cleanStarTerm[index].termList.count;i++)
                    {
                        TagModel *tagModel = [[TagModel alloc] init];
                        tagModel.code = ws.cleanStarTerm[index].termList[i].termId;
                        tagModel.name = ws.cleanStarTerm[index].termList[i].termName;
                        [dataArray addObject:tagModel];
                    }
                    
                    ws.tagSelectCollectionView.dataArray = dataArray;
                    
                    ws.tagSelectCollectionView.hidden = NO;
                    
                    
                    [ws.tagSelectCollectionView addTagSelectCollectionViewReloadCompleteBlock:^{
                        
                        [ws mas_updateConstraints:^(MASConstraintMaker *make) {
                            
                            make.height.mas_equalTo(92+30+20+ws.tagSelectCollectionView.myHeight+20);
                            
                        }];
                        
                    }];
                    
                }
                else//标签数组为空
                {
                    ws.tagSelectCollectionView.hidden = YES;
                    [ws mas_updateConstraints:^(MASConstraintMaker *make) {
                        
                        make.height.mas_equalTo(92+30+20);
                        
                    }];
                }
            }
            else
            {
                ws.tagSelectCollectionView.hidden = YES;
            }
            
        }];
        
        
        
        RAC(self, selectTags) = RACObserve(_tagSelectCollectionView, tags);
        
    }
    
    return self;
}

@end
