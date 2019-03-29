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

///加载当前Bundle内的图片
+ (UIImage *)imageWithCurrentBundleName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
