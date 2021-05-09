//
//  ZLEaseUIOnlineResumeView.h
//  AFNetworking
//
//  Created by 赵磊 on 2019/7/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLEaseUIOnlineResumeView : UIView

///发布者头像
@property (nonatomic,weak) UIImageView *sendUserIconImageView;
///单元视图
@property (nonatomic,weak) UIView *unitView;
///简历者头像
@property (nonatomic,weak) UIImageView *iconImageView;
///姓名
@property (nonatomic,weak) UILabel *titleLabel;
///岗位
@property (nonatomic,weak) UILabel *positionLabel;
///薪资
@property (nonatomic,weak) UILabel *compensationLabel;
///基本要求
@property (nonatomic,weak) UIView *claimView;

@end

NS_ASSUME_NONNULL_END
