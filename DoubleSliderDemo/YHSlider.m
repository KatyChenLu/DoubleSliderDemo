//
//  YHSlider.m
//  SliderDemo
//
//  Created by yunhang on 2017/1/10.
//  Copyright © 2017年 muse. All rights reserved.
//

#import "YHSlider.h"


#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define FilterOverFlow 10
@interface YHSlider ()

@property (nonatomic,strong) UIImageView *first;

@property (nonatomic,strong) UIImageView *second;

@property (nonatomic, strong) UILabel *valueLabel;

@end
@implementation YHSlider
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 62)])
    {
        self.backgroundColor = [UIColor clearColor];
        [self first];
        [self second];
        
        
        self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -10, ScreenWidth-38*2, 15)];
        self.valueLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
        
        self.valueLabel.text = [NSString stringWithFormat:@"%.f ~ %.f",self.firstValue,self.secondValue];
        if (self.unit) {
            self.valueLabel.text = [NSString stringWithFormat:@"%@%.f ~ %@%.f",_unit,_firstValue,_unit,_secondValue];
        }
        
        if (self.sliderArr) {
            NSInteger  firstInt =  self.firstValue/10;
            NSInteger secondInt = self.secondValue/10;
            self.valueLabel.text = [NSString stringWithFormat:@"%@~%@",self.sliderArr[firstInt],self.sliderArr[secondInt]];
            if (self.unit) {
                self.valueLabel.text = [NSString stringWithFormat:@"%@%@ ~ %@%@",_unit,self.sliderArr[firstInt],_unit,self.sliderArr[secondInt]];
            }
        }
        self.valueLabel.backgroundColor =[UIColor whiteColor];
        self.valueLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.valueLabel];
    }
    return self;
}
// 在自定义UITabBar中重写以下方法，其中self.button就是那个希望被触发点击事件的按钮
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        // 转换坐标系
        CGPoint newPoint = [self.first convertPoint:point fromView:self];
        
        CGPoint newPoint1 = [self.second convertPoint:point fromView:self];
        
        if (CGRectContainsPoint(self.first.bounds, newPoint)) {
            view = self.first;
        }else if (CGRectContainsPoint(self.second.bounds, newPoint1)){
            view = self.second;
        }
    }
    return view;
}

- (void)drawRect:(CGRect)rect
{
    
    self.first.center = CGPointMake( ((self.firstValue - self.minmumValue)/(self.maxmumValue - self.minmumValue)) *self.frame.size.width, 25);
    self.second.center = CGPointMake( ((self.secondValue - self.minmumValue)/(self.maxmumValue - self.minmumValue)) *self.frame.size.width, 25);
    
    CGFloat value1 = self.firstValue > self.secondValue ? self.secondValue:self.firstValue;
    CGFloat value2 = self.firstValue > self.secondValue ? self.firstValue : self.secondValue;
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CGFloat minumTrackWidth = ((value1 - self.minmumValue)/(self.maxmumValue - self.minmumValue))  * self.frame.size.width;
    CGRect minumTrackRect = CGRectMake(0, 24, minumTrackWidth, 2);
    CGContextSetFillColorWithColor(ref, self.minimumTrackTintColor.CGColor);
    CGContextFillRect(ref, minumTrackRect);
    
    
    CGFloat thumbWidth = ((value2 - value1)/(self.maxmumValue - self.minmumValue)) * self.frame.size.width;
    CGContextSetFillColorWithColor(ref, self.thumbTintColor.CGColor);
    CGRect thumbRect = CGRectMake(minumTrackWidth, 24, thumbWidth, 2);
    CGContextFillRect(ref, thumbRect);
    
    
    CGRect maxumTrackRect = CGRectMake(minumTrackWidth + thumbWidth, 24, self.frame.size.width - minumTrackWidth - thumbWidth, 2);
    CGContextSetFillColorWithColor(ref, self.maximumTrackTintColor.CGColor);
    CGContextFillRect(ref, maxumTrackRect);
    
    CGPDFContextClose(ref);
    
}
#pragma mark - Target
- (void)panHappen:(UIPanGestureRecognizer *)pan
{
    
//    if (_first.center.x < _second.center.x && self.firstValue < self.secondValue && (int)self.firstValue < (int)self.secondValue) {
    if(self.firstValue<self.secondValue){
        CGPoint point = [pan translationInView:self];
        
        CGPoint center = pan.view.center;
        
        center.x += point.x;
        
        if (center.x > 0 && center.x < self.frame.size.width )
        {
            pan.view.center = center;
        }
           [pan setTranslation:CGPointMake(0, 0) inView:self];
     NSLog(@"%f****************%f",self.firstValue,self.secondValue);
        float nomFirValue = self.firstValue;
        float nomSecValue = self.secondValue;
        
        self.firstValue = (_first.center.x/self.frame.size.width) * (self.maxmumValue - self.minmumValue) + self.minmumValue;
        self.secondValue = (_second.center.x/ self.frame.size.width) *(self.maxmumValue - self.minmumValue) + self.minmumValue;
        if (self.firstValue >self.secondValue) {
            self.firstValue = nomFirValue;
            self.secondValue = nomSecValue;
        }
        NSLog(@"%f...........%f",self.firstValue,self.secondValue);
        if ( _secondValue > _maxmumValue-FilterOverFlow +1 ) {
            self.valueLabel.text = [NSString stringWithFormat:@"%d ~ %@",(int)self.firstValue,@"不限"];
            if (self.unit) {
                self.valueLabel.text = [NSString stringWithFormat:@"%@%d ~ %@",_unit,(int)_firstValue,@"不限"];
            }
            if (_sliderArr) {
                NSInteger  firstInt =  self.firstValue/10;
                NSInteger secondInt = self.secondValue/10;
                self.valueLabel.text = [NSString stringWithFormat:@"%@~%@",_sliderArr[firstInt],_sliderArr[secondInt]];
                if (_unit) {
                    self.valueLabel.text = [NSString stringWithFormat:@"%@%@ ~ %@%@",_unit,_sliderArr[firstInt],_unit,_sliderArr[secondInt]];
                    
                }
            }
        }else{
            self.valueLabel.text = [NSString stringWithFormat:@"%.f ~ %.f",self.firstValue,self.secondValue];
            if (self.unit) {
                self.valueLabel.text = [NSString stringWithFormat:@"%@%.f ~ %@%.f",_unit,_firstValue,_unit,_secondValue];
            }
            if (_sliderArr) {
                NSInteger  firstInt =  self.firstValue/10;
                NSInteger secondInt = self.secondValue/10;
                self.valueLabel.text = [NSString stringWithFormat:@"%@~%@",_sliderArr[firstInt],_sliderArr[secondInt]];
                if (_unit) {
                    self.valueLabel.text = [NSString stringWithFormat:@"%@%@ ~ %@%@",_unit,_sliderArr[firstInt],_unit,_sliderArr[secondInt]];
                    
                }
            }
        }
        
    
        [self setNeedsDisplay];
   
    }
   
}
#pragma mark - getter
- (UIColor *)thumbTintColor
{
    if (!_thumbTintColor)
    {
        _thumbTintColor = [self colorWithHexInteger:0x1996fc alpha:1];
    }
    return _thumbTintColor;
}
- (UIColor *)minimumTrackTintColor
{
    if (!_minimumTrackTintColor) {
        _minimumTrackTintColor = [self colorWithHexInteger:0xe9e9e9 alpha:1];
    }
    return _minimumTrackTintColor;
}
- (UIColor *)maximumTrackTintColor
{
    if (!_maximumTrackTintColor)
    {
        _maximumTrackTintColor = [self colorWithHexInteger:0xe9e9e9 alpha:1];
    }
    return _maximumTrackTintColor;
}
- (UIImageView *)first
{
    if (!_first)
    {
        _first = [[UIImageView alloc] init];
        _first.userInteractionEnabled = YES;
        _first.bounds = CGRectMake(0, 10, 50, 50);
        _first.center = CGPointMake(0, 15);
        _first.contentMode = UIViewContentModeCenter;
        [self addSubview:_first];
        [_first addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHappen:)]];
        [self setFirstSliderImg:nil];
    }
    return _first;
}
- (UIImageView *)second
{
    if (!_second)
    {
        _second = [[UIImageView alloc] init];
        _second.userInteractionEnabled = YES;
        _second.frame = CGRectMake(0, 10, 50, 50);
        _second.contentMode = UIViewContentModeCenter;
        _second.center = CGPointMake(self.frame.size.width, 15);
        [_second addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHappen:)]];
        [self addSubview:_second];
        
        [self setSecondSliderImg:nil];
    }
    return _second;
}
#pragma mark - setter
- (void)setFirstSliderImg:(UIImage *)firstSliderImg
{
    if (firstSliderImg != _firstSliderImg)
    {
        _firstSliderImg = firstSliderImg;
    }
    if (_firstSliderImg == nil)
    {
        //        self.first.layer.shadowColor =  [UIColor colorWithWhite:0.3 alpha:1].CGColor;
        //        self.first.layer.shadowRadius = 3;
        //        self.first.layer.shadowOffset = CGSizeMake(0, 2);
        //        self.first.layer.shadowOpacity = 0.6;
    }
    else
    {
        self.first.image = firstSliderImg;
        //        self.first.
    }
}
- (void)setSecondSliderImg:(UIImage *)secondSliderImg
{
    if (_secondSliderImg != secondSliderImg)
    {
        _secondSliderImg = secondSliderImg;
    }
    if (_secondSliderImg == nil)
    {
        //        self.second.layer.shadowColor = [UIColor colorWithWhite:0.3 alpha:1].CGColor;
        //        self.second.layer.shadowRadius = 3;
        //        self.second.layer.shadowOffset = CGSizeMake(0, 2);
        //        self.second.layer.shadowOpacity = 0.6;
    }
    else
    {
        self.second.image = _secondSliderImg;
    }
}
- (void)setFirstValue:(float)firstValue
{
    _firstValue = firstValue;
    [self setNeedsDisplay];
    self.valueLabel.text = [NSString stringWithFormat:@"%.f ~ %.f",_firstValue,_secondValue];
    if (_sliderArr) {
        NSInteger  firstInt =  self.firstValue/10;
        NSInteger secondInt = self.secondValue/10;
        self.valueLabel.text = [NSString stringWithFormat:@"%@~%@",_sliderArr[firstInt],_sliderArr[secondInt]];
        if (_unit) {
            self.valueLabel.text = [NSString stringWithFormat:@"%@%@ ~ %@%@",_unit,_sliderArr[firstInt],_unit,_sliderArr[secondInt]];
            
        }
    }
    if (_unit.length) {
        self.valueLabel.text = [NSString stringWithFormat:@"%@%.f ~ %@%.f",_unit,_firstValue,_unit,_secondValue];
    }
}
- (void)setSecondValue:(float)secondValue
{
    _secondValue = secondValue;
    
    
    [self setNeedsDisplay];
    if (_secondValue > _maxmumValue-FilterOverFlow+1) {
        self.valueLabel.text = [NSString stringWithFormat:@"%.f ~ %@",_firstValue,@"不限"];
        if (_sliderArr) {
            NSInteger  firstInt =  self.firstValue/10;
            NSInteger secondInt = self.secondValue/10;
            self.valueLabel.text = [NSString stringWithFormat:@"%@~%@",_sliderArr[firstInt],_sliderArr[secondInt]];
            if (_unit) {
                self.valueLabel.text = [NSString stringWithFormat:@"%@%@ ~ %@",_unit,_sliderArr[firstInt],@"不限"];
                
            }
        }
        if (_unit.length) {
            self.valueLabel.text = [NSString stringWithFormat:@"%@%.f ~ %@",_unit,_firstValue,@"不限"];
        }
    }else{
        self.valueLabel.text = [NSString stringWithFormat:@"%.f ~ %.f",_firstValue,_secondValue];
        if (_sliderArr) {
            NSInteger  firstInt =  self.firstValue/10;
            NSInteger secondInt = self.secondValue/10;
            self.valueLabel.text = [NSString stringWithFormat:@"%@~%@",_sliderArr[firstInt],_sliderArr[secondInt]];
            if (_unit) {
                self.valueLabel.text = [NSString stringWithFormat:@"%@%@ ~ %@%@",_unit,_sliderArr[firstInt],_unit,_sliderArr[secondInt]];
                
            }
        }
        if (_unit.length) {
            self.valueLabel.text = [NSString stringWithFormat:@"%@%.f ~ %@%.f",_unit,_firstValue,_unit,_secondValue];
        }
    }
    
}
- (void)setSliderArr:(NSArray *)sliderArr {
    _sliderArr = sliderArr;
    if (_sliderArr) {
        NSInteger  firstInt =  self.firstValue/10;
        NSInteger secondInt = self.secondValue/10;
        self.valueLabel.text = [NSString stringWithFormat:@"%@ ~ %@",_sliderArr[firstInt],_sliderArr[secondInt]];
        if (_unit) {
            self.valueLabel.text = [NSString stringWithFormat:@"%@%@ ~ %@%@",_unit,_sliderArr[firstInt],_unit,_sliderArr[secondInt]];
            
        }
    }
}
- (void)setUnit:(NSString *)unit {
    _unit = unit;
    if (_unit.length) {
        self.valueLabel.text = [NSString stringWithFormat:@"%@%.f ~ %@%.f",_unit,_firstValue,_unit,_secondValue];
        
        if (_sliderArr) {
            NSInteger  firstInt =  self.firstValue/10;
            NSInteger secondInt = self.secondValue/10;
            self.valueLabel.text = [NSString stringWithFormat:@"%@%@ ~ %@%@",_unit,_sliderArr[firstInt],_unit,_sliderArr[secondInt]];
        }
        
    }
}
- (void)setMinmumValue:(float)minmumValue
{
    _minmumValue = minmumValue;
    [self setNeedsDisplay];
}
- (void)setMaxmumValue:(float)maxmumValue
{
    _maxmumValue = maxmumValue;
    [self setNeedsDisplay];
}
#pragma mark - Method
- (UIColor *)colorWithHexInteger:(NSInteger)hexInteger alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((hexInteger >> 16) & 0xFF)/255.0 green:((hexInteger >> 8) & 0xFF)/255.0 blue:((hexInteger) & 0xFF)/255.0 alpha:alpha];
}
@end
