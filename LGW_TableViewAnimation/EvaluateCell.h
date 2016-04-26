//
//  EvaluateCell.h
//  LGW_TableViewAnimation
//
//  Created by Lilong on 16/4/25.
//  Copyright © 2016年 第七代目. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, AnimationType) {
    animationTypeNO = 0, // 没有动画
    animationTypeLeft = 1,  // 从左边到中间
    animationTypeRight = 2,  // 从右边到中间
    AnimationTypeUp = 3,
    AnimationTypeDown = 4,
};

@interface EvaluateCell : UITableViewCell
@property (assign, nonatomic) AnimationType type;
- (void)setupCellWithTitle:(NSString *)title AndAnimationType:(AnimationType )animationType;

@end
