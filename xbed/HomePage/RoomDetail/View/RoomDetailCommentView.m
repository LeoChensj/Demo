//
//  RoomDetailCommentView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/6.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomDetailCommentView.h"

@implementation RoomDetailCommentView

@synthesize btnAll = _btnAll;


- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        
        _lbScore = [[UILabel alloc] init];
        _lbScore.textColor = Orange_Color;
        _lbScore.textAlignment = NSTextAlignmentCenter;
        _lbScore.font = Font(29);
        [self addSubview:_lbScore];
        [_lbScore mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(29);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(30);
            
        }];
        
        
        _lbNumberOfComment = [[UILabel alloc] init];
        _lbNumberOfComment.textColor = Secondary_Text_Color;
        _lbNumberOfComment.textAlignment = NSTextAlignmentCenter;
        _lbNumberOfComment.font = Font(10);
        [self addSubview:_lbNumberOfComment];
        [_lbNumberOfComment mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(10);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(_lbScore.mas_bottom).offset(8);
            
        }];
        
        
        _imgv1 = [[UIImageView alloc] init];
        _imgv1.image = [UIImage imageNamed:@"pic_comment_quotes_left"];
        [self addSubview:_imgv1];
        [_imgv1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(17);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(_lbNumberOfComment.mas_bottom).offset(10);
            
        }];
        
        _imgv2 = [[UIImageView alloc] init];
        _imgv2.image = [UIImage imageNamed:@"pic_comment_quotes_right"];
        [self addSubview:_imgv2];
        [_imgv2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(17);
            make.height.mas_equalTo(14);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(_imgv1.mas_bottom).offset(50);
            
        }];
        
        
        _lbContent = [[UILabel alloc] init];
        _lbContent.numberOfLines = 0;
        _lbContent.textColor = Main_Text_Color;
        _lbContent.textAlignment = NSTextAlignmentCenter;
        _lbContent.font = Font(13);
        [self addSubview:_lbContent];
        [_lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-120);
            make.height.mas_equalTo(13);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(_imgv1.mas_bottom).offset(10);
            
        }];
        
        
    }
    
    return self;
}


- (UIButton *)btnAll
{
    if(_btnAll==nil)
    {
        _btnAll = [[UIButton alloc] init];
        _btnAll.layer.masksToBounds = YES;
        _btnAll.layer.cornerRadius = 2;
        _btnAll.layer.borderColor = Blue_Color.CGColor;
        _btnAll.layer.borderWidth = LINE_WIDTH;
        [_btnAll setTitle:@"全部评论" forState:UIControlStateNormal];
        [_btnAll setTitleColor:Blue_Color forState:UIControlStateNormal];
        _btnAll.titleLabel.font = Font(12);
        [self addSubview:_btnAll];
        [_btnAll mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(34);
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(-30);
            
        }];
    }
    
    return _btnAll;
}



- (void)setScore:(NSNumber *)score
{
    _score = score;
    
    if(score)
    {
        self.hidden = NO;
        
        NSString *string = [NSString stringWithFormat:@"%.1f分", score.floatValue];
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
        [attString addAttribute:(NSString *)NSFontAttributeName value:Font(13) range:NSMakeRange(string.length-1, 1)];
        
        _lbScore.attributedText = attString;
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(260);
            
        }];
    }
    else
    {
        self.hidden = YES;
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(0);
            
        }];
    }
    
}

- (void)setCommentNo:(NSNumber *)commentNo
{
    _commentNo = commentNo;
    
    _lbNumberOfComment.text = [NSString stringWithFormat:@"%@ 条评分", commentNo];
}

- (void)setCommentContent:(NSString *)commentContent
{
    _commentContent = commentContent;
    
    _lbContent.text = commentContent;
    _lbContent.lineSpace = 10;
    
    CGSize sizeComment = [_lbContent labelSize:(MAIN_SCREEN_WIDTH-120)];
    CGFloat heightComment = sizeComment.height;
    if(heightComment>39.9)
    {
        heightComment = 39.9;
    }
    
    if(_commentNo==nil || _commentNo.integerValue<=0)
    {
        self.hidden = YES;
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(0);
            
        }];
    }
    else
    {
        self.hidden = NO;
        
        if(commentContent.length)
        {
            _imgv1.hidden = NO;
            _imgv2.hidden = NO;
            _lbContent.hidden = NO;
            
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.height.mas_equalTo(260);
                
            }];
            
            [_lbContent mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.height.mas_equalTo(heightComment);
                
            }];
        }
        else
        {
            _imgv1.hidden = YES;
            _imgv2.hidden = YES;
            _lbContent.hidden = YES;
            
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.height.mas_equalTo(260-84);
                
            }];
        }
    }
}






@end
