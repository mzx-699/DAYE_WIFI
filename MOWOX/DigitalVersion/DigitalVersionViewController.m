//
//  DigitalVersionViewController.m
//  digitalVersionTest
//
//  Created by apple on 2021/5/14.
//

#import "DigitalVersionViewController.h"
#import "Masonry.h"
#import "UIImageView+Common.h"
#import "DVHelpViewController.h"
#import "DVModelOneViewController.h"
#import "DVModelTwoViewController.h"
@interface DigitalVersionViewController ()
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIButton *helpBtn;
@end

@implementation DigitalVersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavItem];
    [self setupUI];
    
}
#pragma mark - 点击方法
- (void)leftBtnClick {
    DVModelOneViewController *vc = [DVModelOneViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)rightBtnClick {
    DVModelTwoViewController *vc = [DVModelTwoViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)helpBtnClick {
    DVHelpViewController *vc = [DVHelpViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 设置navItem
- (void)setupNavItem {
    self.navigationItem.title = @"Digital Version";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"loginView"] forBarMetrics:0];
    UIBarButtonItem *backItem = [UIBarButtonItem new];
    backItem.title = @"Back";
    self.navigationItem.backBarButtonItem = backItem;
    
    
}
#pragma mark - 懒加载控件
//top图
- (UIImageView *)topImageView{
    if (!_topImageView) {
        _topImageView = [UIImageView imageViewWithImageName:@"dv_icon1"];
    }
    return _topImageView;
}
- (UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView = [UIImageView imageViewWithImageName:@"img_arrow"];
    }
    return _leftImageView;
}
- (UIImageView *)rightImageView{
    if (!_rightImageView) {
        _rightImageView = [UIImageView imageViewWithImageName:@"img_arrow"];
    }
    return _rightImageView;
}
- (UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [UIButton new];
        [_leftBtn setImage:[UIImage imageNamed:@"dv_btn1"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}
- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton new];
        [_rightBtn setImage:[UIImage imageNamed:@"dv_btn2"] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}
- (UIButton *)helpBtn{
    if (!_helpBtn) {
        _helpBtn = [UIButton new];
        [_helpBtn setImage:[UIImage imageNamed:@"img_help"] forState:UIControlStateNormal];
        [_helpBtn setTitle:@"Help" forState:UIControlStateNormal];
        _helpBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        _helpBtn.titleLabel.textColor = [UIColor whiteColor];
        [_helpBtn addTarget:self action:@selector(helpBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _helpBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _helpBtn;
}
#pragma mark - 设置控件
- (void)setupUI {
    [self.view addSubview:self.topImageView];
    [self.view addSubview:self.leftImageView];
    [self.view addSubview:self.rightImageView];
    [self.view addSubview:self.leftBtn];
    [self.view addSubview:self.rightBtn];
    [self.view addSubview:self.helpBtn];
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(yAutoFit(300),yAutoFit(180)));
        make.top.equalTo(self.view.mas_top).offset(yAutoFit(80));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    [self.leftImageView
     mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 70));
        make.top.equalTo(self.topImageView.mas_bottom).offset(30);
        make.right.equalTo(self.view.mas_centerX).offset(-40);
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 70));
        make.top.equalTo(self.topImageView.mas_bottom).offset(30);
        make.left.equalTo(self.view.mas_centerX).offset(40);
    }];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.top.equalTo(self.leftImageView.mas_bottom).offset(30);
        make.right.equalTo(self.view.mas_centerX).offset(-20);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.top.equalTo(self.rightImageView.mas_bottom).offset(30);
        make.left.equalTo(self.view.mas_centerX).offset(30);
    }];
    [self.helpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 20));
        make.left.equalTo(self.view.mas_centerX).offset(50);
        make.top.equalTo(self.rightBtn.mas_bottom).offset(50);
    }];
    
}

@end
