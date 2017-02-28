//
//  ScoreStarShowView.h
//  xbed
//
//  Created by Leo.Chen on 16/10/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreStarShowView : UIView
{
@private
    NSMutableArray <UIImageView *>*_stars;
    UILabel *_lbScore;
}

@property (nonatomic, strong)NSNumber *score;
@property (nonatomic, assign, readonly)CGFloat myWidth;
@property (nonatomic, assign, readonly)CGFloat myheight;

@end
