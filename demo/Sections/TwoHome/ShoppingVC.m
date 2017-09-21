//
//  ShoppingVC.m
//  demo
//
//  Created by wertyu on 17/5/19.
//  Copyright © 2017年 北京启智. All rights reserved.
//

#import "ShoppingVC.h"
#import "GroupModel.h"
#import "ProductsModel.h"
#import "ShopCell.h"
#import "ShopHeadView.h"
#import "ShopEndView.h"
#import "Masonry.h"
@interface ShoppingVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSMutableArray *dataArr;
@property (nonatomic ,assign)bool tempBool;
@property(nonatomic, strong)ShopEndView *shoppingCartEndView;   /**< 底部结算视图 */
@end

@implementation ShoppingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self requestData];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.shoppingCartEndView];

}

- (ShopEndView *)shoppingCartEndView
{
    if(!_shoppingCartEndView)
    {
        _shoppingCartEndView = [[ShopEndView alloc] initWithFrame:CGRectMake(0, HIGHT - 60, WIDTH, 60)];

        
        __typeof(&*self)weakSelf = self;
//        __typeof(&*self.shoppingCartTableView)weakTableView = self.shoppingCartTableView;
        
        //全选回调
        _shoppingCartEndView.allSelectButtonClick = ^(BOOL selected){
            
            //更新数据
            for (GroupModel *model in weakSelf.dataArr) {
                model.isSelected = selected;
                for (ProductsModel *products in model.products) {
                    products.isSelected = selected;
                }
            }
            [weakSelf TotalCountAndPrice];
            //更新UI
            [weakSelf.tableView reloadData];
            
        };
        
        //结算回调
        _shoppingCartEndView.settleButtonClick = ^(){
            
#warning 结算一样放在ViewModel处理逻辑,传回数据发生请求,这里就不处理了
        };
        
    }
    return _shoppingCartEndView;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (void)requestData {
    //直接读本地数据
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"shoppingCart" ofType:@"plist"];
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    [GroupModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                  @"products" : [ProductsModel class],
                 };
    }];
    for (NSDictionary *temp in dataArray) {
        GroupModel *model = [GroupModel mj_objectWithKeyValues:temp];
//        NSLog(@"%@==%@",model.products,model.brandName);
        [self.dataArr addObject:model];
    }

}
- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        self.dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   GroupModel *model = self.dataArr[section];
    return model.products.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //创建
    ShopCell *shoppingCartCell = [ShopCell shoppingCartCellWithTableView:tableView];
    
    //赋值
    shoppingCartCell.indexPath = indexPath;
    GroupModel *bandModel = self.dataArr[indexPath.section];
    shoppingCartCell.productModel = bandModel.products[indexPath.row];
    
    __typeof(&*self)weakSelf = self;
    //cell的选中按钮点击回调
    shoppingCartCell.cellSelectedButtonClick = ^(NSIndexPath *index){
        
        //更新数据
        GroupModel *groupModel = _dataArr[index.section];
        ProductsModel *tempModel = groupModel.products[index.row];
        tempModel.isSelected = !tempModel.isSelected;
        bool isSelect = YES;
        for (ProductsModel *model in groupModel.products) {
            if (model.isSelected == NO) {
                isSelect = NO;
            }
        }
        groupModel.isSelected = isSelect;
        bool allSelect = YES;
        for (GroupModel *tempGroupModel in weakSelf.dataArr) {
            if (tempGroupModel.isSelected == NO) {
                allSelect = NO;
            }
        }
        weakSelf.shoppingCartEndView.isSelected = allSelect;
        [weakSelf TotalCountAndPrice];
        //更新UI
        [weakSelf reloadTableViewDataWithSection:index.section];
        
    };
    

    //加
    shoppingCartCell.addButtonClick = ^(NSIndexPath *index){
        
        //更新数据
        GroupModel *groupModel = _dataArr[index.section];
        ProductsModel *tempModel = groupModel.products[index.row];
        tempModel.productQty ++;
        //更新UI
        [weakSelf TotalCountAndPrice];
//        [weakSelf reloadTableViewDataWithSection:index.section];
        [weakSelf.tableView reloadData];

    };
    
    //减
    shoppingCartCell.subButtonClick = ^(NSIndexPath *index){
        
        //更新数据
        GroupModel *groupModel = _dataArr[index.section];
        ProductsModel *tempModel = groupModel.products[index.row];
         tempModel.productQty --;
        [weakSelf TotalCountAndPrice];
        //更新UI
        [weakSelf reloadTableViewDataWithSection:index.section];
        [weakSelf.tableView reloadData];
    };
    

    return shoppingCartCell;

}
- (void)reloadTableViewDataWithSection:(NSInteger)scetion
{
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:scetion];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
}


//分组head
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    //创建
    ShopHeadView *headView = [[ShopHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    
    //赋值
    headView.model = (GroupModel *)self.dataArr[section];
    headView.section = section;
    __typeof(&*self)weakSelf = self;
    
    //headView选中按钮点击回调
    headView.selectButtonClick = ^(NSInteger tempSection){
        
        //更新数据
        GroupModel *model = self.dataArr[tempSection];
        model.isSelected = !model.isSelected;
        for (ProductsModel *produc in model.products) {
            
            produc.isSelected = model.isSelected;
        }
        bool allSelect = YES;
        for (GroupModel *tempGroupModel in weakSelf.dataArr) {
            if (tempGroupModel.isSelected == NO) {
                allSelect = NO;
            }
        }
        weakSelf.shoppingCartEndView.isSelected = allSelect;
        [weakSelf TotalCountAndPrice];
        //更新UI
        [weakSelf reloadTableViewDataWithSection:section];
        
    };

    
    return headView;
}


//分组head高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

//分组foot高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    //判断如果是最后一组,高度需要变高,因为需要给endView留空间
    if(section == self.dataArr.count - 1)
    {
        return 60 + 10;
    }
    else
    {
        return 10;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
#pragma mark - 删除
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    __typeof(&*self)weakSelf = self;

    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        GroupModel *model = weakSelf.dataArr[indexPath.section];
        ProductsModel *producs = model.products[indexPath.row];
        [model.products removeObject:producs];
        if (model.products.count == 0) {
            [weakSelf.dataArr removeObject:model];
        }
        
        [weakSelf TotalCountAndPrice];
        //更新UI
        [weakSelf.tableView reloadData];
        
    }];
    
    return @[delete];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark 计算总价格和总数量
- (void)TotalCountAndPrice {
    NSInteger Totalcount = 0;
    CGFloat TotalMoney = 0;
    for (GroupModel *model in self.dataArr) {
        for (ProductsModel *products in model.products) {
            if (products.isSelected) {
                Totalcount = products.productQty + Totalcount;
                TotalMoney = products.productQty * products.productPrice + TotalMoney;
            }
        }
    }
    self.shoppingCartEndView.totalPrice = TotalMoney;
    self.shoppingCartEndView.totalCount = Totalcount;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
