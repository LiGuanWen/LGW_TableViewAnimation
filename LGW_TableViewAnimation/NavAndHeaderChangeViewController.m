//
//  NavAndHeaderChangeViewController.m
//  LGW_TableViewAnimation
//
//  Created by Lilong on 16/4/26.
//  Copyright © 2016年 第七代目. All rights reserved.
//

#import "NavAndHeaderChangeViewController.h"

#define HeadH 200

#define HeadMinH 64

#define TabBarH 44

@interface NavAndHeaderChangeViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerHight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerTop;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic, assign) CGFloat oriOffsetY;
@property (nonatomic, weak) UILabel *label;
@end

@implementation NavAndHeaderChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerClasss];
    [self setUpNavBar];
    
    // 记录下最原始偏移量
    self.oriOffsetY = - (HeadH + TabBarH);
    
    // 设置tableView额外顶部滚动区域244
    // tableView只要设置顶部额外滚动区域,就会把内容往下挤
    // 底层会调用scrollViewDidScroll,会调节滚动区域
    self.tableView.contentInset = UIEdgeInsetsMake(HeadH + TabBarH , 0, 0, 0);

    // Do any additional setup after loading the view.
}

- (void)registerClasss{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cells"];
}

// 设置导航条
- (void)setUpNavBar
{
    // 在iOS7之后,只要是导航控制器下所有UIScrollView顶部都会添加额外的滚动区域.
    // 设置当前控制器不要调节ScrollViewInsets
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 设置导航条隐藏
    //    self.navigationController.navigationBar.hidden = YES;
    // 必须要传入UIBarMetricsDefault
    
    // 设置导航条背景图片
    // 快速隐藏导航条背景图片
    // 传入空图片的image对象
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    // 清空导航条的阴影
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    // 设置导航条标题
    UILabel *label = [[UILabel alloc] init];
    label.text = @"第七代目";
    label.textColor = [UIColor colorWithWhite:0 alpha:0];
    // 自动计算label,根据文字计算
    [label sizeToFit];
    _label = label;
    self.navigationItem.titleView = label;
}

#pragma mark - 监听滚动
// 只要一滚动就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    //    NSLog(@"%f",scrollView.contentOffset.y);
    // 0.获取当前滚动区域
    CGFloat curOffsetY = scrollView.contentOffset.y;
    
    // 1.计算下当前用户滚动多少
    CGFloat delta = curOffsetY - _oriOffsetY;
    
    
    // 2.修改头部视图的y值
    // 只能保证用户滚多少,头部视图就移动多少
    //    _headYCons.constant = 0 - delta;
    
    // 3.视觉差效果
    // 3.1计算下当前头部视图高度
    CGFloat h = HeadH - delta;
    
    if (h < HeadMinH) {
        h = HeadMinH;
    }
    
    self.headerHight.constant = h;
    
    // 处理导航条
    // 让导航条慢慢显示
    // 设置alpha
    CGFloat alpha = delta / (HeadH - HeadMinH);
    
    if (alpha >= 1) {
        alpha = 0.99;
    }
    //    NSLog(@"%f",alpha);
    
    // 确定颜色
    UIColor *whiteColor = [UIColor colorWithWhite:1 alpha:alpha];
    
    // 生成对应alpha的图片给你
    UIImage *image = [self imageWithColor:whiteColor];
    // 设置导航条背景图片透明度
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    // 修改lable文字颜色
    _label.textColor = [UIColor colorWithWhite:0 alpha:alpha];
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}

#pragma mark - TableView delegates
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 22;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 100;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cells"];
    cell.textLabel.text = @"MY NAME IS LILONG";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
