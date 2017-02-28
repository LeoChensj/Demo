//
//  LUILabel.m
//  TestLabel
//
//  Created by mengxianzhi on 15/11/16.
//  Copyright © 2015年 mengxianzhi. All rights reserved.
//

#import "LUILabel.h"

@interface LUILabel()

@property (assign,nonatomic) id<LUILabelDelegate>labelDelegate;

@property (strong,nonatomic) NSString *stringText;
@property (assign,nonatomic)CGFloat fondSize;
@property (assign,nonatomic)CGFloat maxWidth;

@end

@implementation LUILabel

- (instancetype)initFondSize:(CGFloat)foudSize maxWidth:(int)maxWidth stringText:(NSString *)stringText delegate:(id)delegate{
    
    self = [super init];
    
    if (self) {
        
        self.stringText = stringText;
        self.font = [UIFont systemFontOfSize:foudSize];
        self.fondSize = foudSize;
        self.maxWidth = maxWidth;
        self.labelDelegate = delegate;
        [self setUserInteractionEnabled:YES];
        [self setNumberOfLines:0];
        
    }
    
    return self;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    
    //当前点击的位置
    CGPoint point = [touch locationInView:self];
    if ([self isClickLink:point] && self.labelDelegate && [self.labelDelegate respondsToSelector:@selector(didClickLink)]) {
        [self.labelDelegate didClickLink];
    }
}

- (BOOL)isClickLink:(CGPoint)point {

    NSString *beForText = [self.stringText substringToIndex:self.linkRange.location];
    //self.range.location 之前的文字size
    CGSize beforSize = [self boundingRectWithSize:CGSizeMake(100000, 30) stringStr:beForText fondSize:self.fondSize];
    //获取self.range.location 之前的信息
    int beForA = beforSize.width/self.maxWidth;
    int beForW = beforSize.width;
    int beForB = (int)beForW%(int)self.maxWidth;
    
    NSString *beForEndText = [self.stringText substringToIndex:self.linkRange.location+self.linkRange.length];
    //self.range.location 之前的文字size
    CGSize beforEndSize = [self boundingRectWithSize:CGSizeMake(100000, 30) stringStr:beForEndText fondSize:self.fondSize];
    //获取self.range.location 之前的信息
    int beForEndA = beforEndSize.width/self.maxWidth;
    int beForEndW = beforEndSize.width;
    int beForEndB = (int)beForEndW%(int)self.maxWidth;
    
    //self.range范围的文字没有折行情况(在同一行) 则不需要考虑下一行的点击
    if (beForEndA == beForA) {
        if (beForA == 0 && point.x>beForB && point.x<beForEndB && point.y<beforSize.height) {
//            NSLog(@"没有折行 = 0行 点击了");
            return YES;
        //beForA > 0 b 并且被点击的文字在同一行
        }else{
            if (point.y>beForA*beforSize.height && point.x > beForB && point.y<beForA*beforSize.height + beforSize.height && point.x < beForEndB) {
//                NSLog(@"没有折行 >0行 点击了");
                return YES;
            }
        }
    //self.range范围的文字不再同一行 则需要考虑下一行的点击 因为部分文在在下一行
    }else{
        if ((beForA == 0 && point.x>beForB && point.y<beforSize.height) || (beForA == 0 && point.x<beForEndB && point.y>beforSize.height && point.y<beForEndA*beforEndSize.height + beforEndSize.height)) {
//            NSLog(@"不再同一行 且为beForA = 0行 点击了");
            return YES;
        }else{
            if ((beForA > 0 && point.x>beForB && point.y > beForA*beforEndSize.height
                && point.y<beForEndA*beforEndSize.height) ||
                (beForA > 0 && point.x<beForEndB && point.y > beForEndA*beforEndSize.height && point.y < (beForEndA+1)*beforEndSize.height)) {
//                NSLog(@"不再同一行 且beForA > 0行 点击了");
                return YES;
            }
        }
    }
    return NO;
}

- (void)labelBlockWithLeftGap:(CGFloat)leftGap topGap:(CGFloat)topGap linkTextColor:(UIColor *)color otherTextColor:(UIColor *)otherColor labelBlock:(LabelBlock)labelBlock{
    int temp = (int)self.stringText.length - (int)self.linkRange.location;
    if ( temp < 0 || temp-(int)self.linkRange.length < 0) {
        NSLog(@"range 越界了");
        return;
    }
    
    CGSize size = [self boundingRectWithSize:CGSizeMake(self.maxWidth, 1000) stringStr:self.stringText fondSize:self.fondSize];
    [self setFrame:CGRectMake(leftGap, topGap, size.width, size.height)];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.stringText];
    
    long a =  self.stringText.length - self.linkRange.location;
    [str addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0,[str length]-a)];
    
    [str addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(self.linkRange.location+self.linkRange.length,self.stringText.length - (self.linkRange.location+self.linkRange.length))];
    
    [str addAttribute:NSForegroundColorAttributeName value:otherColor range:NSMakeRange(self.linkRange.location,self.linkRange.length)];
    self.attributedText = str;
    self.lineSpace = 4;
    
    labelBlock(self);
    
}

- (CGSize)boundingRectWithSize:(CGSize)size stringStr:(NSString *)stringStr fondSize:(CGFloat)fontOfSize
{
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:fontOfSize]};
    CGSize retSize = [stringStr boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return CGSizeMake(retSize.width, retSize.height+4);
}

@end

