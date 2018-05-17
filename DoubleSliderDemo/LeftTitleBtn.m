//
//  LeftTitleBtn.m
//  MasterKA
//
//  Created by 余伟 on 16/12/13.
//  Copyright © 2016年 jinghao. All rights reserved.
//

#import "LeftTitleBtn.h"

@implementation LeftTitleBtn

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    CGRect imageRect =  self.imageView.frame;
    
    CGRect labelRect =  self.titleLabel.frame;
        
    labelRect.origin.x = ceil((self.frame.size.width-labelRect.size.width)/2);
    
    labelRect = CGRectIntegral(labelRect);
    
    self.titleLabel.frame = labelRect;
    
    imageRect.origin.x = CGRectGetMaxX(labelRect) + 10;
    
    self.imageView.frame = imageRect;
    
}

@end
