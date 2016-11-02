//
//  WXHomePageController.m
//  NetEaseNewsHomePage
//
//  Created by 王旭 on 2016/10/28.
//  Copyright © 2016年 wangxu. All rights reserved.
//

#import "WXHomePageController.h"
#import "WXNewsController.h"

@interface WXHomePageController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@end

@implementation WXHomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentScrollView.delegate = self;
    
    [self addController];
    
    [self addLabel];
    
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}

/**
 添加子控制器
 */
- (void)addController{
    
    WXNewsController *vc1 = [WXNewsController initWithTitle:@"社会"];
    [self addChildViewController:vc1];
    
    vc1 = [WXNewsController initWithTitle:@"军事"];
    [self addChildViewController:vc1];
    
    vc1 = [WXNewsController initWithTitle:@"科技"];
    [self addChildViewController:vc1];
    
    vc1 = [WXNewsController initWithTitle:@"体育"];
    [self addChildViewController:vc1];
    
    vc1 = [WXNewsController initWithTitle:@"本地"];
    [self addChildViewController:vc1];
    
    vc1 = [WXNewsController initWithTitle:@"娱乐"];
    [self addChildViewController:vc1];
    
    vc1 = [WXNewsController initWithTitle:@"要点"];
    [self addChildViewController:vc1];
    
}

/**
 添加标题
 */
- (void)addLabel{
    
    NSInteger count = self.childViewControllers.count;
    CGFloat labelW = 100;
    CGFloat labelY = 0;
    NSLog(@"%f",self.titleScrollView.frame.size.height);
    CGFloat labelH = self.titleScrollView.frame.size.height;
    
    for (NSInteger i = 0; i < count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.text = self.childViewControllers[i].title;
        label.textColor = [UIColor blackColor];
        label.frame = CGRectMake(i * labelW, labelY, labelW, labelH);
        label.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100) / 100.0 green:arc4random_uniform(100) / 100.0 blue:arc4random_uniform(100) / 100.0 alpha:1];
        label.textAlignment = NSTextAlignmentCenter;
        
        // 添加点击事件 (触摸手势)
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        // 使该控件可以和用户交互
        label.userInteractionEnabled = YES;
        label.tag = i;
        [self.titleScrollView addSubview:label];
    }
    
    self.titleScrollView.contentSize = CGSizeMake(7 * labelW, 0);
    self.contentScrollView.contentSize = CGSizeMake(7 * [UIScreen mainScreen].bounds.size.width, 0);
}

/**
 标题点击事件
 
 @param tap 标题
 */
- (void)labelClick:(UITapGestureRecognizer *)tap{
    NSInteger index = tap.view.tag;
    
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = index * self.contentScrollView.frame.size.width;
    [self.contentScrollView setContentOffset:offset animated:YES];
    
}

#pragma mark - UIScrollViewDelegate

/**
 scrollView结束了滚动动画以后会调用该方法
 比如- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;方法执行的动画完毕后）
 @param scrollView scrollView
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    CGFloat offsetX = scrollView.contentOffset.x;
    // 当前的控制器索引
    NSInteger index = offsetX / width;

    WXNewsController *vc = self.childViewControllers[index];
    
    // 当前标题对应的索引
    UILabel *label = self.titleScrollView.subviews[index];
    CGFloat needOffset = label.center.x - self.titleScrollView.frame.size.width * 0.5;
    
    // 判断左边界
    if(needOffset < 0) needOffset = 0;
    
    // 最大contentOffset ↓↓↓↓↓↓↓↓
    CGFloat maxOffset = self.titleScrollView.contentSize.width - self.titleScrollView.frame.size.width;
    // 判断右边界
    if(needOffset > maxOffset) needOffset = maxOffset;
    
    CGPoint titleOffset = self.titleScrollView.contentOffset;
    titleOffset.x = needOffset;
    [self.titleScrollView setContentOffset:titleOffset animated:YES];
    
    // 如果已经显示过了就返回
    if([vc isViewLoaded])
        return;
    
    vc.view.frame = CGRectMake(offsetX, 0, width, height);
    
    [self.contentScrollView addSubview:vc.view];
    
}

/**
 手指松开scrollview后，scrollview停止减速完毕后调用该事件
 (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated 不会触发该事件

 @param scrollView scrollView
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

@end
