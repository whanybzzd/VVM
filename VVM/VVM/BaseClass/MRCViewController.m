//
//  MRCViewController.m
//  VVM
//
//  Created by ZMJ on 2018/8/24.
//  Copyright © 2018年 ZMJ. All rights reserved.
//

#import "MRCViewController.h"

@interface MRCViewController () <UIGestureRecognizerDelegate,UITextFieldDelegate>

@property (nonatomic, strong, readwrite) MRCViewModel *viewModel;
@property (nonatomic, strong, readwrite) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@end

@implementation MRCViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    MRCViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    [[viewController
      rac_signalForSelector:@selector(viewDidLoad)]
     subscribeNext:^(id x) {
         @strongify(viewController)
         [viewController bindViewModel];
     }];
    
    return viewController;
}

- (MRCViewController *)initWithViewModel:(id)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
//    if (self.navigationController != nil && self != self.navigationController.viewControllers.firstObject) {
//        UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePopRecognizer:)];
//        [self.view addGestureRecognizer:popRecognizer];
//        popRecognizer.delegate = self;
//    }
}

- (void)bindViewModel{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:@"UITextFieldTextDidChangeNotification" object:nil];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.viewModel.willDisappearSignal sendNext:nil];
    
    // Being popped, take a snapshot
    if ([self isMovingFromParentViewController]) {
        self.snapshot = [self.navigationController.view snapshotViewAfterScreenUpdates:NO];
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString *toBeString=[textField.text stringByReplacingCharactersInRange:range withString:string];
    if (toBeString.length>textField.maxLength&&range.length!=1) {
        
        textField.text=[toBeString substringToIndex:textField.maxLength];
        return NO;
    }
    return YES;
}




- (void)textFieldChanged:(NSNotification *)obj{
    
    UITextField *textField=(UITextField *)obj.object;
    NSString *toBeString=textField.text;
    NSString *lang=[[UITextInputMode currentInputMode] primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"]) {
        
        UITextRange *selectedRange=[textField markedTextRange];
        //获取高亮部分
        UITextPosition *positing=[textField positionFromPosition:selectedRange.start offset:0];
        
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!positing) {
            
            if (toBeString.length>textField.maxLength) {
                
                textField.text=[toBeString substringFromIndex:textField.maxLength];
            }
        }else{
            
            //有高亮选择的字符串，则暂时不对文字进行统计和限制
        }
    }else{
        
        if (toBeString.length>textField.maxLength) {
            
            textField.text=[toBeString substringFromIndex:textField.maxLength];
        }
    }
    
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UITextFieldTextDidChangeNotification" object:nil];
}













@end
