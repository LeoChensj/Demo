//
//  RoomDescribeLabel.m
//  xbed
//
//  Created by Leo.Chen on 16/7/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomDescribeLabel.h"

@implementation RoomDescribeLabel

- (instancetype)init
{
    if(self = [super init])
    {
        self.textColor = Secondary_Text_Color;
        self.font = Font(12);

        
        
        WS(ws);
        [[RACSignal combineLatest:@[RACObserve(self, type), RACObserve(self, count), RACObserve(self, score)] reduce:^id(NSString *type, NSNumber *count, NSNumber *score){
            
            /*
            if(type.length && count)
            {
                if(score)
                    return @1;
                else
                    return @2;
            }
            */
            
            if(score)
                return @1;
            else
            {
                if(count)
                {
                    if(type && type.length)
                        return @2;
                    else
                        return @3;
                }
            }
            
            return nil;
            
        }] subscribeNext:^(NSNumber *x) {
            
            if(x)
            {
                if(x.integerValue==1)
                {
                    NSString *string = [NSString stringWithFormat:@"%@  |  可住%@人  |  %.1f分", ws.type, ws.count, ws.score.floatValue];
                    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
                    [attString addAttribute:(NSString *)NSForegroundColorAttributeName value:Orange_Color range:NSMakeRange(string.length-4, 4)];
                    
                    ws.attributedText = (NSAttributedString *)attString;
                }
                else if(x.integerValue==2)
                {
                    ws.text = [NSString stringWithFormat:@"%@  |  可住%@人", ws.type, ws.count];
                }
                else if(x.integerValue==3)
                {
                    ws.text = [NSString stringWithFormat:@"可住%@人", ws.count];
                }
            }
        }];
        
    }
    
    return self;
}

@end
