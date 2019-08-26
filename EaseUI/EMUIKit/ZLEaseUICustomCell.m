//
//  ZLEaseUIPositionCell.m
//  EaseUILite
//
//  Created by 赵磊 on 2019/7/15.
//

#import "ZLEaseUICustomCell.h"
#import "UIImageView+WebCache.h"
#import "EaseBubbleView+Gif.h"
#import "IMessageModel.h"
#import "ZLEaseMessageManager.h"
#import "ZLEaseUIPositionView.h"
#import "ZLEaseUIOnlineResumeView.h"
#import "ZLEaseUIAdjunctResumeView.h"
#import "ZLEaseUIInterviewInvitationView.h"

@interface ZLEaseUICustomCell ()

///单元视图
@property (nonatomic,weak) UIView *unitView;
///职位
@property (nonatomic,weak) ZLEaseUIPositionView *positionView;
///在线简历
@property (nonatomic,weak) ZLEaseUIOnlineResumeView *onlineResumeView;
///附件简历
@property (nonatomic,weak) ZLEaseUIAdjunctResumeView *adjunctResumeView;
///面试邀请
@property (nonatomic,weak) ZLEaseUIInterviewInvitationView *interviewInvitationView;

@end

@implementation ZLEaseUICustomCell

+ (void)initialize
{
    // UIAppearance Proxy Defaults
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(id<IMessageModel>)model {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier model:model]) {
        [self unitView];
    }
    return self;
}

#pragma mark - IModelCell

- (BOOL)isCustomBubbleView:(id<IMessageModel>)model
{
    return YES;
}

- (void)setCustomModel:(id<IMessageModel>)model
{
    //隐藏自带的控件
    self.messageNameHeight = 0.01;
    self.avatarView.hidden = YES;
    self.bubbleView.imageView.hidden = YES;
    self.bubbleView.hidden = YES;;
    self.hasRead.hidden = YES;
    //赋值
    self.unitView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, [ZLEaseUICustomCell cellHeightWithModel:model]);
    NSInteger type = [model.message.ext[@"type"] integerValue];
    self.onlineResumeView.hidden = YES;
    self.adjunctResumeView.hidden = YES;
    self.interviewInvitationView.hidden = YES;
    self.positionView.hidden = YES;
    if (type == 1) {//简历
        self.onlineResumeView.hidden = NO;
        [self.onlineResumeView.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.message.ext[@"head"]]];
        self.onlineResumeView.titleLabel.text = model.message.ext[@"name"];
        self.onlineResumeView.positionLabel.text = model.message.ext[@"position"];
        self.onlineResumeView.compensationLabel.text = model.message.ext[@"salary"];
        
        NSString *education = model.message.ext[@"education"];
        CGFloat educationWidth = [education boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil].size.width;
        UILabel *label = self.onlineResumeView.claimView.subviews.firstObject;
        label.frame = CGRectMake(0, 0, educationWidth + 10.0, 20.0);
        label.text = education;
        
        NSString *jobExperience = model.message.ext[@"job_experience"];
        CGFloat jobExperienceWidth = [jobExperience boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil].size.width;
        label = self.onlineResumeView.claimView.subviews[1];
        label.frame = CGRectMake(CGRectGetMaxX(self.onlineResumeView.claimView.subviews.firstObject.frame) + 10.0, 0, jobExperienceWidth + 10.0, 20.0);
        label.text = jobExperience;
        
        NSString *jobStatus = model.message.ext[@"job_status"];
        CGFloat jobStatusWidth = [jobStatus boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil].size.width;
        label = self.onlineResumeView.claimView.subviews[2];
        label.frame = CGRectMake(CGRectGetMaxX(self.onlineResumeView.claimView.subviews[1].frame) + 10.0, 0, jobStatusWidth + 10.0, 20.0);
        label.text = jobStatus;
    }else if (type == 2) {//附件
        self.adjunctResumeView.hidden = NO;
        self.adjunctResumeView.iconImageView.image = model.isSender ? [ZLEaseMessageManager shared].myIcon : [ZLEaseMessageManager shared].sideIcon;
        self.adjunctResumeView.iconImageView.frame = CGRectMake(model.isSender ? CGRectGetWidth(self.adjunctResumeView.frame) - 55.0 : 15.0, 0, 40.0, 40.0);
        self.adjunctResumeView.unitView.frame = CGRectMake(model.isSender ? CGRectGetWidth(self.adjunctResumeView.frame) - 15.0 - 40.0 - 5.0 - 249.0 : 15.0 + 40.0 + 5.0, 0, 249.0, 62.0);
        UIImage *image = [ZLEaseMessageManager imageWithCurrentBundleName:model.isSender ? @"chat_sender_bg" : @"chat_receiver_bg"];
        self.adjunctResumeView.unitView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(30.0, model.isSender ? 5.0 : 10.0, 5.0, model.isSender ? 10.0 : 5.0) resizingMode:(UIImageResizingModeStretch)];
        self.adjunctResumeView.titleLabel.text = model.message.ext[@"title"];
        self.adjunctResumeView.subTitleLabel.text = model.message.ext[@"size"];
    }else if (type == 3) {//面试邀请
        self.interviewInvitationView.hidden = NO;
        self.interviewInvitationView.titleLabel.text = model.isSender ? @"您给对方发送了一份面试邀请" : @"对方给您发送了一份面试邀请";
    }else if (type == 4) {//职位
        self.positionView.hidden = NO;
        self.positionView.titleLabel.text = model.message.ext[@"title"];
        self.positionView.priceLabel.text = model.message.ext[@"salary"];
        self.positionView.numberLabel.text = model.message.ext[@"CorporateName"];
        
        NSString *education = model.message.ext[@"workplace"];
        CGFloat educationWidth = [education boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil].size.width;
        UILabel *label = self.positionView.claimView.subviews.firstObject;
        label.frame = CGRectMake(0, 0, educationWidth + 10.0, 20.0);
        label.text = education;
        
        NSString *jobExperience = model.message.ext[@"work_experience"];
        CGFloat jobExperienceWidth = [jobExperience boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil].size.width;
        label = self.positionView.claimView.subviews[1];
        label.frame = CGRectMake(CGRectGetMaxX(self.positionView.claimView.subviews.firstObject.frame) + 10.0, 0, jobExperienceWidth + 10.0, 20.0);
        label.text = jobExperience;
        
        NSString *jobStatus = model.message.ext[@"education"];
        CGFloat jobStatusWidth = [jobStatus boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil].size.width;
        label = self.positionView.claimView.subviews[2];
        label.frame = CGRectMake(CGRectGetMaxX(self.positionView.claimView.subviews[1].frame) + 10.0, 0, jobStatusWidth + 10.0, 20.0);
        label.text = jobStatus;
    }
}

///必须实现
- (void)setCustomBubbleView:(id<IMessageModel>)model
{
    [_bubbleView setupGifBubbleView];
}
- (void)updateCustomBubbleViewMargin:(UIEdgeInsets)bubbleMargin model:(id<IMessageModel>)model
{
    [_bubbleView updateGifMargin:bubbleMargin];
}
/*!
 @method
 @brief 获取cell的重用标识
 @discussion
 @param model   消息model
 @return 返回cell的重用标识
 */
+ (NSString *)cellIdentifierWithModel:(id<IMessageModel>)model
{
    return @"ZLEaseUICustomCell";
}

/*!
 @method
 @brief 获取cell的高度
 @discussion
 @param model   消息model
 @return  返回cell的高度
 */
+ (CGFloat)cellHeightWithModel:(id<IMessageModel>)model
{
    NSInteger type = [model.message.ext[@"type"] integerValue];
    CGFloat bottomInset = 15.0;
    if (type == 1) {
        return 140.0 + bottomInset;
    }
    if (type == 2) {
        return 62.0 + bottomInset;
    }
    if (type == 3) {
        return 80.0 + bottomInset;
    }
    return 115.0 + bottomInset;
}

#pragma mark - Lazy
- (UIView *)unitView {
    if (!_unitView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15.0, 0, UIScreen.mainScreen.bounds.size.width - 30.0, 0)];
        view.backgroundColor = [UIColor colorWithWhite:240 / 255.0 alpha:1.0];
        [self.contentView addSubview:view];
        _unitView = view;
    }
    return _unitView;
}
- (ZLEaseUIOnlineResumeView *)onlineResumeView {
    if (!_onlineResumeView) {
        ZLEaseUIOnlineResumeView *view = [[ZLEaseUIOnlineResumeView alloc] initWithFrame:CGRectMake(15.0, 0, CGRectGetWidth(self.unitView.frame) - 30.0, 140.0)];
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onlineResumeViewAction)]];
        [self.unitView addSubview:view];
        _onlineResumeView = view;
    }
    return _onlineResumeView;
}
- (ZLEaseUIAdjunctResumeView *)adjunctResumeView {
    if (!_adjunctResumeView) {
        ZLEaseUIAdjunctResumeView *view = [[ZLEaseUIAdjunctResumeView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.unitView.frame), 115.0)];
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adjunctResumeViewAction)]];
        [self.unitView addSubview:view];
        _adjunctResumeView = view;
    }
    return _adjunctResumeView;
}
- (ZLEaseUIPositionView *)positionView {
    if (!_positionView) {
        ZLEaseUIPositionView *view = [[ZLEaseUIPositionView alloc] initWithFrame:CGRectMake(15.0, 0, CGRectGetWidth(self.unitView.frame) - 30.0, 115.0)];
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(positionViewAction)]];
        [self.unitView addSubview:view];
        _positionView = view;
    }
    return _positionView;
}
- (ZLEaseUIInterviewInvitationView *)interviewInvitationView {
    if (!_interviewInvitationView) {
        ZLEaseUIInterviewInvitationView *view = [[ZLEaseUIInterviewInvitationView alloc] initWithFrame:CGRectMake(15.0, 0, CGRectGetWidth(self.unitView.frame) - 30.0, 80.0)];
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(interviewInvitationViewAction)]];
        [self.unitView addSubview:view];
        _interviewInvitationView = view;
    }
    return _interviewInvitationView;
}

#pragma mark - Action
- (void)onlineResumeViewAction {
    if ([ZLEaseMessageManager shared].clickPositionCell) {
        [ZLEaseMessageManager shared].clickPositionCell([self.model.message.ext[@"type"] integerValue], self.model.message.ext[@"targetId"]);
    }
}
- (void)adjunctResumeViewAction {
    if ([ZLEaseMessageManager shared].clickPositionCell) {
        [ZLEaseMessageManager shared].clickPositionCell([self.model.message.ext[@"type"] integerValue], self.model.message.ext[@"resource_address"]);
    }
}
- (void)positionViewAction {
    if ([ZLEaseMessageManager shared].clickPositionCell) {
        [ZLEaseMessageManager shared].clickPositionCell([self.model.message.ext[@"type"] integerValue], self.model.message.ext[@"targetId"]);
    }
}
- (void)interviewInvitationViewAction {
    if ([ZLEaseMessageManager shared].clickPositionCell) {
        [ZLEaseMessageManager shared].clickPositionCell([self.model.message.ext[@"type"] integerValue], self.model.message.ext[@"targetId"]);
    }
}

@end
