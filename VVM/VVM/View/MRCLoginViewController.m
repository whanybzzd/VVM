//
//  MRCLoginViewController.m
//  VVM
//
//  Created by ZMJ on 2018/8/24.
//  Copyright © 2018年 ZMJ. All rights reserved.
//

#import "MRCLoginViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "MRCLoginViewModel.h"
@interface MRCLoginViewController ()
@property (weak, nonatomic) IBOutlet MRCTextField *usernameTextField;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong, readonly) MRCLoginViewModel *viewModel;
@end

@implementation MRCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginButton=[[UIButton alloc] initWithFrame:CGRectMake(30, 100, 200, 40)];
    self.loginButton.backgroundColor=[UIColor redColor];
    [self.view addSubview:self.loginButton];
    
    self.usernameTextField.placeholders=@"请输入用户名";
    self.usernameTextField.placeholderColor=[UIColor blueColor];
    self.usernameTextField.maxLength=5;
    
}

- (void)bindViewModel{
    
    [super bindViewModel];
    
    @weakify(self)
    [[self.loginButton
      rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self)
         [self.viewModel.loginCommand execute:nil];
     }];
}


@end
