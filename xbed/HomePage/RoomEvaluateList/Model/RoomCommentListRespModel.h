//
//  RoomCommentListRespModel.h
//  xbed
//
//  Created by Leo.Chen on 2016/12/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"

@interface RoomCommentListModel : XbedRespModel

@property (nonatomic, strong)NSNumber *cleanCommentId;
@property (nonatomic, strong)NSNumber *cleanGrade;
@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)NSDate *createDate;
@property (nonatomic, strong)NSString *headImage;
@property (nonatomic, strong)NSString *phone;
@property (nonatomic, strong)NSArray <NSString *>*pictures;
@property (nonatomic, strong)NSNumber *roomCommentId;
@property (nonatomic, strong)NSNumber *roomGrade;
@property (nonatomic, strong)NSArray <NSString *>*tags;
@property (nonatomic, strong)NSString *replyContent;

@end

@interface RoomCommentListDataModel : XbedRespModel

@property (nonatomic, strong)NSArray <RoomCommentListModel *>*commentList;
@property (nonatomic, strong)NSNumber *totalElements;
@property (nonatomic, strong)NSNumber *totalPages;

@end

@interface RoomCommentListRespModel : XbedRespModel

@property (nonatomic, strong)RoomCommentListDataModel *data;

@end
