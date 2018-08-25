//
//  UIColor+Octions.h
//  VVM
//
//  Created by ZMJ on 2018/8/25.
//  Copyright © 2018年 ZMJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Octions)

//颜色转换
+ (UIColor*)colorWithHexString:(NSString*)stringToConvert;

+ (UIColor *)colorWithHex:(long)hexColor;

+ (UIColor *)colorWithHex:(long)hexColor alpha:(CGFloat)alpha;


@end
