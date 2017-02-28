//
//  CleanEvaluateStarView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarSelectView.h"
#import "TagSelectCollectionView.h"
#import "CheckinCleanRespModel.h"

@interface CleanEvaluateStarView : UIView
{
@private
    UILabel *_lbTitle;
}

@property (nonatomic, strong, readonly)StarSelectView *starSelectView;
@property (nonatomic, strong, readonly)TagSelectCollectionView *tagSelectCollectionView;

@property (nonatomic, strong)NSArray <CheckinCleanStarTermModel *>*cleanStarTerm;

@property (nonatomic, strong)NSNumber *starId;
@property (nonatomic, strong)NSArray <NSNumber *>*selectTags;

@end
