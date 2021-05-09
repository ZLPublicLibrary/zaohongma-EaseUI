//
//  ZLEaseUIInterviewInvitationView.m
//  AFNetworking
//
//  Created by 赵磊 on 2019/7/16.
//

#import "ZLEaseUIInterviewInvitationView.h"
#import "ZLEaseMessageManager.h"

@interface ZLEaseUIInterviewInvitationItemView ()

///标题
@property (nonatomic,weak) UILabel *titleLabel;
///内容
@property (nonatomic,weak) UILabel *contentLabel;

@end

@implementation ZLEaseUIInterviewInvitationItemView

#pragma mark - Set
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}
- (void)setContent:(NSString *)content {
    _content = content;
    if (!content) {
        return;
    }
    NSMutableAttributedString *attrM = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5.0;
    [attrM addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, content.length)];
    [attrM addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Light" size:15.0] range:NSMakeRange(0, attrM.string.length)];
    [attrM addAttribute:NSForegroundColorAttributeName value:self.phone ? [UIColor colorWithRed:81 / 255.0 green:197 / 255.0 blue:181 / 255.0 alpha:1.0] : UIColor.blackColor range:NSMakeRange(0, attrM.string.length)];
    self.contentLabel.attributedText = attrM;
    
    CGFloat height = [content boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 75.0 - 32.0 - 20.0 - 70.0, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont fontWithName:@"PingFangSC-Light" size:15.0],NSParagraphStyleAttributeName:style} context:nil].size.height;
    
    self.contentLabel.frame = CGRectMake(self.contentLabel.frame.origin.x, self.contentLabel.frame.origin.y, self.contentLabel.frame.size.width, height);
    
    if (self.contentLabel.frame.size.height < self.titleLabel.frame.size.height) {
        self.contentLabel.frame = CGRectMake(self.contentLabel.frame.origin.x, self.contentLabel.frame.origin.y, self.contentLabel.frame.size.width, self.titleLabel.frame.size.height);
    }
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

+ (CGFloat)getHeightWithContent:(NSString *)content {
    if (!content) {
        return 0;
    }
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5.0;
    CGFloat height = [content boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 75.0 - 32.0 - 20.0 - 70.0, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont fontWithName:@"PingFangSC-Light" size:15.0],NSParagraphStyleAttributeName:style} context:nil].size.height;
    height = height < 20.0 ? 20.0 : height;
    return height;
}

#pragma mark - Lazy
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 75.0, 20.0)];
        label.font = [UIFont fontWithName:@"PingFangSC-Light" size:15.0];
        label.textColor = UIColor.blackColor;
        label.textAlignment = NSTextAlignmentRight;
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(75.0, 0, CGRectGetWidth(self.frame) - 75.0, 20.0)];
        label.numberOfLines = 0;
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action)]];
        [self addSubview:label];
        _contentLabel = label;
    }
    return _contentLabel;
}

- (void)action {
    if (!self.phone) {
        return;
    }
    //拨打电话
    NSString * phone = [NSString stringWithFormat:@"telprompt://%@",self.content];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
}

@end

@implementation ZLEaseUIInterviewInvitationView

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
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16.0, 16.0, 65.0, 22.0)];
        label.font = [UIFont boldSystemFontOfSize:16.0];
        label.textColor = UIColor.blackColor;
        label.text = @"面试邀请";
        [view addSubview:label];
        
        [self addSubview:view];
        _unitView = view;
    }
    return _unitView;
}
- (ZLEaseUIInterviewInvitationItemView *)timeView {
    if (!_timeView) {
        ZLEaseUIInterviewInvitationItemView *label = [[ZLEaseUIInterviewInvitationItemView alloc] initWithFrame:CGRectMake(16.0, 16.0 + 22.0 + 15.0, self.unitView.frame.size.width - 32.0, 20.0)];
        label.title = @"面试时间：";
        [self.unitView addSubview:label];
        _timeView = label;
    }
    return _timeView;
}
- (ZLEaseUIInterviewInvitationItemView *)addressView {
    if (!_addressView) {
        ZLEaseUIInterviewInvitationItemView *label = [[ZLEaseUIInterviewInvitationItemView alloc] initWithFrame:CGRectMake(16.0, CGRectGetMaxY(self.timeView.frame) + 8.0, self.unitView.frame.size.width - 32.0, 20.0)];
        label.title = @"面试地址：";
        [self.unitView addSubview:label];
        _addressView = label;
    }
    return _addressView;
}
- (ZLEaseUIInterviewInvitationItemView *)nameView {
    if (!_nameView) {
        ZLEaseUIInterviewInvitationItemView *label = [[ZLEaseUIInterviewInvitationItemView alloc] initWithFrame:CGRectMake(16.0, CGRectGetMaxY(self.addressView.frame) + 8.0, self.unitView.frame.size.width - 32.0, 20.0)];
        label.title = @"联系人：";
        [self.unitView addSubview:label];
        _nameView = label;
    }
    return _nameView;
}
- (ZLEaseUIInterviewInvitationItemView *)phoneView {
    if (!_phoneView) {
        ZLEaseUIInterviewInvitationItemView *label = [[ZLEaseUIInterviewInvitationItemView alloc] initWithFrame:CGRectMake(16.0, CGRectGetMaxY(self.nameView.frame) + 8.0, self.unitView.frame.size.width - 32.0, 20.0)];
        label.phone = YES;
        label.title = @"联系电话：";
        [self.unitView addSubview:label];
        _phoneView = label;
    }
    return _phoneView;
}
- (ZLEaseUIInterviewInvitationItemView *)remarksView {
    if (!_remarksView) {
        ZLEaseUIInterviewInvitationItemView *label = [[ZLEaseUIInterviewInvitationItemView alloc] initWithFrame:CGRectMake(16.0, CGRectGetMaxY(self.phoneView.frame) + 8.0, self.unitView.frame.size.width - 32.0, 20.0)];
        label.title = @"备注信息：";
        [self.unitView addSubview:label];
        _remarksView = label;
    }
    return _remarksView;
}

@end
