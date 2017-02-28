//
//  CleanEvaluateBaseInfoView.h
//  xbed
//
//  Created by Leo.Chen on 16/10/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreStarShowView.h"

@interface CleanEvaluateBaseInfoView : UIView
{
@private
    UIImageView *_imgvHead;
    UILabel *_lbName;
    ScoreStarShowView *_scoreView;
}

@property (nonatomic, strong)NSString *head;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSNumber *score;

@end
