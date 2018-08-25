//
//  UIImage+Octions.h
//  VVM
//
//  Created by ZMJ on 2018/8/24.
//  Copyright © 2018年 ZMJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Octions)

+ (UIImage *)octicon_imageWithIcon:(NSString *)identifier
                   backgroundColor:(UIColor *)bgColor
                         iconColor:(UIColor *)iconColor
                         iconScale:(CGFloat)scale
                           andSize:(CGSize)size;

@end
