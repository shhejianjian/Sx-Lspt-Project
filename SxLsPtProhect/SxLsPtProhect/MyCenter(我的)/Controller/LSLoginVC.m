//
//  LSLoginVC.m
//  SxLsPtProhect
//
//  Created by 何键键 on 17/10/18.
//  Copyright © 2017年 LS. All rights reserved.
//

#import "LSLoginVC.h"
#import "MXConstant.h"
#import "GYLoginModel.h"
#import "LSUserInfoModel.h"


@interface LSLoginVC ()
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UITextField *userNameTextFiled;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LSLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mxNavigationItem.title = @"用户登录";
    self.loginBtn.layer.cornerRadius = 5;
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)login:(id)sender {
    [MBProgressHUD showMessage:@"正在登录" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userLy"] = @"1";
    params[@"loginUserType"] = @"2";
    params[@"appLoginName"] = self.userNameTextFiled.text;
    params[@"appPassword"] = self.passwordTextField.text;
    [HJHttpTool post:wsla_loginUrl ticket:@"" params:params success:^(id json) {
        
        NSLog(@"%@---",json);
        GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
        if ([loginModel.success isEqualToString:@"true"]) {
            [MBProgressHUD showSuccess:loginModel.msg];
            [[NSUserDefaults standardUserDefaults] setObject:loginModel.ticket forKey:@"login_ticket"];
            
            LSUserInfoModel *userInfo = [LSUserInfoModel mj_objectWithKeyValues:loginModel.lawyer];
            [[NSUserDefaults standardUserDefaults] setObject:userInfo.username forKey:@"login_username"];
            [[NSUserDefaults standardUserDefaults] setObject:userInfo.ssjg forKey:@"login_ssjg"];
            [[NSUserDefaults standardUserDefaults] setObject:userInfo.jgLxdh forKey:@"login_jgLxdh"];
            [[NSUserDefaults standardUserDefaults] setObject:userInfo.dz forKey:@"login_dz"];

            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [MBProgressHUD showError:loginModel.msg];
        }
        [MBProgressHUD hideHUDForView:self.view];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


@end
