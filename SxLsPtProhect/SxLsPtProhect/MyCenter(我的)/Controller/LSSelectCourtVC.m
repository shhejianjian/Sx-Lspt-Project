//
//  LSSelectCourtVC.m
//  SxLsPtProhect
//
//  Created by 何键键 on 17/10/16.
//  Copyright © 2017年 LS. All rights reserved.
//

#import "LSSelectCourtVC.h"
#import "MXConstant.h"
#import "GYCourtListCell.h"
#import "GYCourtListModel.h"


static NSString *ID=@"GYCourtListCell";



@interface LSSelectCourtVC ()<GYCourtListCellDelegate>
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *courtListArr;
@property (nonatomic, strong) NSMutableArray *courtNameArr;
@end

@implementation LSSelectCourtVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mxNavigationItem.title = @"选择法院";
    [self.myTableView registerNib:[UINib nibWithNibName:@"GYCourtListCell" bundle:nil] forCellReuseIdentifier:ID];
    [self loadCourtData];
}


- (void)loadCourtData {
    [self.courtNameArr removeAllObjects];
    [self.courtListArr removeAllObjects];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"fydm"] = @"R00";
    [HJHttpTool post:courtUrl ticket:@"" params:params success:^(id json) {
        NSLog(@"%@",json);
        NSArray *arr = [GYCourtListModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"fydm"]];
        for (GYCourtListModel *courtModel in arr) {
            if ([courtModel.xssx isEqualToString:@"R00"]) {
                [self.courtNameArr addObject:courtModel];
            }
            for (GYCourtListModel*model in courtModel.bmFy) {
                [self.courtListArr addObject:model];
            }
        }
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return self.courtNameArr.count;
    
}


- (GYCourtListCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    GYCourtListCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[GYCourtListCell alloc]init];
        
    }
    cell.courtListModel = self.courtNameArr[indexPath.row];
    cell.setCourtBtn.tag = indexPath.row;
    cell.delegate = self;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 50;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.courtNameArr.count > 0) {
        GYCourtListModel *clickModel = self.courtNameArr[indexPath.row];
        if (clickModel.bmFy.count > 0) {
            [self.courtNameArr removeAllObjects];
        }
        NSArray *arr = [GYCourtListModel mj_objectArrayWithKeyValuesArray:clickModel.bmFy];
        for (GYCourtListModel *model in arr) {
            if ([clickModel.dm isEqualToString:model.sjdm]) {
                [self.courtNameArr addObject:model];
                [self.myTableView reloadData];
            }
        }
    }
    
    
}

- (void)ChooseCourtWithBtnTag:(NSInteger)index{
    GYCourtListModel *courtListModel = self.courtNameArr[index];
    NSString *courtDm = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_dm"];
    if ([courtDm isEqualToString:courtListModel.dm]) {
        return;
    }
    if (self.courtNameArr.count > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:courtListModel.dm forKey:@"chooseCourt_dm"];
        [[NSUserDefaults standardUserDefaults] setObject:courtListModel.dmms forKey:@"chooseCourt_name"];
        [[NSUserDefaults standardUserDefaults] setObject:courtListModel.fyjc forKey:@"chooseCourt_fyjc"];
        
    }
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


- (NSMutableArray *)courtListArr {
	if(_courtListArr == nil) {
		_courtListArr = [[NSMutableArray alloc] init];
	}
	return _courtListArr;
}

- (NSMutableArray *)courtNameArr {
	if(_courtNameArr == nil) {
		_courtNameArr = [[NSMutableArray alloc] init];
	}
	return _courtNameArr;
}

@end
