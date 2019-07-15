//
//  ZLEaseMessageManager.m
//  EaseUILite
//
//  Created by 赵磊 on 2019/3/29.
//

#import "ZLEaseMessageManager.h"

@implementation ZLEaseMessageManager

///实例化
+ (instancetype)shared {
    static ZLEaseMessageManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [self new];
    });
    return manager;
}


///加载当前Bundle内的图片
+ (UIImage *)imageWithCurrentBundleName:(NSString *)imageName {
    NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [currentBundle.resourcePath stringByAppendingPathComponent:[NSString stringWithFormat:@"EaseUIResource.bundle/%@@%dx.png",imageName, (int)UIScreen.mainScreen.scale]];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    if (!image) {
        path = [currentBundle.resourcePath stringByAppendingPathComponent:[NSString stringWithFormat:@"EaseUIResource.bundle/%@@%dx.png",imageName, 2]];
        image = [UIImage imageWithContentsOfFile:path];
    }
    return image;
}

@end
