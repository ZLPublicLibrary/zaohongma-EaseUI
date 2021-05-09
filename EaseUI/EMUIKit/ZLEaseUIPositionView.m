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
    
    }
    return self;
}

#pragma mark - Lazy
- (UIImageView *)sendUserIconImageView {
    if (!_sendUserIconImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40.0, 40.0)];
        imageView.layer.cornerRadius = CGRectGetHeight(imageView.frame) / 2;
        imageView.layer.masksToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1];
        [self addSubview:imageView];
        _sendUserIconImageView = imageView;
    }
    return _sendUserIconImageView;
}
- (UIView *)unitView {
    if (!_unitView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width - 70.0, 155.0)];
        view.layer.cornerRadius = 5.0;
        view.layer.masksToBounds = YES;
        view.backgroundColor = UIColor.whiteColor;
        [self addSubview:view];
        _unitView = view;
    }
    return _unitView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16.0, 16.0, CGRectGetWidth(self.unitView.frame) - 32.0 - 100.0, 22.0)];
        label.font = [UIFont boldSystemFontOfSize:16.0];
        [self.unitView addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + 10.0, 15.0, 90.0, 30.0)];
        label.font = [UIFont boldSystemFontOfSize:15.0];
        label.textColor = [UIColor colorWithRed:81 / 255.0 green:197 / 255.0 blue:181 / 255.0 alpha:100.0 / 255.0];
        label.textAlignment = NSTextAlignmentRight;
        [self.unitView addSubview:label];
        _priceLabel = label;
    }
    return _priceLabel;
}
- (UIView *)claimView {
    if (!_claimView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(16.0, CGRectGetMaxY(self.titleLabel.frame) + 10.0, CGRectGetWidth(self.unitView.frame) - 32.0, 20.0)];
        
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
        
        [self.unitView addSubview:view];
        _claimView = view;
    }
    return _claimView;
}
- (UILabel *)requireLabel {
    if (!_requireLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16.0, CGRectGetMaxY(self.claimView.frame) + 15.0, CGRectGetWidth(self.unitView.frame) - 32.0, 20.0)];
        label.numberOfLines = 0;
        [self.unitView addSubview:label];
        _requireLabel = label;
    }
    return _requireLabel;
}

@end
