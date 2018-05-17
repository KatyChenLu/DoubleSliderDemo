//
//  KAFilterView.h
//  MasterKA
//
//  Created by ChenLu on 2017/10/11.
//  Copyright © 2017年 chenlu. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface KAFilterView : UIView

typedef NS_ENUM(NSInteger,filterType){
    jampanFilter =0,
    optionFilter,
};

/**
 筛选arr
 */
@property (nonatomic,strong) NSMutableArray *filterArr;



@property(nonatomic , copy)void(^filterSendBlock)(CGFloat min,CGFloat max);
@property(nonatomic, copy)void(^touchBlock)();
@property (nonatomic, assign) filterType type;

@property (nonatomic, strong)NSString *filerMin;
@property (nonatomic, strong)NSString *filerMax;

@property (nonatomic, strong)NSArray *sliderArr;

- (void)animateAction;
- (void)baceAnimateAction;
- (instancetype)initWithFrame:(CGRect)frame withFilerMin:(CGFloat )filerMin filerMax:(CGFloat )filerMax selectMin:(CGFloat )selectMin selectMax:(CGFloat )selectMax sliderArr:(NSArray *)sliderArr unit:(NSString *)unit;
@end
