//
//  ViewController.m
//  LGW_TableViewAnimation
//
//  Created by Lilong on 16/4/25.
//  Copyright © 2016年 第七代目. All rights reserved.
//

#import "ViewController.h"
//cells
#import "HeaderCell.h"
#import "EvaluateCell.h"

#define LWidth ([UIScreen mainScreen].bounds.size.width)
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataList;

@property (assign, nonatomic) AnimationType type;
@property (assign, nonatomic) BOOL tableAnimated;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataList = [[NSMutableArray alloc] init];
    //默认设置为没有动画
    self.type = animationTypeNO;
    [self registerNibs];
    [self getData];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)getData{
    self.dataList = (NSMutableArray *) @[@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo"];
    [self.tableView reloadData];
}

- (void)registerNibs{
    [self.tableView registerNib:[UINib nibWithNibName:@"HeaderCell" bundle:nil] forCellReuseIdentifier:@"HeaderCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"EvaluateCell" bundle:nil] forCellReuseIdentifier:@"EvaluateCell"];
}
#pragma mark - TableView delegates
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return self.dataList.count; //根据真实数据
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 0;
            break;
        case 1:
            return 50;
            break;
        default:
            return 0;
            break;
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {

//        //平移动画 也可以在这里实现 （有时间在写）

        
//      旋转动画
//        CATransform3D rotation;
//        rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
//        rotation.m34 = 1.0/ -600;
//        
//        cell.layer.shadowColor = [[UIColor blackColor]CGColor];
//        cell.layer.shadowOffset = CGSizeMake(10, 10);
//        cell.alpha = 0;
//        cell.layer.transform = rotation;
//        cell.layer.anchorPoint = CGPointMake(0, 0.5);
//        
//        
//        [UIView beginAnimations:@"rotation" context:NULL];
//        [UIView setAnimationDuration:0.8];
//        cell.layer.transform = CATransform3DIdentity;
//        cell.alpha = 1;
//        cell.layer.shadowOffset = CGSizeMake(0, 0);
//        [UIView commitAnimations];
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return nil;
            break;
        case 1:
          {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LWidth, 50)];
            UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, LWidth/2, 50)];
            [leftBtn setTitle:@"左边按钮" forState:UIControlStateNormal];
            leftBtn.backgroundColor = [UIColor redColor];
            [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:leftBtn];
            
            UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(LWidth/2, 0, LWidth/2, 50)];
            [rightBtn setTitle:@"右边按钮" forState:UIControlStateNormal];
              rightBtn.backgroundColor = [UIColor blueColor];
              [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:rightBtn];
            return view;
        }
        default:
            return nil;
            break;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
           {
               HeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell" forIndexPath:indexPath];
               return cell;
           }
            break;
        case 1:
        {
            EvaluateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EvaluateCell" forIndexPath:indexPath];
            [cell setupCellWithTitle:self.dataList[indexPath.row] AndAnimationType:self.type];
            return cell;
        }
            break;
        default:
            return nil;
            break;
    }
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
#pragma mark - 监听滚动
// 只要一滚动就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.type = animationTypeNO;
}

#pragma mark 按钮点击事件
//左边
- (void)leftBtnAction{
    NSLog(@"点击了左边按钮");
    //设置动画 左边到中间
    self.type = animationTypeLeft;
    self.dataList = (NSMutableArray *) @[@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo",@"LGW的demo"];
    [self.tableView reloadData];

}
//右边
- (void)rightBtnAction{
    NSLog(@"点击了右边的按钮");
    //设置动画 右边边到中间
    self.type = animationTypeRight;
        self.dataList = (NSMutableArray *)@[@"my name is lilong",@"my name is lilong",@"my name is lilong",@"my name is lilong",@"my name is lilong",@"my name is lilong",@"my name is lilong",@"my name is lilong",@"my name is lilong",@"my name is lilong",@"my name is lilong",@"my name is lilong",@"my name is lilong",@"my name is lilong",@"my name is lilong",@"my name is lilong",@"my name is lilong",@"my name is lilong",@"my name is lilong",@"my name is lilong",@"my name is lilong",@"my name is lilong",@"my name is lilong",@"my name is lilong",@"my name is lilong"];
    [self.tableView reloadData];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
