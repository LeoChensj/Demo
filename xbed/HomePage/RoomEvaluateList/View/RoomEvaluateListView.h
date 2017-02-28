//
//  RoomEvaluateListView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/12.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomEvaluateListScoreView.h"
#import "RoomEvaluateListTagsView.h"
#import "RoomCommentListRespModel.h"

@interface RoomEvaluateListCell : UITableViewCell
{
@private
    UIImageView *_imgvHead;
    UILabel *_lbPhone;
    UILabel *_lbDate;
    UILabel *_lbScore;
    RoomEvaluateListTagsView *_tagsView;
    UILabel *_lbComment;
    UIImageView *_imgv1;
    UIImageView *_imgv2;
    UIImageView *_imgv3;
    UIImageView *_imgv4;
    UIView *_line;
    
    UILabel *_lbService;
    UIView *_vReplyContent;
    UILabel *_lbReplyContent;
}


@property (nonatomic, strong)RoomCommentListModel *model;

@end



@interface RoomEvaluateListView : UITableView <UITableViewDataSource, UITableViewDelegate>
{
@private
    RoomEvaluateListScoreView *_scoreView;
}

@property (nonatomic, strong)NSArray <RoomCommentListModel *>*dataArray;

@end
