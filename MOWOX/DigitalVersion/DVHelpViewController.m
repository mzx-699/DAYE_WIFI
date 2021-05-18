//
//  DVHelpViewController.m
//  digitalVersionTest
//
//  Created by apple on 2021/5/17.
//

#import "DVHelpViewController.h"
#import "UIImageView+Common.h"
#import "Masonry.h"
#import "ModelView.h"
#import "NSMutableAttributedString+Common.h"
@interface DVHelpViewController ()
@property (nonatomic, strong) ModelView *topModelView;
@property (nonatomic, strong) ModelView *bottomModelView;
@property (nonatomic, strong) UIImageView *topModelImageView;
@property (nonatomic, strong) UIImageView *bottomModelImageView;
@end

@implementation DVHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    self.navigationItem.title = @"Help";
}
#pragma mark - 懒加载控件

- (ModelView *)topModelView{
    if (!_topModelView) {
        _topModelView = [ModelView new];
        _topModelView.imageName = @"dv_model1";
        NSString *str = @"1.Turn on your Robot\n2.Unlock the keyboard;\n3.Press the button <Wi-Fi> for 5 seconds, until the screen show <model1>\n4.Press the <CONNECT> button.";
        NSArray *images = @[[UIImage imageNamed:@"dv_wifi"], [UIImage imageNamed:@"dv_m1"], [UIImage imageNamed:@"dv_con"]];
        NSArray *labels = @[@"<Wi-Fi>", @"<model1>", @"<CONNECT>"];
        _topModelView.label.attributedText = [NSMutableAttributedString attributedStringWithString:str andFont:_topModelView.label.font andImages:images andLabels:labels];
    }
    return _topModelView;
}
- (ModelView *)bottomModelView{
    if (!_bottomModelView) {
        _bottomModelView = [ModelView new];
        _bottomModelView.imageName = @"dv_model2";
        NSString *str = @"1.Turn on your Robot\n2.Unlock the keyboard;\n3.Press the button <Wi-Fi> and <OK> for 2 seconds, until the screen show <model2>\n4.Press the <CONNECT> button.";
        NSArray *images = @[[UIImage imageNamed:@"dv_wifi"], [UIImage imageNamed:@"dv_ok"], [UIImage imageNamed:@"dv_m2"], [UIImage imageNamed:@"dv_con"]];
        NSArray *labels = @[@"<Wi-Fi>", @"<OK>", @"<model2>", @"<CONNECT>"];
        _bottomModelView.label.attributedText = [NSMutableAttributedString attributedStringWithString:str andFont:_bottomModelView.label.font andImages:images andLabels:labels];
    }
    return _bottomModelView;
}
- (UIImageView *)topModelImageView{
    if (!_topModelImageView) {
        _topModelImageView = [UIImageView imageViewWithImageName:@"dv_btn1"];
    }
    return _topModelImageView;
}
- (UIImageView *)bottomModelImageView{
    if (!_bottomModelImageView) {
        _bottomModelImageView = [UIImageView imageViewWithImageName:@"dv_btn2"];
    }
    return _bottomModelImageView;
}
#pragma mark - 设置UI
- (void)setupUI {
    [self.view addSubview:self.topModelView];
    [self.view addSubview:self.bottomModelView];
    [self.view addSubview:self.topModelImageView];
    [self.view addSubview:self.bottomModelImageView];
    
    [self.topModelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250, 270));
        make.bottom.equalTo(self.view.mas_centerY).offset(-30);
        make.right.equalTo(self.view.mas_right).offset(-50);
    }];
    [self.bottomModelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250, 270));
        make.top.equalTo(self.topModelView.mas_bottom).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-50);
    }];
    [self.topModelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topModelView.mas_centerY);
        make.right.equalTo(self.topModelView.mas_left).offset(-20);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.bottomModelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomModelView.mas_centerY);
        make.right.equalTo(self.bottomModelView.mas_left).offset(-20);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        
    }];
    
}

@end
