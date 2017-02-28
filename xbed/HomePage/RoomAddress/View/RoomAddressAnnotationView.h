//
//  RoomAddressAnnotationView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/11.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface RoomAddressAnnotationView : MAAnnotationView
{
@private
    UIImageView *_imgvBack;
    UILabel *_lbAddress;
}

@property (nonatomic, strong)NSString *address;

@end
