//
//  RoomAddressAnnotationView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/11.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomAddressAnnotationView.h"

@implementation RoomAddressAnnotationView

- (id)initWithAnnotation:(id <MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier])
    {
        self.centerOffset = CGPointMake(0, -20);
        
        _imgvBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 34)];
        _imgvBack.image = [self stretchableImage1];
        [self addSubview:_imgvBack];
        
        
        _lbAddress = [[UILabel alloc] init];
        _lbAddress.numberOfLines = 0;
        _lbAddress.textColor = Blue_Color;
        _lbAddress.font = Font(14);
        [self addSubview:_lbAddress];
        [_lbAddress mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(270);
            make.height.mas_equalTo(20);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(6);
            
        }];
        
    }
    
    return self;
}


- (void)setAddress:(NSString *)address
{
    _address = address;
    
    _lbAddress.text = address;
    _lbAddress.lineSpace = 6;
    
    CGSize addressSize = [_lbAddress labelSize:270];
    
    [_lbAddress mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(addressSize.height);
        
    }];
    
    self.size = CGSizeMake(300, addressSize.height+20);
    
    
    CGFloat tempWidth = (300)/2+45/2;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(tempWidth, addressSize.height+20), NO, [UIScreen mainScreen].scale);
    [_imgvBack.image drawInRect:CGRectMake(0, 0, tempWidth, addressSize.height+20)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    _imgvBack.size = CGSizeMake(300, addressSize.height+20);
    _imgvBack.image = [self stretchableImage2:image];
}



#pragma mark - Helper
- (UIImage *)stretchableImage1
{
    UIImage *image = [UIImage imageNamed:@"ic_room_address"];
    return [image stretchableImageWithLeftCapWidth:45*0.8 topCapHeight:image.size.height*0.5];
}
- (UIImage *)stretchableImage2:(UIImage *)image
{
    return [image stretchableImageWithLeftCapWidth:45*0.2 topCapHeight:image.size.height*0.5];
}




@end
