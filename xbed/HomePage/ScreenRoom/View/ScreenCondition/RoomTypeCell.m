//
//  RoomTypeCell.m
//
//
//  Created by Leo.Chen on 16/7/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomTypeCell.h"

@implementation RoomTypeCell

- (instancetype)init
{
    if(self = [super init])
    {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 16;
        
        self.titleLabel.font = Font(12);
        
    }
    
    return self;
}

- (void)setModel:(ScreenRoomTagModel *)model
{
    _model = model;
    
    [self setTitle:model.cname forState:UIControlStateNormal];
}

- (void)setStates:(NSInteger)states
{
    _states = states;
    
    if(states==0)
    {
        self.backgroundColor = [UIColor whiteColor];
        [self setTitleColor:Main_Text_Color forState:UIControlStateNormal];
    }
    else if(states==1)
    {
        self.backgroundColor = Blue_Color;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}



@end
