//
//  ViewController.m
//  ZQKSelectedScrollButton
//
//  Created by sanmao on 16/3/31.
//  Copyright © 2016年 qk. All rights reserved.
//

#import "ViewController.h"
#import "ZQKSelectScrollview.h"

#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()

@end

@implementation ViewController
{
    UIImageView * navBarHairLineImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    navBarHairLineImageView = [self findNavBarLineImageViewUnder:self.navigationController.navigationBar];
    
    [self setNavigationBar];
}
#pragma mark 设置navigationBar
-(void)setNavigationBar{
    ZQKSelectScrollview * ZQKnavScrollView = [ZQKSelectScrollview naviScrollViewInitWithFrame:CGRectMake(0, 0, 150, 44) WithTitleArray:@[@"打你",@"不打",@"打打"] font:17 titleColor:[UIColor whiteColor] lineColor:[UIColor whiteColor] andSelectBlock:^(NSInteger selectIndex) {
        NSLog(@"默认选中了第%ld个。",selectIndex);
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
        view.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:view];
    }];
    
    self.navigationItem.titleView = ZQKnavScrollView;
}

#pragma mark 得到navigationBar下方的那一像素的黑色线条
-(UIImageView *)findNavBarLineImageViewUnder:(UIView *)barView{
    
    if([barView isKindOfClass:[UIImageView class]] && barView.bounds.size.height <= 1.0)
    {
        return (UIImageView *)barView;
    }
    for (UIView * subView in barView.subviews) {
        UIImageView * imageView = [self findNavBarLineImageViewUnder:subView];
        if(imageView)
        {
            return imageView;
        }
    }
    
    return nil;
}

#pragma mark 生命周期
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    navBarHairLineImageView.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    navBarHairLineImageView.hidden = NO;
}


@end
