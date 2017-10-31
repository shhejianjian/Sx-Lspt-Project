//
//  LSMyCenterVC.m
//  SxLsPtProhect
//
//  Created by 何键键 on 17/10/12.
//  Copyright © 2017年 LS. All rights reserved.
//

#import "LSMyCenterVC.h"
#import "MXConstant.h"
#import "LSSelectCourtVC.h"
#import "LSLoginVC.h"
#import "LSUserInfoModel.h"
@interface LSMyCenterVC ()
@property (strong, nonatomic) IBOutlet UIView *noLoginView;
@property (strong, nonatomic) IBOutlet UIView *isLoginView;
@property (strong, nonatomic) IBOutlet UIButton *courtNameBtn;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *swsLabel;
@property (strong, nonatomic) IBOutlet UILabel *lxsjLabel;
@property (strong, nonatomic) IBOutlet UILabel *txdzLabel;

@property (strong, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LSMyCenterVC

- (void)viewWillAppear:(BOOL)animated{
    NSString *courtName = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_name"];
    [self.courtNameBtn setTitle:courtName forState:UIControlStateNormal];
    NSString *ticketStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    
    if(![ticketStr  isEqual: @""]){
        self.isLoginView.hidden = NO;
        self.imageView.hidden = YES;
        [self.loginBtn setTitle:@"退出" forState:UIControlStateNormal];
        self.nameLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_username"];
        self.swsLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ssjg"];
        self.lxsjLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_jgLxdh"];
        self.txdzLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_dz"];
    } else {
        self.isLoginView.hidden = YES;
        self.imageView.hidden = NO;
        [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        

    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isLoginView.hidden = YES;
    self.mxNavigationItem.title = @"个人中心";
    self.tabBarItem.image = [UIImage imageNamed:@"my"];
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"wdxz"];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)jumpToSelectCourt:(id)sender {
    LSSelectCourtVC *selectCourtVC = [[LSSelectCourtVC alloc]init];
    [self.navigationController pushViewController:selectCourtVC animated:YES];
}

- (IBAction)loginBtnClick:(UIButton *)sender {
    if([sender.titleLabel.text isEqualToString:@"登录"]){
        LSLoginVC *loginVC = [[LSLoginVC alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    } else if ([sender.titleLabel.text isEqualToString:@"退出"]){
        self.isLoginView.hidden = YES;
        self.imageView.hidden = NO;
        [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"login_ticket"];
    }
    
}




@end
