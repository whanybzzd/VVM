//
//  MRCNavigationController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/2/12.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCNavigationController.h"

@implementation MRCNavigationController

//- (BOOL)shouldAutorotate {
//    return self.topViewController.shouldAutorotate;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return self.topViewController.supportedInterfaceOrientations;
//}
//
//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return self.topViewController.preferredStatusBarStyle;
//}


- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //UINavigationController *nav = self.viewControllers[0];
    //if ([nav.topViewController isKindOfClass://[CHDHomeParadiseViewController class]]) {
    //    return UIInterfaceOrientationMaskAllButUpsideDown;
    //}//UIInterfaceOrientationMaskPortrait  UIInterfaceOrientationMaskAllButUpsideDown
    
    return UIInterfaceOrientationMaskAllButUpsideDown;
}
@end
