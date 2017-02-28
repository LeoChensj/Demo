//
//  UILabel+LineSpace.m
//  xbed
//
//  Created by Leo.Chen on 16/8/8.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "UILabel+LineSpace.h"

@implementation UILabel (LineSpace)

- (CGFloat)lineSpace
{
    CGFloat lineSpace100 = self.tag;
    
    return lineSpace100/100;
}

- (void)setLineSpace:(CGFloat)lineSpace
{
    NSMutableAttributedString * attributedString;
    
    if(self.attributedText)
    {
        attributedString = (NSMutableAttributedString *)self.attributedText;
    }
    else if(self.text)
    {
        attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    }
    else
    {
        NSLog(@"先设置label的text");
        
        return;
    }
    
    self.tag = (NSInteger)(lineSpace*100);
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace;
    paragraphStyle.alignment = self.textAlignment;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.text.length)];
    
    self.attributedText = attributedString;
}

@end
