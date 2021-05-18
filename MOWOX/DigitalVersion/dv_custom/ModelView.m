//
//  ModelView.m
//  自定义label测试
//
//  Created by apple on 2021/5/17.
//

#import "ModelView.h"
#import "Masonry.h"
#import "UIImageView+Common.h"
#import "NSMutableAttributedString+Common.h"
@interface ModelView()
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIImage *image;
@end
@implementation ModelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
#pragma mark - 懒加载控件
- (UIImage *)image{
    if (!_image) {
        _image = [UIImage imageNamed:self.imageName];
    }
    return _image;
}
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView = [[UIImageView alloc] initWithImage:self.image];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}
- (UILabel *)label{
    if (!_label) {
        _label = [UILabel new];
        _label.numberOfLines = 0;
        _label.font = [UIFont systemFontOfSize:14];
        _label.textColor = [UIColor whiteColor];
    }
    return _label;
}
#pragma mark - 设置控件
- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupUI];
    
}
#pragma mark - 设置UI
- (void)setupUI {
    [self addSubview:self.imageView];
    [self addSubview:self.label];
    CGFloat imageViewHeight = self.image.size.height / self.image.size.width * (self.bounds.size.width - 40);
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.left.equalTo(self.mas_left).offset(20);
        make.height.mas_equalTo(imageViewHeight);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(10);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(self.imageView.mas_width);
    }];
    
}
#pragma mark - 基本设置
- (void)setupView {
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 2;
    self.layer.cornerRadius = 10;
    self.backgroundColor = [UIColor clearColor];
}


@end
