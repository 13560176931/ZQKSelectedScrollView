//
//  NaviScrollview.h
//  推荐
//
//  Created by sanmao on 16/3/30.
//  Copyright © 2016年 qk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZQKNaviScrollViewSelectBlock)(NSInteger selectIndex);


@interface ZQKSelectScrollview : UIView

@property (nonatomic , strong) NSArray * titleArray;
@property (nonatomic , assign) CGFloat titleFontSize;
@property (nonatomic , strong) UIColor * titleColor;
@property (nonatomic , strong) UIColor * lineColor;



+(ZQKSelectScrollview *)naviScrollViewInitWithFrame:(CGRect)scrollframe WithTitleArray:(NSArray *)titleArray font:(CGFloat)titleFontSize titleColor:(UIColor *)titleColor lineColor:(UIColor *)lineColor  andSelectBlock:(ZQKNaviScrollViewSelectBlock)selectBlock;


@end
