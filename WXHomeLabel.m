//
//  WXHomeLabel.m
//  NetEaseNewsHomePage
//
//  Created by 王旭 on 2016/11/3.
//  Copyright © 2016年 wangxu. All rights reserved.
//

#import "WXHomeLabel.h"
#import "WXConst.h"


@implementation WXHomeLabel

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        self.font = [UIFont systemFontOfSize:15.0];
        self.textColor = [UIColor colorWithRed:WXRed green:WXGreen blue:WXBlue alpha:WXAlpha];
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
    }
    
    return self;
}


- (void)setScale:(CGFloat)scale{
    _scale = scale;
    
    
    //      R G B
    // 默认：0.4 0.6 0.7
    // 红色：1   0   0
    
    // 颜色渐变处理
    CGFloat red = WXRed + (1 - WXRed) * scale;
    CGFloat green = WXGreen + (0 - WXGreen) * scale;
    CGFloat blue = WXBlue + (0 - WXBlue) * scale;
    self.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    // 大小缩放比例,大小缩放用transform
    CGFloat transformScale = 1 + scale * 0.3;
    self.transform = CGAffineTransformMakeScale(transformScale, transformScale);
}

@end
