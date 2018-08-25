//
//  MRCLoginViewModel.h
//  VVM
//
//  Created by ZMJ on 2018/8/24.
//  Copyright © 2018年 ZMJ. All rights reserved.
//

#import "MRCViewModel.h"

@interface MRCLoginViewModel : MRCViewModel

@property (nonatomic, strong, readonly) RACCommand *loginCommand;

@end
