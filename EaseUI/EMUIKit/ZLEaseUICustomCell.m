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
        self.onlineResumeView.unitView.frame = CGRectMake(model.isSender ? 10.0 : 60.0, self.onlineResumeView.unitView.frame.origin.y, self.onlineResumeView.unitView.frame.size.width, self.onlineResumeView.unitView.frame.size.height);
        self.onlineResumeView.sendUserIconImageView.frame = CGRectMake(model.isSender ? UIScreen.mainScreen.bounds.size.width - 50.0 : 10.0, self.onlineResumeView.sendUserIconImageView.frame.origin.y, self.onlineResumeView.sendUserIconImageView.frame.size.width, self.onlineResumeView.sendUserIconImageView.frame.size.height);
        self.onlineResumeView.sendUserIconImageView.image = model.isSender ? [ZLEaseMessageManager shared].myIcon : [ZLEaseMessageManager shared].sideIcon;
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
        self.adjunctResumeView.iconImageView.frame = CGRectMake(model.isSender ? CGRectGetWidth(self.adjunctResumeView.frame) - 50.0 : 10.0, 0, 40.0, 40.0);
        self.adjunctResumeView.unitView.frame = CGRectMake(model.isSender ? CGRectGetWidth(self.adjunctResumeView.frame) - 10.0 - 40.0 - 10.0 - 249.0 : 10.0 + 40.0 + 10.0, 0, 249.0, 62.0);
        UIImage *image = [ZLEaseMessageManager imageWithCurrentBundleName:model.isSender ? @"chat_sender_bg" : @"chat_receiver_bg"];
        self.adjunctResumeView.unitView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(30.0, model.isSender ? 5.0 : 10.0, 5.0, model.isSender ? 10.0 : 5.0) resizingMode:(UIImageResizingModeStretch)];
        self.adjunctResumeView.titleLabel.text = model.message.ext[@"title"];
        self.adjunctResumeView.subTitleLabel.text = model.message.ext[@"size"];
    }else if (type == 3) {//面试邀请
        self.interviewInvitationView.hidden = NO;
        self.interviewInvitationView.sendUserIconImageView.frame = CGRectMake(model.isSender ? UIScreen.mainScreen.bounds.size.width - 50.0 : 10.0, self.interviewInvitationView.sendUserIconImageView.frame.origin.y, self.interviewInvitationView.sendUserIconImageView.frame.size.width, self.interviewInvitationView.sendUserIconImageView.frame.size.height);
        self.interviewInvitationView.sendUserIconImageView.image = model.isSender ? [ZLEaseMessageManager shared].myIcon : [ZLEaseMessageManager shared].sideIcon;
        self.interviewInvitationView.timeView.content = model.message.ext[@"interview_time"];
        self.interviewInvitationView.addressView.content = model.message.ext[@"site"];
        self.interviewInvitationView.addressView.frame = CGRectMake(self.interviewInvitationView.addressView.frame.origin.x, CGRectGetMaxY(self.interviewInvitationView.timeView.frame) + 8.0, self.interviewInvitationView.addressView.frame.size.width, self.interviewInvitationView.addressView.frame.size.height);
        self.interviewInvitationView.nameView.content = model.message.ext[@"name"];
        self.interviewInvitationView.nameView.frame = CGRectMake(self.interviewInvitationView.nameView.frame.origin.x, CGRectGetMaxY(self.interviewInvitationView.addressView.frame) + 8.0, self.interviewInvitationView.nameView.frame.size.width, self.interviewInvitationView.nameView.frame.size.height);
        self.interviewInvitationView.phoneView.content = model.message.ext[@"mobile"];
        self.interviewInvitationView.phoneView.frame = CGRectMake(self.interviewInvitationView.phoneView.frame.origin.x, CGRectGetMaxY(self.interviewInvitationView.nameView.frame) + 8.0, self.interviewInvitationView.phoneView.frame.size.width, self.interviewInvitationView.phoneView.frame.size.height);
        self.interviewInvitationView.remarksView.content = model.message.ext[@"remarks"];
        self.interviewInvitationView.remarksView.frame = CGRectMake(self.interviewInvitationView.remarksView.frame.origin.x, CGRectGetMaxY(self.interviewInvitationView.phoneView.frame) + 8.0, self.interviewInvitationView.remarksView.frame.size.width, self.interviewInvitationView.remarksView.frame.size.height);
        self.interviewInvitationView.unitView.frame = CGRectMake(model.isSender ? 10.0 : 60.0, self.interviewInvitationView.unitView.frame.origin.y, self.interviewInvitationView.unitView.frame.size.width, CGRectGetMaxY(self.interviewInvitationView.remarksView.frame) + 16.0);
        self.interviewInvitationView.frame = CGRectMake(self.interviewInvitationView.frame.origin.x, self.interviewInvitationView.frame.origin.y, self.interviewInvitationView.frame.size.width, CGRectGetMaxY(self.interviewInvitationView.unitView.frame));
    }else if (type == 4) {//职位
        self.positionView.hidden = NO;
        self.positionView.titleLabel.text = model.message.ext[@"title"];
        self.positionView.priceLabel.text = model.message.ext[@"salary"];
        self.positionView.sendUserIconImageView.frame = CGRectMake(model.isSender ? UIScreen.mainScreen.bounds.size.width - 50.0 : 10.0, self.positionView.sendUserIconImageView.frame.origin.y, self.positionView.sendUserIconImageView.frame.size.width, self.positionView.sendUserIconImageView.frame.size.height);
        self.positionView.sendUserIconImageView.image = model.isSender ? [ZLEaseMessageManager shared].myIcon : [ZLEaseMessageManager shared].sideIcon;
        
        NSString *string = model.message.ext[@"jobDescription"];
        CGFloat height = 0;
        if (string) {
            NSMutableAttributedString *attrM = [[NSMutableAttributedString alloc] initWithString:string];
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            style.lineSpacing = 5.0;
            [attrM addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, string.length)];
            [attrM addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Light" size:15.0] range:NSMakeRange(0, attrM.string.length)];
            [attrM addAttribute:NSForegroundColorAttributeName value:UIColor.blackColor range:NSMakeRange(0, attrM.string.length)];
            self.positionView.requireLabel.attributedText = attrM;
            
            height = [string boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 70.0 - 32.0, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont fontWithName:@"PingFangSC-Light" size:15.0],NSParagraphStyleAttributeName:style} context:nil].size.height;
            
            self.positionView.requireLabel.frame = CGRectMake(self.positionView.requireLabel.frame.origin.x, self.positionView.requireLabel.frame.origin.y, self.positionView.requireLabel.frame.size.width, height);
            
        }
        
        self.positionView.unitView.frame = CGRectMake(model.isSender ? 10.0 : 60.0, self.positionView.unitView.frame.origin.y, self.positionView.unitView.frame.size.width, 97.0 + height);
        
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
        return 155.0 + bottomInset;
    }
    if (type == 2) {
        return 62.0 + bottomInset;
    }
    if (type == 3) {
        CGFloat timeHeight = [ZLEaseUIInterviewInvitationItemView getHeightWithContent:model.message.ext[@"interview_time"]];
        CGFloat addressHeight = [ZLEaseUIInterviewInvitationItemView getHeightWithContent:model.message.ext[@"site"]];
        CGFloat nameHeight = [ZLEaseUIInterviewInvitationItemView getHeightWithContent:model.message.ext[@"name"]];
        CGFloat phoneHeight = [ZLEaseUIInterviewInvitationItemView getHeightWithContent:model.message.ext[@"mobile"]];
        CGFloat remarksHeight = [ZLEaseUIInterviewInvitationItemView getHeightWithContent:model.message.ext[@"remarks"]];
        return 16.0 + 22.0 + 15.0 + timeHeight + 8.0 + addressHeight + 8.0 + nameHeight + 8.0 + phoneHeight + 8.0 + remarksHeight + 16.0 + bottomInset;
    }
    CGFloat height = 0;
    NSString *jobDescription = model.message.ext[@"jobDescription"];
    if (jobDescription) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 5.0;
        height = [jobDescription boundingRectWithSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 70.0 - 32.0, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont fontWithName:@"PingFangSC-Light" size:15.0],NSParagraphStyleAttributeName:style} context:nil].size.height;
    }
    return 97.0 + height + bottomInset;
}

#pragma mark - Lazy
- (UIView *)unitView {
    if (!_unitView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 0)];
        view.backgroundColor = [UIColor colorWithWhite:240 / 255.0 alpha:1.0];
        [self.contentView addSubview:view];
        _unitView = view;
    }
    return _unitView;
}
- (ZLEaseUIOnlineResumeView *)onlineResumeView {
    if (!_onlineResumeView) {
        ZLEaseUIOnlineResumeView *view = [[ZLEaseUIOnlineResumeView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.unitView.frame), 155.0)];
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
        ZLEaseUIPositionView *view = [[ZLEaseUIPositionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.unitView.frame) - 70.0, 115.0)];
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(positionViewAction)]];
        [self.unitView addSubview:view];
        _positionView = view;
    }
    return _positionView;
}
- (ZLEaseUIInterviewInvitationView *)interviewInvitationView {
    if (!_interviewInvitationView) {
        ZLEaseUIInterviewInvitationView *view = [[ZLEaseUIInterviewInvitationView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.unitView.frame), 80.0)];
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
