//
//  MXTabBarController.m
//  navDemo
//
//  Created by Max on 16/9/20.
//  Copyright © 2016年 maxzhang. All rights reserved.
//

#import "MXTabBarController.h"
#import "MXNavigationController.h"
#import "LSMyCenterVC.h"
#import "LSWorkPartVC.h"
#import "LSSifaPublicVC.h"


@interface MXTabBarController ()

@end

@implementation MXTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpChildViews];
    
}


- (void)setUpChildViews
{
    LSSifaPublicVC *homeC = [[LSSifaPublicVC alloc] init];
    MXNavigationController *firstNaC = [[MXNavigationController alloc] initWithRootViewController:homeC];
    
    homeC.title = @"司法公开";
    
    LSWorkPartVC *messageC = [[LSWorkPartVC alloc] init];
    MXNavigationController *messageNaC = [[MXNavigationController alloc] initWithRootViewController:messageC];
    messageC.title = @"工作平台";
    
    LSMyCenterVC *meC = [[LSMyCenterVC alloc] init];
    MXNavigationController *meNaC = [[MXNavigationController alloc] initWithRootViewController:meC];
    meC.title = @"我的";
    
    self.viewControllers = @[firstNaC,messageNaC,meNaC];
}




@end
