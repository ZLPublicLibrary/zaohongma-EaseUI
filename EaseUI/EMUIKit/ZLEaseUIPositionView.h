//
//  ZLEaseUIPositionView.h
//  AFNetworking
//
//  Created by 赵磊 on 2019/7/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLEaseUIPositionView : UIView

///职位
@property (nonatomic,weak) UILabel *titleLabel;
///工资
@property (nonatomic,weak) UILabel *priceLabel;
///融资情况、公司人数
@property (nonatomic,weak) UILabel *numberLabel;
///基本要求
@property (nonatomic,weak) UIView *claimView;

@end

NS_ASSUME_NONNULL_END
