//
//  RoomEvaluateListScoreView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/12.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomEvaluateListScoreView.h"

@implementation RoomEvaluateListScoreView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
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
        
        _lbNo = [[UILabel alloc] init];
        _lbNo.textColor = Secondary_Text_Color;
        _lbNo.textAlignment = NSTextAlignmentCenter;
        _lbNo.font = Font(10);
        [self addSubview:_lbNo];
        [_lbNo mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(10);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(_lbScore.mas_bottom).offset(8);
            
        }];
        
        
        
        UILabel *lbRoom = [[UILabel alloc] init];
        lbRoom.text = @"房间评价：";
        lbRoom.textColor = Main_Text_Color;
        lbRoom.font = Font(14);
        [self addSubview:lbRoom];
        [lbRoom mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(50);
            make.top.mas_equalTo(_lbNo.mas_bottom).offset(25);
            
        }];
        
        _lbRoomScore = [[UILabel alloc] init];
        _lbRoomScore.textColor = Orange_Color;
        _lbRoomScore.font = Font(14);
        [self addSubview:_lbRoomScore];
        [_lbRoomScore mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(lbRoom.mas_right).offset(0);
            make.top.mas_equalTo(_lbNo.mas_bottom).offset(25);
            
        }];
        
        
        UILabel *lbClean = [[UILabel alloc] init];
        lbClean.text = @"清洁评价：";
        lbClean.textColor = Main_Text_Color;
        lbClean.font = Font(14);
        [self addSubview:lbClean];
        [lbClean mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(self.mas_centerX).offset(50);
            make.top.mas_equalTo(_lbNo.mas_bottom).offset(25);
            
        }];
        
        _lbCleanScore = [[UILabel alloc] init];
        _lbCleanScore.textColor = Orange_Color;
        _lbCleanScore.font = Font(14);
        [self addSubview:_lbCleanScore];
        [_lbCleanScore mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(lbClean.mas_right).offset(0);
            make.top.mas_equalTo(_lbNo.mas_bottom).offset(25);
            
        }];
        
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = Seg_Line_Color;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            
        }];
        
        
        
    }
    
    return self;
}




- (void)setScore:(NSNumber *)score
{
    _score = score;
    
    NSString *string = [NSString stringWithFormat:@"%.1f分", score.floatValue];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    [attString addAttribute:(NSString *)NSFontAttributeName value:Font(13) range:NSMakeRange(string.length-1, 1)];
    
    _lbScore.attributedText = attString;
}

- (void)setEvaluateNumber:(NSNumber *)evaluateNumber
{
    _evaluateNumber = evaluateNumber;
    
    _lbNo.text = [NSString stringWithFormat:@"%@ 条评分", evaluateNumber];
}

- (void)setRoomScore:(NSNumber *)roomScore
{
    _roomScore = roomScore;
    
    _lbRoomScore.text = [NSString stringWithFormat:@"%@分", roomScore];
}

- (void)setCleanScore:(NSNumber *)cleanScore
{
    _cleanScore = cleanScore;
    
    _lbCleanScore.text = [NSString stringWithFormat:@"%@分", cleanScore];
}



@end
