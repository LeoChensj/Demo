//
//  
//
//
//  Created by 陈仕军 on 16/5/11.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "NSObject+JSONCategories.h"

@implementation NSObject (JSONCategories)

-(NSString*)JSONString;
{
    NSError* error = nil;
//    id result = [NSJSONSerialization dataWithJSONObject:self
//                                                options:kNilOptions error:&error];
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:NSJSONWritingPrettyPrinted error:&error];
    if (error != nil) return nil;
    if ([result length] > 0 && error == nil)
    {
        NSString *jsonString = [[NSString alloc] initWithData:result
                                                     encoding:NSUTF8StringEncoding];
        return jsonString;
    }
    else
    {
        return nil;
    }
}

-(NSData*)JSONSData
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    
    return result;
}

@end
