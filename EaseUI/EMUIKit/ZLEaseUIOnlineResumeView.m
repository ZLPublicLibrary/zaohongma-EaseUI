//
//  ZLEaseUIOnlineResumeView.m
//  AFNetworking
//
//  Created by 赵磊 on 2019/7/16.
//

#import "ZLEaseUIOnlineResumeView.h"

@implementation ZLEaseUIOnlineResumeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

#pragma mark - Lazy
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15.0, 15.0, 40.0, 40.0)];
        imageView.layer.cornerRadius = CGRectGetHeight(imageView.frame) / 2;
        imageView.layer.masksToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1];
        [self addSubview:imageView];
        _iconImageView = imageView;
    }
    return _iconImageView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 15.0, CGRectGetMinY(self.iconImageView.frame), CGRectGetWidth(self.frame) - CGRectGetMaxX(self.iconImageView.frame) - 30.0, CGRectGetHeight(self.iconImageView.frame))];
        label.font = [UIFont boldSystemFontOfSize:16.0];
        label.textColor = [UIColor colorWithWhite:0.33 alpha:1.0];
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}
- (UILabel *)positionLabel {
    if (!_positionLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(self.iconImageView.frame) + 15.0, (CGRectGetWidth(self.frame) - 40.0) / 2, 20.0)];
        label.font = [UIFont systemFontOfSize:14.0];
        label.textColor = [UIColor grayColor];
        [self addSubview:label];
        _positionLabel = label;
    }
    return _positionLabel;
}
- (UILabel *)compensationLabel {
    if (!_compensationLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.positionLabel.frame) + 10.0, CGRectGetMinY(self.positionLabel.frame), CGRectGetWidth(self.positionLabel.frame), CGRectGetHeight(self.positionLabel.frame))];
        label.font = [UIFont systemFontOfSize:14.0];
        label.textColor = [UIColor grayColor];
        [self addSubview:label];
        _compensationLabel = label;
    }
    return _compensationLabel;
}
- (UIView *)claimView {
    if (!_claimView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(self.compensationLabel.frame) + 12.0, CGRectGetWidth(self.frame) - 30.0, 20.0)];
        
        for (NSInteger index = 0; index < 3; index++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.font = [UIFont systemFontOfSize:12.0];
            label.textColor = UIColor.grayColor;
            label.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.0];
            label.layer.borderColor = [UIColor colorWithWhite:0.92 alpha:1.0].CGColor;
            label.layer.borderWidth = 0.5;
            label.layer.cornerRadius = 3.0;
            label.layer.masksToBounds = YES;
            label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:label];
        }
        
        [self addSubview:view];
        _claimView = view;
    }
    return _claimView;
}

@end
