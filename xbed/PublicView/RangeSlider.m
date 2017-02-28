//
//  RangeSlider.m
//  xbed
//
//  Created by Leo.Chen on 16/3/14.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RangeSlider.h"

@implementation RangeSlider

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        _vTrackNormal = [[UIView alloc] initWithFrame:CGRectMake(30/2, frame.size.height/2-4/2, frame.size.width-30, 4)];
        _vTrackNormal.backgroundColor = [UIColor grayColor];
        [self addSubview:_vTrackNormal];
        
        _vTrackSelect = [[UIView alloc] initWithFrame:CGRectMake(30/2, frame.size.height/2-6/2, frame.size.width-30, 6)];
        _vTrackSelect.backgroundColor = [UIColor blueColor];
        [self addSubview:_vTrackSelect];
        
        _ivMinThumb = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height/2-30/2, 30, 30)];
        //_ivMinThumb.image = [UIImage imageWithColor:[UIColor redColor]];
        [self addSubview:_ivMinThumb];
        
        _ivMaxThumb = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width-30, frame.size.height/2-30/2, 30, 30)];
        //_ivMaxThumb.image = [UIImage imageWithColor:[UIColor redColor]];
        [self addSubview:_ivMaxThumb];
        
        
        _valueMin = 0;
        _valueMax = 100;
        _limitMin = 0;
        _limitMax = 100;
        _interval = 10;
        _imageThumb = nil;
        _trackNormalColor = [UIColor grayColor];
        _trackSelectColor = [UIColor blueColor];
        _trackNormalHeight = 4;
        _trackSelectHeight = 6;
    }
    
    return self;
}


#pragma mark - Set Function
- (void)setValueMin:(NSInteger)valueMin
{
    if(_valueMin!=valueMin)
    {
        CGFloat xValue = [self correctValue:valueMin];

        _valueMin = xValue;
        
        _ivMinThumb.center = CGPointMake([self xFromValue:xValue], _ivMinThumb.center.y);
        
        _vTrackSelect.frame = CGRectMake(_ivMinThumb.center.x, _vTrackSelect.origin.y, _ivMaxThumb.center.x-_ivMinThumb.center.x, _vTrackSelect.size.height);
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)setValueMax:(NSInteger)valueMax
{
    if(_valueMax!=valueMax)
    {
        CGFloat xValue = [self correctValue:valueMax];

        _valueMax = xValue;
        
        _ivMaxThumb.center = CGPointMake([self xFromValue:xValue], _ivMaxThumb.center.y);
        
        _vTrackSelect.frame = CGRectMake(_ivMinThumb.center.x, _vTrackSelect.origin.y, _ivMaxThumb.center.x-_ivMinThumb.center.x, _vTrackSelect.size.height);
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)setLimitMin:(NSInteger)limitMin
{
    if(_limitMin!=limitMin)
    {
        _limitMin = limitMin;
    }
}

- (void)setLimitMax:(NSInteger)limitMax
{
    if(_limitMax!=limitMax)
    {
        _limitMax = limitMax;
    }
}

- (void)setInterval:(NSInteger)interval
{
    if(_interval!=interval)
    {
        _interval = interval;
        
        NSInteger stepNumber = (_limitMax-_limitMin)/interval;
        _xInterval = (self.frame.size.width-_thumbSize.width)/stepNumber;
    }
}

- (void)setImageThumb:(NSString *)imageThumb
{
    if(_imageThumb!=imageThumb)
    {
        _imageThumb = imageThumb;
        
        UIImage *image = [UIImage imageNamed:imageThumb];
        
        _thumbSize = image.size;
        
        _ivMinThumb.frame = CGRectMake(0, self.frame.size.height/2-_thumbSize.height/2, _thumbSize.width, _thumbSize.height);
        _ivMaxThumb.frame = CGRectMake(self.frame.size.width-_thumbSize.width, self.frame.size.height/2-_thumbSize.height/2, _thumbSize.width, _thumbSize.height);
        
        _ivMinThumb.image = image;
        _ivMaxThumb.image = image;
    }
}

- (void)setTrackNormalColor:(UIColor *)trackNormalColor
{
    if(_trackNormalColor!=trackNormalColor)
    {
        _trackNormalColor = trackNormalColor;
        
        _vTrackNormal.backgroundColor = trackNormalColor;
    }
}

- (void)setTrackSelectColor:(UIColor *)trackSelectColor
{
    if(_trackSelectColor!=trackSelectColor)
    {
        _trackSelectColor = trackSelectColor;
        
        _vTrackSelect.backgroundColor = trackSelectColor;
    }
}

- (void)setTrackNormalHeight:(NSInteger)trackNormalHeight
{
    if(_trackNormalHeight!=trackNormalHeight)
    {
        _trackNormalHeight = trackNormalHeight;
        
        _vTrackNormal.frame = CGRectMake(_thumbSize.width/2, self.frame.size.height/2-trackNormalHeight/2, self.frame.size.width-_thumbSize.width, trackNormalHeight);
    }
}

- (void)setTrackSelectHeight:(NSInteger)trackSelectHeight
{
    if(_trackSelectHeight!=trackSelectHeight)
    {
        _trackSelectHeight = trackSelectHeight;
        
        _vTrackSelect.frame = CGRectMake(_thumbSize.width/2, self.frame.size.height/2-trackSelectHeight/2, self.frame.size.width-_thumbSize.width, trackSelectHeight);
    }
}



#pragma mark - Helper
- (NSInteger)correctValue:(NSInteger)oldValue
{
    if(_minThumbOn && oldValue>=_valueMax-_interval) return _valueMax-_interval;
    if(_maxThumbOn && oldValue<=_valueMin+_interval) return _valueMin+_interval;
    if(oldValue>=_limitMax) return _limitMax;
    if(oldValue<=_limitMin) return _limitMin;
    
    return oldValue;
}

- (CGFloat)xFromValue:(NSInteger)value
{
    CGFloat barWidth = self.frame.size.width-_thumbSize.width;
    
    CGFloat x = (value-_limitMin)*barWidth/(_limitMax-_limitMin)+_thumbSize.width/2;
    
    return x;
}

- (NSInteger)valueFromX:(CGFloat)x
{
    CGFloat barWidth = self.frame.size.width-_thumbSize.width;
    
    NSInteger value = (x-_thumbSize.width/2)*(_limitMax-_limitMin)/barWidth+_limitMin;
    
    return value;
}

- (void)endHandle
{
    for(NSInteger i=_limitMin;i<=_limitMax;i+=_interval)
    {
        if(_valueMin>=i-_interval*0.5 && _valueMin<i+_interval*0.5)
        {
            self.valueMin = i;
        }
        
        if(_valueMax>=i-_interval*0.5 && _valueMax<i+_interval*0.5)
        {
            self.valueMax = i;
        }
    }
}






#pragma mark - Touch events
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [touch locationInView:self];
    
    if(CGRectContainsPoint(_ivMinThumb.frame, touchPoint))
        _minThumbOn = YES;
    else
        _minThumbOn = NO;
    
    if(CGRectContainsPoint(_ivMaxThumb.frame, touchPoint))
        _maxThumbOn = YES;
    else
        _maxThumbOn = NO;
    
    
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(!_minThumbOn && !_maxThumbOn)
        return YES;
    
    
    CGPoint touchPoint = [touch locationInView:self];
    
    if(_minThumbOn)
    {
        self.valueMin = [self valueFromX:touchPoint.x];
    }
    
    if(_maxThumbOn)
    {
        self.valueMax = [self valueFromX:touchPoint.x];
    }
    
    
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self endHandle];
    
    _minThumbOn = NO;
    _maxThumbOn = NO;
}


@end
