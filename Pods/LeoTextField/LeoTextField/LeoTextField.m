//
//  LeoTextField.m
//  LeoTextFieldDemo
//
//  Created by Leo.Chen on 2016/12/12.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "LeoTextField.h"

@implementation LeoTextField

- (instancetype)init
{
    if(self = [super init])
    {
        [self initialize];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self initialize];
    }
    
    return self;
}


- (void)initialize
{
    self.limitLength = NSUIntegerMax;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}


#pragma mark - NSNotification
- (void)textDidChange:(NSNotification *)notification
{
    if (_limitLength!=NSUIntegerMax && _limitLength!=0)
    {
        NSString *beString = self.text;
        UITextRange *selectedRange = [self markedTextRange];
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        
        if(!position)
        {
            if(beString.length>_limitLength)
            {
                self.text = [beString substringToIndex:_limitLength];
                
                if(self.lengthBlock)
                {
                    self.lengthBlock(self);//到达最大长度回调
                }
            }
        }
    }
    
    if(self.changeBlock)
    {
        self.changeBlock(self);//文本改变回调
    }
}







#pragma mark - addBlock
- (void)addTextDidChangeBlock:(LeoTextFieldBlock)block
{
    self.changeBlock = block;
}
- (void)addTextLengthDidLimitBlock:(LeoTextFieldBlock)block
{
    self.lengthBlock = block;
}


@end
