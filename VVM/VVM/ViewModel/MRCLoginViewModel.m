//
//  MRCLoginViewModel.m
//  VVM
//
//  Created by ZMJ on 2018/8/24.
//  Copyright © 2018年 ZMJ. All rights reserved.
//

#import "MRCLoginViewModel.h"
#import "MRCNewsViewModel.h"
#import "MRCViewModelServicesImpl.h"
@interface MRCLoginViewModel()

@property (nonatomic, strong, readwrite) RACCommand *loginCommand;


@end
@implementation MRCLoginViewModel


- (void)initialize{
    
    [super initialize];
    
    @weakify(self)
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^(id input) {
        @strongify(self)
        
        MRCNewsViewModel *viewModel=[[MRCNewsViewModel alloc] initWithServices:self.services params:nil];


        [self.services pushViewModel:viewModel animated:YES];
        return [RACSignal empty];
    }];
}
@end
