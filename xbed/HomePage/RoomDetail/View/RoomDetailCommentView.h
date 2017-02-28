//
//  RoomDetailCommentView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/6.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  评论

#import <UIKit/UIKit.h>

@interface RoomDetailCommentView : UIView
{
@private
    UILabel *_lbScore;
    UILabel *_lbNumberOfComment;
    UIImageView *_imgv1;
    UIImageView *_imgv2;
    UILabel *_lbContent;
}

@property (nonatomic, strong, readonly)UIButton *btnAll;

@property (nonatomic, strong)NSNumber *score;
@property (nonatomic, strong)NSNumber *commentNo;
@property (nonatomic, strong)NSString *commentContent;

@end
