//
//  UIImage+Color.h
//  DoubleSliderDemo
//
//  Created by ChenLu on 2018/5/17.
//  Copyright © 2018年 Chenlu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

/**
 *  @brief  根据颜色生成纯色图片
 *
 *  @param color 颜色
 *
 *  @return 纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
@end
