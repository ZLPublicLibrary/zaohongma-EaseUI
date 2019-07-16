//
//  ZLEaseUIAdjunctResumeView.m
//  AFNetworking
//
//  Created by 赵磊 on 2019/7/16.
//

#import "ZLEaseUIAdjunctResumeView.h"
#import "ZLEaseMessageManager.h"

@implementation ZLEaseUIAdjunctResumeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

#pragma mark - Lazy
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15.0, 0, 40.0, 40.0)];
        imageView.layer.cornerRadius = CGRectGetHeight(imageView.frame) / 2;
        imageView.layer.masksToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1];
        [self addSubview:imageView];
        _iconImageView = imageView;
    }
    return _iconImageView;
}
- (UIImageView *)unitView {
    if (!_unitView) {
        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 5.0, 0, 249.0, 62.0)];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 62.0, 62.0)];
        button.userInteractionEnabled = NO;
        [button setImage:[ZLEaseMessageManager imageWithCurrentBundleName:@"附件简历-icon"] forState:UIControlStateNormal];
        [view addSubview:button];
        [self addSubview:view];
        _unitView = view;
    }
    return _unitView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(57.0, 0, CGRectGetWidth(self.unitView.frame) - 62.0 - 15.0, 40.0)];
        label.font = [UIFont boldSystemFontOfSize:16.0];
        label.textColor = [UIColor colorWithWhite:0.33 alpha:1.0];
        [self.unitView addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}
- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(57.0, 35.0, CGRectGetWidth(self.unitView.frame) - 62.0 - 15.0, 15.0)];
        label.font = [UIFont systemFontOfSize:13.0];
        label.textColor = [UIColor grayColor];
        [self.unitView addSubview:label];
        _subTitleLabel = label;
    }
    return _subTitleLabel;
}

@end
