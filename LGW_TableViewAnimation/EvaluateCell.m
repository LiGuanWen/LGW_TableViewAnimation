//
//  EvaluateCell.m
//  LGW_TableViewAnimation
//
//  Created by Lilong on 16/4/25.
//  Copyright © 2016年 第七代目. All rights reserved.
//

#import "EvaluateCell.h"
#define LWidth ([UIScreen mainScreen].bounds.size.width)
#define animationDelay 0.0
#define defaultDuration 0.5
@interface EvaluateCell ()
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoViewToLeftConstraint;
@property (assign, nonatomic) BOOL popped;
@end

@implementation EvaluateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupCellWithTitle:(NSString *)title AndAnimationType:(AnimationType )animationType{
    [self.infoView setFrame:CGRectMake(0, 0, LWidth, 50)];
    
    self.titleLab.text = [NSString stringWithFormat:@"%@    (*^__^*) 嘻嘻……",title];
    if (animationType == AnimationTypeUp)
    {
        [self.infoView setCenter:CGPointMake(0, -self.infoView.frame.size.height)];
    } else if (animationType == AnimationTypeDown)
    {
        [self.infoView setCenter:CGPointMake(0, self.infoView.frame.size.height)];
    } else if (animationType == animationTypeLeft)
    {
        [self.infoView setCenter:CGPointMake(-self.infoView.frame.size.width, 0)];
    } else if (animationType == animationTypeRight)
    {
        [self.infoView setCenter:CGPointMake(self.infoView.frame.size.width, 0)];
    } else {
        [self.infoView setCenter:CGPointMake(0, 0)];
    }
    [UIView animateWithDuration:0.5
                          delay:animationDelay
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{self.infoView.center = CGPointMake(0, 0);}
                     completion:nil];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
