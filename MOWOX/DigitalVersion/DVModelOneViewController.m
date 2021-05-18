//
//  DVModelOneViewController.m
//  digitalVersionTest
//
//  Created by apple on 2021/5/17.
//

#import "DVModelOneViewController.h"
#import "ModelView.h"
#import "Masonry.h"
#import "DVModelOneHelpViewController.h"
#import "NSMutableAttributedString+Common.h"
#import "AirLinkViewController.h"
@interface DVModelOneViewController ()
@property (nonatomic, strong) ModelView *topModelView;
@property (nonatomic, strong) UIButton *connectBtn;
@property (nonatomic, strong) UIButton *helpBtn;
@end

@implementation DVModelOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    self.navigationItem.title = @"Model 1";
}
#pragma mark - 点击方法
- (void)helpBtnClick {
    DVModelOneHelpViewController *vc = [DVModelOneHelpViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)conBtnClick {
    NSLog(@"conBtnClick");
    AirLinkViewController *VC = [[AirLinkViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark - 懒加载控件
- (ModelView *)topModelView{
    if (!_topModelView) {
        _topModelView = [ModelView new];
        _topModelView.imageName = @"dv_model1";
        _topModelView.label.font = [UIFont systemFontOfSize:17];
        NSString *str = @"1.Turn on your Robot\n2.Unlock the keyboard;\n3.Press the button <Wi-Fi> for 5 seconds, until the screen show <model1>\n4.Press the <CONNECT> button.";
        NSArray *images = @[[UIImage imageNamed:@"dv_wifi"], [UIImage imageNamed:@"dv_m1"], [UIImage imageNamed:@"dv_con"]];
        NSArray *labels = @[@"<Wi-Fi>", @"<model1>", @"<CONNECT>"];
        _topModelView.label.attributedText = [NSMutableAttributedString attributedStringWithString:str andFont:[UIFont systemFontOfSize:17] andImages:images andLabels:labels];
    }
    return _topModelView;
}
- (UIButton *)connectBtn{
    if (!_connectBtn) {
        _connectBtn = [UIButton new];
        [_connectBtn setBackgroundImage:[UIImage imageNamed:@"dv_con"] forState:UIControlStateNormal];
        [_connectBtn addTarget:self action:@selector(conBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _connectBtn;
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
#pragma mark - 设置UI
- (void)setupUI {
    [self.view addSubview:self.topModelView];
    [self.view addSubview:self.connectBtn];
    [self.view addSubview:self.helpBtn];
    [self.topModelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(50);
        make.right.equalTo(self.view.mas_right).offset(-50);
        make.top.equalTo(self.view.mas_topMargin).offset(30);
        make.height.mas_equalTo(340);
    }];
    [self.connectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(280, 50));
        make.top.equalTo(self.topModelView.mas_bottom).offset(20);
        make.centerX.equalTo(self.topModelView.mas_centerX);
    }];
    [self.helpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 20));
        make.left.equalTo(self.view.mas_centerX).offset(50);
        make.top.equalTo(self.connectBtn.mas_bottom).offset(50);
    }];
}
@end
