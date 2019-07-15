//
//  ZLEaseUIPositionCell.m
//  EaseUILite
//
//  Created by 赵磊 on 2019/7/15.
//

#import "ZLEaseUIPositionCell.h"
#import "UIImageView+WebCache.h"
#import "EaseBubbleView+Gif.h"
#import "IMessageModel.h"
#import "ZLEaseMessageManager.h"

@interface ZLEaseUIPositionCell ()

///单元视图
@property (nonatomic,weak) UIView *unitView;
///标题
@property (nonatomic,weak) UILabel *titleLabel;

@end

@implementation ZLEaseUIPositionCell

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
    //赋值
    self.unitView.frame = CGRectMake(15.0, 0, UIScreen.mainScreen.bounds.size.width - 30.0, [ZLEaseUIPositionCell cellHeightWithModel:model]);
    NSLog(@"%@",model.message.ext);
}

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
    return model.isSender?@"EaseMessageCellSendGif":@"EaseMessageCellRecvGif";
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
    return 120;
}

#pragma mark - Lazy
- (UIView *)unitView {
    if (!_unitView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.layer.cornerRadius = 5.0;
        view.layer.masksToBounds = YES;
        view.backgroundColor = UIColor.whiteColor;
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
        [self.contentView addSubview:view];
        _unitView = view;
    }
    return _unitView;
}

#pragma mark - Action
- (void)tapAction {
    if ([ZLEaseMessageManager shared].clickPositionCell) {
        [ZLEaseMessageManager shared].clickPositionCell([self.model.message.ext[@"type"] integerValue], self.model.message.ext[@"targetId"]);
    }
}

@end
