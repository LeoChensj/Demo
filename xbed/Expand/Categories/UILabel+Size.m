//
//  UILabel+Size.m
//  xbed
//
//  Created by 陈仕军 on 16/5/11.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "UILabel+Size.h"

@implementation UILabel (Size)

- (CGSize)labelSize:(CGFloat)width
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = self.lineSpace;
    paraStyle.alignment = self.textAlignment;
    
    NSDictionary *attribute = @{NSFontAttributeName : self.font,
                                NSParagraphStyleAttributeName : paraStyle};
    
    CGSize labelSize = [self.text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                               options:NSStringDrawingTruncatesLastVisibleLine |
                                                       NSStringDrawingUsesLineFragmentOrigin |
                                                       NSStringDrawingUsesFontLeading
                                            attributes:attribute
                                               context:nil].size;
    
    
    return CGSizeMake(labelSize.width, ceil(labelSize.height));
}






@end
