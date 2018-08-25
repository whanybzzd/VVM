//
//  NSMutableAttributedString+Octions.h
//  VVM
//
//  Created by ZMJ on 2018/8/25.
//  Copyright © 2018年 ZMJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (Octions)

+ (NSMutableAttributedString *)withTitleString:(NSString *)string RangeString:(NSString *)range ormoreString:(NSString *)moreString color:(UIColor *)color;


+ (NSMutableAttributedString *)withTitleString:(NSString *)string RangeString:(NSString *)range color:(UIColor *)color withFont:(UIFont *)font;

@end
