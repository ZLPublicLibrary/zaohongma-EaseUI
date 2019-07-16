//
//  ZLEaseUIInterviewInvitationView.m
//  AFNetworking
//
//  Created by 赵磊 on 2019/7/16.
//

#import "ZLEaseUIInterviewInvitationView.h"
#import "ZLEaseMessageManager.h"

@implementation ZLEaseUIInterviewInvitationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
        self.backgroundColor = UIColor.whiteColor;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60.0, 80.0)];
        button.userInteractionEnabled = NO;
        [button setImage:[ZLEaseMessageManager imageWithCurrentBundleName:@"面试邀请"] forState:UIControlStateNormal];
        [self addSubview:button];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60.0, 47.0, CGRectGetWidth(self.frame) - 60.0 - 15.0, 15.0)];
        label.font = [UIFont systemFontOfSize:14.0];
        label.textColor = [UIColor colorWithRed:52 / 255.0 green:112 / 255.0 blue:159 / 255.0 alpha:1.0];
        label.text = @"点击查看";
        [self addSubview:label];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60.0, 10.0, CGRectGetWidth(self.frame) - 15.0 - 15.0, 30.0)];
        label.font = [UIFont boldSystemFontOfSize:16.0];
        label.textColor = [UIColor colorWithWhite:0.33 alpha:1.0];
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

@end
