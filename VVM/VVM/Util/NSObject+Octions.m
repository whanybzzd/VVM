//
//  NSObject+Octions.m
//  VVM
//
//  Created by ZMJ on 2018/8/25.
//  Copyright © 2018年 ZMJ. All rights reserved.
//

#import "NSObject+Octions.h"

@implementation NSObject (Octions)

+ (BOOL)isEmpty:(id)object {
    return (object == nil
            || [object isKindOfClass:[NSNull class]]
            || ([object respondsToSelector:@selector(length)] && [(NSData *)object length] == 0)
            || ([object respondsToSelector:@selector(count)]  && [(NSArray *)object count] == 0));
}

+ (BOOL)isNotEmpty:(id)object {
    return ( ! [self isEmpty:object]);
}
@end
