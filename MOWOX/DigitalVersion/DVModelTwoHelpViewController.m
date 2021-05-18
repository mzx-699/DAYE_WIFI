//
//  DVModelTwoHelpViewController.m
//  digitalVersionTest
//
//  Created by apple on 2021/5/17.
//

#import "DVModelTwoHelpViewController.h"
#import "UIImageView+Common.h"
#import "Masonry.h"
#import "NSString+Common.h"
@interface DVModelTwoHelpViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSString *string;
@property (nonatomic, strong) UILabel *detailLabel;
@end

@implementation DVModelTwoHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Help";
    [self setupUI];
}
#pragma mark - 懒加载控件
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView imageViewWithImageName:@"icon_check"];
    }
    return _imageView;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = @"Model2:";
        _titleLabel.font = [UIFont systemFontOfSize:20];
    }
    return _titleLabel;
}
- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.textColor = [UIColor whiteColor];
        _detailLabel.text = @"more compatible to 2.4GHZ/5Ghz Wifi network";
        _detailLabel.numberOfLines = 0;
        _detailLabel.font = [UIFont systemFontOfSize:17];
        _detailLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _detailLabel;
}
#pragma mark - 设置UI
- (void)setupUI {
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.detailLabel];
    CGSize labelSize = [self.detailLabel.text labelSizeWithFont:self.detailLabel.font andWidth:300];
    CGFloat topDistance = self.view.bounds.size.height * 0.3;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(topDistance);
        make.size.mas_equalTo(CGSizeMake(10, 10));
        make.left.equalTo(self.view.mas_left).offset(50);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imageView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(300, 20));
        make.left.equalTo(self.imageView.mas_right).offset(10);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView.mas_left).offset(-5);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(labelSize.height + 1);
        make.width.mas_equalTo(labelSize.width);
    }];
}

@end
