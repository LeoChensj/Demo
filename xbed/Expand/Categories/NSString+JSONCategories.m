//
//
//  
//
//  Created by 陈仕军 on 16/5/11.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "NSString+JSONCategories.h"

@implementation NSString(JSONCategories)

-(id)JSONValue
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}
@end
