//
//  XDTabBarViewController.m
//  TrafficAPP
//
//  Created by xiao dou on 2017/11/21.
//  Copyright © 2017年 xiao dou. All rights reserved.
//

#import "XDTabBarViewController.h"
//#import "XDNavBaseViewController.h"
#import "XDMonitoViewController.h"
#import "XDEquipmentList.h"

@interface XDTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation XDTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    [self setUpTabBar];
    [self addDcChildViewContorller];
}
#pragma mark - 更换系统tabbar
-(void)setUpTabBar
{
    UITabBar *tabBar = [[UITabBar alloc] init];
    tabBar.backgroundColor = [UIColor whiteColor];
    [self setValue:tabBar forKey:@"tabBar"];
}

#pragma mark - 添加子控制器
- (void)addDcChildViewContorller
{
    NSArray *childArray = @[
                            @{MallClassKey  : @"XDMonitoViewController",
                              MallTitleKey  : @"监控",
                              MallImgKey    : @"jiankong-A",
                              MallSelImgKey : @"jiankong-b"},

                            @{MallClassKey  : @"XDEquipmentList",
                              MallTitleKey  : @"设备",
                              MallImgKey    : @"list-a",
                              MallSelImgKey : @"list-b"}
                            ];
    [childArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIViewController *vc = [NSClassFromString(dict[MallClassKey]) new];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        NSDictionary *dictHome = [NSDictionary dictionaryWithObject:[UIColor colorWithHexString:@"#33AAE2"] forKey:NSForegroundColorAttributeName];
        [item setTitleTextAttributes:dictHome forState:UIControlStateSelected];

        nav.title = dict[MallTitleKey];
        item.image = [UIImage imageNamed:dict[MallImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[MallSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self addChildViewController:nav];
    }];
}

#pragma mark - <UITabBarControllerDelegate>
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //点击tabBarItem动画
    [self tabBarButtonClick:[self getTabBarButton]];
    
}
- (UIControl *)getTabBarButton{
    NSMutableArray *tabBarButtons = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            [tabBarButtons addObject:tabBarButton];
        }
    }
    UIControl *tabBarButton = [tabBarButtons objectAtIndex:self.selectedIndex];
    
    return tabBarButton;
}
#pragma mark - 点击动画
- (void)tabBarButtonClick:(UIControl *)tabBarButton
{
    for (UIView *imageView in tabBarButton.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            //需要实现的帧动画,这里根据自己需求改动
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.1,@0.9,@1.0];
            animation.duration = 0.3;
            animation.calculationMode = kCAAnimationCubic;
            //添加动画
            [imageView.layer addAnimation:animation forKey:nil];
        }
    }
}


#pragma mark - 禁止屏幕旋转
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
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
