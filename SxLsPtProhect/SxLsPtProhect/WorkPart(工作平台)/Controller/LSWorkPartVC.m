//
//  LSWorkPartVC.m
//  SxLsPtProhect
//
//  Created by 何键键 on 17/10/12.
//  Copyright © 2017年 LS. All rights reserved.
//

#import "LSWorkPartVC.h"
#import "MXConstant.h"
#import "GridView.h"
#import "GridButton.h"
#import "LSLoginVC.h"
#import "GYNetRegistVC.h"
@interface LSWorkPartVC ()<GridViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)GridView *gridView;
@property (strong,nonatomic) NSMutableArray * showGridTitleArray; // 标题
@property (strong,nonatomic) NSMutableArray * showImageGridArray; // 图片
@property (strong,nonatomic) NSMutableArray * showGridIDArray;//ID
@end

@implementation LSWorkPartVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.mxNavigationItem.title = @"工作平台";
    self.tabBarItem.image = [UIImage imageNamed:@"gzpt"];
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"gzptxz"];
    self.gridView =[[GridView alloc]initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH) showGridTitleArray:self.showGridTitleArray showImageGridArray:self.showImageGridArray showGridIDArray:self.showGridIDArray];
    self.gridView.backgroundColor = [UIColor whiteColor];
    self.gridView.gridViewDelegate = self;
    [self.view addSubview:self.gridView];
    [self.gridView updateNewFrame];
}
-(void)updateHeight:(CGFloat)height
{
    self.gridView.height = height;
}
-(void)clickGridView:(GridButton *)item{
    NSString *ticketStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    if(![ticketStr  isEqual: @""]){
        if([item.gridTitle isEqualToString:@"网上立案"]){
            GYNetRegistVC *nrHomeVC = [[GYNetRegistVC alloc]init];
            [self.navigationController pushViewController:nrHomeVC animated:YES];
        } else if([item.gridTitle isEqualToString:@"我的案件"]){
            
        } else if([item.gridTitle isEqualToString:@"档案借阅"]){
            
        } else if([item.gridTitle isEqualToString:@"电子送达"]){
            
        } else if([item.gridTitle isEqualToString:@"证据交换"]){
            
        } else if([item.gridTitle isEqualToString:@"我的开庭"]){
            
        } else if([item.gridTitle isEqualToString:@"法官预约"]){
            
        }
    } else {
        LSLoginVC *loginVC = [[LSLoginVC alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
}

#pragma mark---懒加载---
- (NSMutableArray *)showGridTitleArray {
    if(_showGridTitleArray == nil) {
        _showGridTitleArray = [NSMutableArray arrayWithObjects:@"网上立案",@"我的案件",@"档案借阅", @"电子送达", @"证据交换",@"我的开庭", @"法官预约", nil];
    }
    return _showGridTitleArray;
}

- (NSMutableArray *)showImageGridArray {
    if(_showImageGridArray == nil) {
        _showImageGridArray = [NSMutableArray arrayWithObjects:
                               @"wsla",@"wdaj", @"dajy",
                               @"dzsd",@"zjjh" ,@"wdkt",
                               @"yyfg", nil];
        ;
    }
    return _showImageGridArray;
}

- (NSMutableArray *)showGridIDArray {
    if(_showGridIDArray == nil) {
        _showGridIDArray = [NSMutableArray arrayWithObjects:
                            @"1000",@"1001", @"1002",
                            @"1003",@"1004",@"1005" ,@"1006",
                             nil];
    }
    return _showGridIDArray;
}

@end
