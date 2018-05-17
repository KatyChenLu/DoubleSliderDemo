//
//  ViewController.m
//  DoubleSliderDemo
//
//  Created by ChenLu on 2018/5/17.
//  Copyright © 2018年 Chenlu. All rights reserved.
//

#import "ViewController.h"
#import "KAFilterView.h"
#import "LeftTitleBtn.h"
#import "UIImage+Color.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height


//设定色值
#define RGBFromHexadecimal(value) [UIColor colorWithRed:((float)((value & 0xFF0000) >> 16))/255.0 green:((float)((value & 0xFF00) >> 8))/255.0 blue:((float)(value & 0xFF))/255.0 alpha:1.0]

//“不限”时多加的值
#define FilterOverFlow 10

@interface ViewController ()

@property (nonatomic, strong) KAFilterView *filterView0;
@property (nonatomic, strong) KAFilterView *filterView1;
@property (nonatomic, strong) KAFilterView *filterView2;
@property (nonatomic, strong) UIView *filterTitleView;
@property (nonatomic, strong)NSMutableArray *titleBtnArr;
@property (nonatomic,strong) NSMutableArray *filterArr;



@property (nonatomic, assign)CGFloat peopleMin;
@property (nonatomic, assign)CGFloat peopleMax;
@property (nonatomic, assign)CGFloat priceMin;
@property (nonatomic, assign)CGFloat priceMax;
@property (nonatomic, assign)CGFloat timeMin;
@property (nonatomic, assign)CGFloat timeMax;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.priceMin =0;
    self.priceMax =100+FilterOverFlow;
    self.peopleMin = 0;
    self.peopleMax = 200+FilterOverFlow;
    self.timeMin = 0;
    self.timeMax = 90 ;
    
    self.filterArr = [[NSMutableArray alloc] initWithCapacity:3];
    self.titleBtnArr = [[NSMutableArray alloc] initWithCapacity:3];
    
     [self.view addSubview:self.filterTitleView];
    self.view.backgroundColor = [UIColor lightGrayColor];
}


- (UIView *)filterTitleView {
    if (!_filterTitleView) {
        _filterTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, 40)];
        _filterTitleView.backgroundColor = [UIColor whiteColor];
        NSArray *titleArr = @[@"价格",@"人数",@"时长"];
        for (int i = 0; i<titleArr.count ; i++) {
            LeftTitleBtn * categoryBtn = [[LeftTitleBtn alloc]initWithFrame:CGRectMake(ScreenWidth/titleArr.count*i, 0, ScreenWidth/titleArr.count, 40)];
            [categoryBtn addTarget: self action:@selector(titleAction:) forControlEvents:UIControlEventTouchUpInside];
            [categoryBtn setTitle:titleArr[i] forState:UIControlStateNormal];
            categoryBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            categoryBtn.tag = i;
            [categoryBtn setImage:[UIImage imageNamed:@"jiantoushang"] forState:UIControlStateNormal];
            [categoryBtn setImage:[UIImage imageNamed:@"jiantouxia" ] forState:UIControlStateSelected];
            [categoryBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            [categoryBtn setBackgroundImage:[UIImage imageWithColor:RGBFromHexadecimal(0xf8f7f5)] forState:UIControlStateSelected];
            [categoryBtn setBackgroundImage:[UIImage imageWithColor:RGBFromHexadecimal(0xf8f7f5)] forState:UIControlStateHighlighted];
            [categoryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_filterTitleView addSubview:categoryBtn];
            [_titleBtnArr addObject:categoryBtn];
        }
        
    }
    return _filterTitleView;
}

- (KAFilterView *)filterView0 {
    if (!_filterView0) {
        _filterView0 = [[KAFilterView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeight) withFilerMin:0 filerMax:100+FilterOverFlow selectMin:self.priceMin selectMax:self.priceMax sliderArr:nil unit:@"￥"];
    }
    return _filterView0;
}
- (KAFilterView *)filterView1 {
    if (!_filterView1) {
        _filterView1 = [[KAFilterView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeight) withFilerMin:0 filerMax:200+FilterOverFlow selectMin:self.peopleMin selectMax:self.peopleMax sliderArr:nil unit:nil];
    }
    return _filterView1;
}
- (KAFilterView *)filterView2 {
    if (!_filterView2) {
        _filterView2 = [[KAFilterView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeight) withFilerMin:0 filerMax:90 selectMin:self.timeMin selectMax:self.timeMax sliderArr:@[@"1小时",@"1.5小时",@"2小时",@"2.5小0时",@"3小时",@"3.5小时",@"半天",@"一天",@"两天",@"三天及以上"] unit:nil];
        
    }
    return _filterView2;
}


- (void)titleAction:(LeftTitleBtn *)sender {
    for (KAFilterView *fil in self.filterArr) {
        [fil removeFromSuperview];
        [self.filterArr removeAllObjects];
    }
    
    
    if ([_titleBtnArr indexOfObject:sender] == 0){
        
        
        [self.view addSubview:self.filterView0];
        [self.filterView0 animateAction];
        [self.filterArr addObject:self.filterView0];
        __weak typeof(self) weakself = self;
        [_filterView0 setFilterSendBlock:^(CGFloat min, CGFloat max) {
           __strong typeof(self) strongself = weakself;
            strongself.priceMin = min;
            strongself.priceMax = max;
//            [self first];
            for (LeftTitleBtn *btn in strongself.titleBtnArr) {
                btn.selected = NO;
                [strongself.filterView0 baceAnimateAction];
            }
        }];
        
        [_filterView0 setTouchBlock:^{
             __strong typeof(self) strongself = weakself;
            for (LeftTitleBtn *btn in strongself.titleBtnArr) {
                btn.selected = NO;
                //                    [self.filterView0 baceAnimateAction];
            }
            
        }];
    }else if ([_titleBtnArr indexOfObject:sender] == 1) {
        [self.view addSubview:self.filterView1];
        [self.filterView1 animateAction];
        [self.filterArr addObject:self.filterView1];
        __weak typeof(self) weakself = self;
        [_filterView1 setFilterSendBlock:^(CGFloat min, CGFloat max) {
            __strong typeof(self) strongself = weakself;
            strongself.peopleMin = min;
            strongself.peopleMax = max;
//            [self first];
            for (LeftTitleBtn *btn in strongself.titleBtnArr) {
                btn.selected = NO;
                [strongself.filterView1 baceAnimateAction];
            }
            
        }];
        [_filterView1 setTouchBlock:^{
       __weak typeof(self) weakself = self;
            for (LeftTitleBtn *btn in self.titleBtnArr) {
                
                btn.selected = NO;
                //                   [self.filterView1 baceAnimateAction];
            }
            
        }];
    } else if ([_titleBtnArr indexOfObject:sender] == 2){
        [self.view addSubview:self.filterView2];
        [self.filterView2 animateAction];
        [self.filterArr addObject:self.filterView2];
      __weak typeof(self) weakself = self;
        [_filterView2 setFilterSendBlock:^(CGFloat min, CGFloat max) {
          
            self.timeMin = min;
            self.timeMax = max;
//            [self first];
            for (LeftTitleBtn *btn in self.titleBtnArr) {
                btn.selected = NO;
                [self.filterView2 baceAnimateAction];
            }
            
        }];
        [_filterView2 setTouchBlock:^{
        
            for (LeftTitleBtn *btn in self.titleBtnArr) {
                
                btn.selected = NO;
                //                   [self.filterView2 baceAnimateAction];
            }
            
        }];
        
    }
    
    for (LeftTitleBtn *btn in _titleBtnArr) {
        if (btn.tag == [_titleBtnArr indexOfObject:sender]) {
            if (sender.selected) {
                KAFilterView *selecFilter = [self.filterArr objectAtIndex:0];
                [selecFilter baceAnimateAction];
            }
            sender.selected = !sender.selected;
        }else{
            btn.selected = NO;
        }
        
    }
    
    //    if (sender.selected) {
    ////        sender.imageView.tintColor = RGBFromHexadecimal(0xff5e28);
    //    }
    [self.view bringSubviewToFront:self.filterTitleView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
