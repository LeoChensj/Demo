//
//  RoomEvaluateListScoreView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/12.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoomEvaluateListScoreView : UIView
{
@private
    UILabel *_lbScore;
    UILabel *_lbNo;
    UILabel *_lbRoomScore;
    UILabel *_lbCleanScore;
}

@property (nonatomic, strong)NSNumber *score;
@property (nonatomic, strong)NSNumber *evaluateNumber;
@property (nonatomic, strong)NSNumber *roomScore;
@property (nonatomic, strong)NSNumber *cleanScore;


@end
