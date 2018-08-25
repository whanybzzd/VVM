//
//  MRCConfig.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/28.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#ifndef MVVMReactiveCocoa_MRCConfig_h
#define MVVMReactiveCocoa_MRCConfig_h

#import "UIImage+Octions.h"
#import "NSString+Octions.h"
#import "NSMutableAttributedString+Octions.h"
#import "UIColor+Octions.h"
#import "NSObject+Octions.h"
#import "NSString+Config.h"
#import "UITextField+Octions.h"
#import "AppDelegate.h"
///------------
/// AppDelegate
///------------

#define MRCSharedAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define IOS11 @available(iOS 11.0, *)

///----------------------
/// Persistence Directory
///----------------------

#define MRC_DOCUMENT_DIRECTORY NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define colorI1 0xBB0F23
#define colorI2 0x30434E
#define colorI3 0x4183C4
#define colorI4 0xe9dba5
#define colorI5 0x24AFFC
#define colorI6 0xEDEDED
//#define colorI6 0xE1E8ED
//#define colorI6 0xEFEDEA
#define colorI7 0xD9D9D9


#define ReturnWhenObjectIsEmpty(object)             if ([NSObject isEmpty:object]) { return ;    }
#define ReturnNilWhenObjectIsEmpty(object)          if ([NSObject isEmpty:object]) { return nil; }
#define ReturnEmptyWhenObjectIsEmpty(object)        if ([NSObject isEmpty:object]) { return @""; }
#define ReturnYESWhenObjectIsEmpty(object)          if ([NSObject isEmpty:object]) { return YES; }
#define ReturnNOWhenObjectIsEmpty(object)           if ([NSObject isEmpty:object]) { return NO;  }
#define ReturnZeroWhenObjectIsEmpty(object)         if ([NSObject isEmpty:object]) { return 0;  }

//按照尺寸大小来适配UI   375 667是根据UI的尺寸来切换
#define SCREEN_WIDTH                  [UIScreen mainScreen].bounds.size.width //屏幕的宽度
#define SCREEN_HEIGHT                 [UIScreen mainScreen].bounds.size.height//屏幕的高度
#define KSCREEN_Width(with) ((with)*(SCREEN_WIDTH/375.0f))
#define KSCREEN_HEIGHT(height) ((height)*(SCREEN_HEIGHT/667.0f))


#define getRectNavAndStatusHight  self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height


#define kDevice_Is_iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#endif
