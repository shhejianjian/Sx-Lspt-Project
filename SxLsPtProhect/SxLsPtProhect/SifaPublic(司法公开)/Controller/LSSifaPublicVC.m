//
//  LSSifaPublicVC.m
//  SxLsPtProhect
//
//  Created by 何键键 on 17/10/12.
//  Copyright © 2017年 LS. All rights reserved.
//

#import "LSSifaPublicVC.h"
#import "MXConstant.h"
#import "GridView.h"
#import "GridButton.h"
#import "GYCourtDetailMainVC.h"
#import "GYPTMainVC.h"
#import "GYGuideListVC.h"

@interface LSSifaPublicVC ()<GridViewDelegate,UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *ktggLabel;
@property (strong, nonatomic) IBOutlet UIView *menuView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *homePictureHeight;

@property (strong, nonatomic) IBOutlet UILabel *sfgkTitleLabel;

@property(nonatomic,strong)GridView *gridView;
@property (strong,nonatomic) NSMutableArray * showGridTitleArray; // 标题
@property (strong,nonatomic) NSMutableArray * showImageGridArray; // 图片
@property (strong,nonatomic) NSMutableArray * showGridIDArray;//ID
@end

@implementation LSSifaPublicVC



- (void)viewDidLoad {
    [super viewDidLoad];
    if (IS_IPHONE_5 == 1) {
        self.homePictureHeight.constant = 140;
    } else if (IS_IPHONE_6 == 1){
        self.homePictureHeight.constant = 200;
       
    }else if (IS_IPHONE_6_PLUS == 1){
        self.homePictureHeight.constant = 249;
    }
    
    self.mxNavigationItem.title = @"司法公开";
    self.tabBarItem.image = [UIImage imageNamed:@"sfgk"];
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"sfgkxz"];
    
    self.gridView =[[GridView alloc]initWithFrame:CGRectMake(0, self.sfgkTitleLabel.y+5+self.sfgkTitleLabel.height, KScreenW, self.menuView.height) showGridTitleArray:self.showGridTitleArray showImageGridArray:self.showImageGridArray showGridIDArray:self.showGridIDArray];
    self.gridView.backgroundColor = [UIColor whiteColor];
    self.gridView.gridViewDelegate = self;
    [self.menuView addSubview:self.gridView];
    [self.gridView updateNewFrame];
}

-(void)updateHeight:(CGFloat)height
{
    self.gridView.height = height;
}
-(void)clickGridView:(GridButton *)item
{
    if([item.gridTitle isEqualToString:@"法院简介"]){
        GYCourtDetailMainVC *courtDetailVC = [[GYCourtDetailMainVC alloc]init];
        courtDetailVC.pushType = @"1";
        [self.navigationController pushViewController:courtDetailVC animated:YES];
    } else if([item.gridTitle isEqualToString:@"部门职能"]){
        GYCourtDetailMainVC *courtDetailVC = [[GYCourtDetailMainVC alloc]init];
        courtDetailVC.pushType = @"2";
        [self.navigationController pushViewController:courtDetailVC animated:YES];
    } else if([item.gridTitle isEqualToString:@"审委会"]){
        GYCourtDetailMainVC *courtDetailVC = [[GYCourtDetailMainVC alloc]init];
        courtDetailVC.pushType = @"3";
        [self.navigationController pushViewController:courtDetailVC animated:YES];
    } else if([item.gridTitle isEqualToString:@"法官名册"]){
        GYCourtDetailMainVC *courtDetailVC = [[GYCourtDetailMainVC alloc]init];
        courtDetailVC.pushType = @"4";
        [self.navigationController pushViewController:courtDetailVC animated:YES];
    } else if([item.gridTitle isEqualToString:@"诉讼指南"]){
        
    } else if([item.gridTitle isEqualToString:@"诉讼工具"]){
        
    } else if([item.gridTitle isEqualToString:@"开庭公告"]){
        GYPTMainVC *ptMainVC = [[GYPTMainVC alloc]init];
        [self.navigationController pushViewController:ptMainVC animated:YES];
    } else if([item.gridTitle isEqualToString:@"执行指南"]){
        GYGuideListVC *guideListVC = [[GYGuideListVC alloc]init];
        [self.navigationController pushViewController:guideListVC animated:YES];
    }
}
#pragma mark---懒加载---
- (NSMutableArray *)showGridTitleArray {
    if(_showGridTitleArray == nil) {
        _showGridTitleArray = [NSMutableArray arrayWithObjects:@"法院简介",@"部门职能",@"审委会", @"法官名册", @"诉讼指南",@"诉讼工具", @"开庭公告",@"执行指南", nil];
    }
    return _showGridTitleArray;
}

- (NSMutableArray *)showImageGridArray {
    if(_showImageGridArray == nil) {
        _showImageGridArray = [NSMutableArray arrayWithObjects:
                               @"fyjj",@"bmzn", @"swh",
                               @"fgmc",@"sszn" ,@"ssgj",
                               @"ktgg",@"zxzn", nil];
        ;
    }
    return _showImageGridArray;
}

- (NSMutableArray *)showGridIDArray {
    if(_showGridIDArray == nil) {
        _showGridIDArray = [NSMutableArray arrayWithObjects:
                            @"1000",@"1001", @"1002",
                            @"1003",@"1004",@"1005" ,@"1006",
                            @"1007", nil];
    }
    return _showGridIDArray;
}

@end
