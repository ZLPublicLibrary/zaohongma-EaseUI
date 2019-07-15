//
//  ZLEaseMessageManager.h
//  EaseUILite
//
//  Created by 赵磊 on 2019/3/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLEaseMessageManager : NSObject

///对面的头像地址
@property (nonatomic,strong) UIImage *sideIcon;
///当前登录用户的头像地址
@property (nonatomic,strong) UIImage *myIcon;
///当前登录用户的IMid
@property (nonatomic,strong) NSString *sideImId;
///当前登录用户的IMid
@property (nonatomic,strong) NSString *myImId;
///当前登录用户的用户名
@property (nonatomic,strong) NSString *sideImName;
///当前登录用户的用户名
@property (nonatomic,strong) NSString *myImName;
///0刚刚注册、未知类型 1个人  2企业  3猎头
@property (nonatomic,unsafe_unretained) NSInteger type;


///发送简历    index: 0线上简历  1附件简历
@property (nonatomic,copy) void (^sendResume)(NSInteger index);

///点击底部功能条事件引发的单元格    type:1线上简历  2附件简历 3名片  4职位     actionId:目标id
@property (nonatomic,copy) void (^clickPositionCell)(NSInteger type, NSString *actionId);

///实例化
+ (instancetype)shared;

///加载当前Bundle内的图片
+ (UIImage *)imageWithCurrentBundleName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
