//
//  MRCHomepageViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/9.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCHomepageViewController.h"
#import "MRCHomepageViewModel.h"
#import "MRCNewsViewController.h"
#import "MRCProfileViewController.h"
#import "MRCNewsViewModel.h"
#import "MRCReposViewModel.h"
#import "MRCProfileViewModel.h"
#import "MRCReposViewController.h"
#import "MRCNavigationController.h"
#import "MRCExploreViewController.h"
//#import "MRCUserListViewModel.h"
//#import "MRCSearchViewController.h"

@interface MRCHomepageViewController ()

@property (nonatomic, strong) MRCHomepageViewModel *viewModel;

@end

@implementation MRCHomepageViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];

    UINavigationController *newsNavigationController = ({
        MRCNewsViewController *newsViewController = [[MRCNewsViewController alloc] initWithViewModel:self.viewModel.newsViewModel];

        UIImage *newsImage = [UIImage imageNamed:@"首页"];
        UIImage *newsHLImage = [UIImage imageNamed:@"首页选中"];
        newsHLImage = [newsHLImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        newsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:newsImage selectedImage:newsHLImage];
        [newsViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                  
                                                                  [UIFont systemFontOfSize:15.0],NSFontAttributeName,
                                                                  
                                                                  [UIColor redColor],NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
        [[MRCNavigationController alloc] initWithRootViewController:newsViewController];
    });

    UINavigationController *reposNavigationController = ({
        MRCReposViewController *reposViewController = [[MRCReposViewController alloc] initWithViewModel:self.viewModel.reposViewModel];

        UIImage *reposImage = [UIImage imageNamed:@"项目"];
        UIImage *reposHLImage = [UIImage imageNamed:@"项目选中"];
        reposHLImage = [reposHLImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        
        
        reposViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"项目" image:reposImage selectedImage:reposHLImage];

        [reposViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                  
                                                                  [UIFont systemFontOfSize:15.0],NSFontAttributeName,
                                                                  
                                                                  [UIColor redColor],NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
        [[MRCNavigationController alloc] initWithRootViewController:reposViewController];
    });

    UINavigationController *exploreNavigationController = ({
        MRCExploreViewController *exploreViewController = [[MRCExploreViewController alloc] initWithViewModel:self.viewModel.exploreViewModel];

        UIImage *exploreImage = [UIImage imageNamed:@"资产"];
        UIImage *exploreHLImage = [UIImage imageNamed:@"资产选中"];
        exploreHLImage = [exploreHLImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        
        exploreViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"资产" image:exploreImage selectedImage:exploreHLImage];

        [exploreViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                  
                                                                  [UIFont systemFontOfSize:15.0],NSFontAttributeName,
                                                                  
                                                                  [UIColor redColor],NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
        [[MRCNavigationController alloc] initWithRootViewController:exploreViewController];
    });

    UINavigationController *profileNavigationController = ({
        MRCProfileViewController *profileViewController = [[MRCProfileViewController alloc] initWithViewModel:self.viewModel.profileViewModel];

        UIImage *profileImage = [UIImage imageNamed:@"更多"];
        UIImage *profileHLImage = [UIImage imageNamed:@"更多选中"];
        profileHLImage = [profileHLImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        
        profileViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"更多" image:profileImage selectedImage:profileHLImage];

        [profileViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                  
                                                                  [UIFont systemFontOfSize:15.0],NSFontAttributeName,
                                                                  
                                                                  [UIColor redColor],NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
        
        
        [[MRCNavigationController alloc] initWithRootViewController:profileViewController];
    });

    self.tabBarController.viewControllers = @[ newsNavigationController, reposNavigationController, exploreNavigationController, profileNavigationController ];

    [MRCSharedAppDelegate.navigationControllerStack pushNavigationController:newsNavigationController];

    [[self
        rac_signalForSelector:@selector(tabBarController:didSelectViewController:)
        fromProtocol:@protocol(UITabBarControllerDelegate)]
        subscribeNext:^(RACTuple *tuple) {
            [MRCSharedAppDelegate.navigationControllerStack popNavigationController];
            [MRCSharedAppDelegate.navigationControllerStack pushNavigationController:tuple.second];
        }];
    self.tabBarController.delegate = self;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if (self.tabBarController.selectedViewController == viewController) {
        UINavigationController *navigationController = (UINavigationController *)self.tabBarController.selectedViewController;
        UIViewController *viewController = navigationController.topViewController;
        if ([viewController isKindOfClass:[MRCNewsViewController class]]) {
            MRCNewsViewController *newsViewController = (MRCNewsViewController *)viewController;
            //[newsViewController refresh];
        }
    }
    return YES;
}

@end
