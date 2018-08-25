//
//  AppDelegate.h
//  VVM
//
//  Created by ZMJ on 2018/8/25.
//  Copyright © 2018年 ZMJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "MRCNavigationControllerStack.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong, readonly) MRCNavigationControllerStack *navigationControllerStack;
@property (strong, nonatomic) UIWindow *window;

@end

