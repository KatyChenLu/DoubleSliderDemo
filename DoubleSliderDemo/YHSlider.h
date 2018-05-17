//
//  YHSlider.h
//  SliderDemo
//
//  Created by yunhang on 2017/1/10.
//  Copyright © 2017年 muse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHSlider : UIView

@property (nonatomic) float firstValue;      //default 0.0
@property (nonatomic) float secondValue;

@property (nonatomic) float minmumValue;//default 0.0
@property (nonatomic) float maxmumValue;//default 0.0

@property (nullable,nonatomic,strong) UIImage *  firstSliderImg;
@property (nullable,nonatomic,strong) UIImage * secondSliderImg;


@property(nullable, nonatomic,strong) UIColor *minimumTrackTintColor ;
@property(nullable, nonatomic,strong) UIColor *maximumTrackTintColor;
@property(nullable, nonatomic,strong) UIColor *thumbTintColor ;

@property (nonatomic, strong)NSArray *sliderArr;
@property (nonatomic, strong)NSString *unit;

//set the width is available,set the height is nonsense
//- (instancetype)initWithFrame:(CGRect)frame;

@end
