//
//  ZLEaseUIPositionView.m
//  AFNetworking
//
//  Created by 赵磊 on 2019/7/16.
//

#import "ZLEaseUIPositionView.h"

@implementation ZLEaseUIPositionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

#pragma mark - Lazy
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 15.0, CGRectGetWidth(self.frame) - 30.0 - 100.0, 30.0)];
        label.font = [UIFont boldSystemFontOfSize:17.0];
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + 10.0, 15.0, 90.0, 30.0)];
        label.font = [UIFont boldSystemFontOfSize:15.0];
        label.textColor = [UIColor colorWithRed:52 / 255.0 green:144 / 255.0 blue:239 / 255.0 alpha:1.0];
        label.textAlignment = NSTextAlignmentRight;
        [self addSubview:label];
        _priceLabel = label;
    }
    return _priceLabel;
}
- (UILabel *)numberLabel {
    if (!_numberLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(self.titleLabel.frame), CGRectGetWidth(self.frame) - 30.0, 20.0)];
        label.font = [UIFont systemFontOfSize:14.0];
        label.textColor = UIColor.grayColor;
        [self addSubview:label];
        _numberLabel = label;
    }
    return _numberLabel;
}
- (UIView *)claimView {
    if (!_claimView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15.0, CGRectGetMaxY(self.numberLabel.frame) + 11.0, CGRectGetWidth(self.frame) - 30.0, 20.0)];
        
        for (NSInteger index = 0; index < 3; index++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.font = [UIFont systemFontOfSize:12.0];
            label.textColor = UIColor.grayColor;
            label.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.0];
            label.layer.borderColor = [UIColor colorWithWhite:0.92 alpha:1.0].CGColor;
            label.layer.borderWidth = 1.5;
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
