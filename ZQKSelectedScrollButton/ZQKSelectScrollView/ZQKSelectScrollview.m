//
//  NaviScrollview.m
//  推荐
//
//  Created by sanmao on 16/3/30.
//  Copyright © 2016年 qk. All rights reserved.
//

#import "ZQKSelectScrollview.H"

@interface ZQKSelectScrollview()<UIScrollViewDelegate>

@property (nonatomic , strong) UIScrollView * scrollView;
@property (nonatomic , assign) CGFloat btnW;
@property (nonatomic , assign) CGFloat btnH;
@property (nonatomic , strong) UIButton * currentBut;
@property (nonatomic , assign) NSInteger currentIndex;
//底部的白色条条
@property (nonatomic , strong) UIView * lineView;
//点击代码块
@property (nonatomic , copy) ZQKNaviScrollViewSelectBlock selectBlock;

@end

@implementation ZQKSelectScrollview

//重写init方法
-(instancetype)initWithFrame:(CGRect)frame{
    
    if(self == [super initWithFrame:frame])
    {
    }
    
    return self;
}

#pragma mark naviScrollView的搭建
-(void)createNaviScrollView{
    
    _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    //给scrollView添加数据
    NSArray * titleArray = self.titleArray;
    
    if(titleArray.count > 0)
    {
        CGFloat buttonWidth = _scrollView.bounds.size.width/titleArray.count;
        CGFloat buttonHeight = _scrollView.bounds.size.height;
        _btnW = buttonWidth;
        _btnH = buttonHeight;

        for(int i = 0 ; i < titleArray.count ; i++)
        {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(i*buttonWidth, 0, buttonWidth, buttonHeight);
            button.backgroundColor = [UIColor clearColor];
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
            [button setTitleColor:self.titleColor forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            button.titleLabel.font = [UIFont systemFontOfSize:self.titleFontSize];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

            button.tag = 100+i;
            
            if(i == 0)//默认第一个是选中状态。
            {
                [self buttonClick:button];
                
                _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, buttonHeight-2, buttonWidth, 3)];
                _lineView.backgroundColor = self.lineColor;
                [_scrollView addSubview:_lineView];
            }
            
            [_scrollView addSubview:button];
        }
        
        _scrollView.contentSize = CGSizeMake(buttonWidth*titleArray.count, _scrollView.bounds.size.height);
        
        
   
    }
}

#pragma mark 按钮的点击事件
-(void)buttonClick:(UIButton *)button{
    
    if(button.selected == NO)//按钮没选择
    {
        _currentBut.selected = NO;
        _currentBut.titleLabel.font = [UIFont systemFontOfSize:17];
        
        _currentBut = button;
        button.selected = YES;
        
        NSInteger i = button.tag-100;
       
        //获得下标条的初始位置
        float originXForLine = i*_btnW;
        
        [UIView animateWithDuration:0.5 animations:^{
            _lineView.frame = CGRectMake(originXForLine, _btnH-2, _btnW, 3);
        }];
        
        [button.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:self.titleFontSize]];
    }
    
    if(self.selectBlock)
    {
        self.selectBlock(button.tag-100);
    }
}

#pragma - mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

+(ZQKSelectScrollview *)naviScrollViewInitWithFrame:(CGRect)scrollframe WithTitleArray:(NSArray *)titleArray font:(CGFloat)titleFontSize titleColor:(UIColor *)titleColor lineColor:(UIColor *)lineColor  andSelectBlock:(ZQKNaviScrollViewSelectBlock)selectBlock{

    
    ZQKSelectScrollview * naviScrollView = [[ZQKSelectScrollview alloc]initWithFrame:scrollframe];
    naviScrollView.userInteractionEnabled = YES;
    naviScrollView.titleArray = titleArray;
    naviScrollView.titleFontSize = titleFontSize;
    naviScrollView.backgroundColor = [UIColor clearColor];
    if(titleColor)
    {
        naviScrollView.titleColor = titleColor;
    }
    else
    {
        naviScrollView.titleColor = [UIColor whiteColor];
    }
    if(lineColor)
    {
        naviScrollView.lineColor = lineColor;
    }
    else
    {
        naviScrollView.lineColor = [UIColor whiteColor];
    }
    naviScrollView.selectBlock = selectBlock;
    
    [naviScrollView createNaviScrollView];
    
    return naviScrollView;
    
}




@end
