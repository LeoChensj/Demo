//
//  RoomEvaluateStarView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarSelectView.h"
#import "TagSelectCollectionView.h"
#import "GetRoomEvaluateRespModel.h"

@interface RoomEvaluateStarView : UIView
{
@private
    UILabel *_lbTitle;
}

@property (nonatomic, strong, readonly)StarSelectView *starSelectView;
@property (nonatomic, strong, readonly)TagSelectCollectionView *tagSelectCollectionView;

@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSArray <GetRoomEvaluateStarTermModel *>*starTerm;

@property (nonatomic, assign)BOOL enable;       //默认YES

@property (nonatomic, strong)NSNumber *star;
@property (nonatomic, strong)NSArray <NSString *>*termList;



@property (nonatomic, strong)NSNumber *starId;
@property (nonatomic, strong)NSArray <NSNumber *>*selectTags;

@end
