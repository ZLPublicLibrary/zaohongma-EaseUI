//
//  ZLEaseUIInterviewInvitationView.h
//  AFNetworking
//
//  Created by 赵磊 on 2019/7/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLEaseUIInterviewInvitationItemView : UIView

///电话号码
@property (nonatomic,unsafe_unretained) BOOL phone;
///标题
@property (nonatomic,strong) NSString *title;
///内容
@property (nonatomic,strong) NSString *content;

+ (CGFloat)getHeightWithContent:(NSString *)content;

@end

@interface ZLEaseUIInterviewInvitationView : UIView

///发布者头像
@property (nonatomic,weak) UIImageView *sendUserIconImageView;
///单元视图
@property (nonatomic,weak) UIView *unitView;
///面试时间
@property (nonatomic,weak) ZLEaseUIInterviewInvitationItemView *timeView;
///面试地址
@property (nonatomic,weak) ZLEaseUIInterviewInvitationItemView *addressView;
///联系人
@property (nonatomic,weak) ZLEaseUIInterviewInvitationItemView *nameView;
///联系电话
@property (nonatomic,weak) ZLEaseUIInterviewInvitationItemView *phoneView;
///备注信息
@property (nonatomic,weak) ZLEaseUIInterviewInvitationItemView *remarksView;

@end

NS_ASSUME_NONNULL_END
