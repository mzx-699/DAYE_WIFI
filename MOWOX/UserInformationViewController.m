//
//  UserInformationViewController.m
//  Giz_Mower
//
//  Created by 麻志翔 on 2021/12/21.
//  Copyright © 2021 yusz. All rights reserved.
//

#import "UserInformationViewController.h"

@interface UserInformationViewController () <UIDocumentInteractionControllerDelegate>
@property (strong, nonatomic) UILabel *emailLabel;
@property (strong, nonatomic) UILabel *emailContent;
@property (strong, nonatomic) UILabel *passwordLabel;
@property (strong, nonatomic) UILabel *passwordContent;
@property (strong, nonatomic) UIButton *policyBtn;
@property (strong, nonatomic) UIButton *logoutBtn;
@property (strong, nonatomic) NSUserDefaults *defaults;
@property (nonatomic, strong) UIDocumentInteractionController *document;
@end

@implementation UserInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *backImage = [UIImage imageNamed:@"loginView"];
    self.defaults = [NSUserDefaults standardUserDefaults];
    self.view.layer.contents = (id)backImage.CGImage;
    [self setupView];
}

#pragma mark UIDocumentInteractionControllerDelegate
-(UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    
    //注意：此处要求的控制器，必须是它的页面view，已经显示在window之上了
    return self;
    
}
- (UIDocumentInteractionController *)document {
    if (!_document) {
        NSString *localLangaugeCode = [[[NSBundle mainBundle] preferredLocalizations] firstObject];
        NSLog(@"%@", localLangaugeCode);
        NSURL *url = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"gdpr-%@", localLangaugeCode] withExtension:@"pdf"];
        NSLog(@"%@", url);
        _document = [UIDocumentInteractionController interactionControllerWithURL:url];
        _document.delegate = self;
    }
    return _document;
}
#pragma mark - btnClick
- (void)policyBtnClick {
    [self document];
    [self.document presentPreviewAnimated:YES];
}
- (void)logoutBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 设置UI
- (void)setupView {
    [self.view addSubview:self.emailContent];
    [self.view addSubview:self.passwordContent];
    [self.view addSubview:self.emailLabel];
    [self.view addSubview:self.passwordLabel];
    [self.view addSubview:self.policyBtn];
    [self.view addSubview:self.logoutBtn];
    
    [self.emailContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(ScreenHeight * 0.15);
        make.centerX.mas_equalTo(self.view.mas_centerX).offset(ScreenWidth * 0.1);
        make.width.mas_equalTo(ScreenWidth * 0.5);
    }];
    [self.passwordContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.emailContent.mas_bottom).offset(ScreenHeight * 0.05);
        make.centerX.mas_equalTo(self.emailContent.mas_centerX);
        make.width.mas_equalTo(self.emailContent.mas_width);
    }];
    [self.emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.emailContent.mas_centerY);
        make.right.mas_equalTo(self.emailContent.mas_left).offset(-10);
        make.width.mas_equalTo(ScreenWidth * 0.2);
    }];
    
    [self.passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.passwordContent.mas_centerY);
        make.centerX.mas_equalTo(self.emailLabel.mas_centerX);
        make.width.mas_equalTo(self.emailLabel.mas_width);
    }];
    [self.policyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordContent.mas_bottom).offset(ScreenHeight * 0.05);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    [self.logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.policyBtn.mas_bottom).offset(ScreenHeight * 0.1);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(ScreenWidth * 0.6);
        make.height.mas_equalTo(ScreenHeight * 0.1);
    }];
    
}
- (UIButton *)logoutBtn {
    if (!_logoutBtn) {
        _logoutBtn = [UIButton new];
        _logoutBtn.layer.cornerRadius = 20;
        _logoutBtn.layer.borderColor = [UIColor blackColor].CGColor;
        _logoutBtn.layer.borderWidth = 2;
        _logoutBtn.backgroundColor = [UIColor grayColor];
        [_logoutBtn setTitle:LocalString(@"Logout") forState:UIControlStateNormal];
        _logoutBtn.titleLabel.font = [UIFont systemFontOfSize:25];
        [_logoutBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_logoutBtn sizeToFit];
        [_logoutBtn addTarget:self action:@selector(logoutBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutBtn;
}
- (UIButton *)policyBtn {
    if (!_policyBtn) {
        _policyBtn = [[UIButton alloc] init];
        [_policyBtn.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
        [_policyBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_policyBtn setBackgroundColor:[UIColor clearColor]];
        [_policyBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_policyBtn setTitle:LocalString(@"Terms of Service and Privacy policy") forState:UIControlStateNormal];
        [_policyBtn addTarget:self action:@selector(policyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_policyBtn sizeToFit];
    }
    return _policyBtn;
}
- (UILabel *)emailLabel {
    if (!_emailLabel) {
        _emailLabel = [UILabel new];
        _emailLabel.text = LocalString(@"E-mail");
        _emailLabel.font = [UIFont systemFontOfSize:18];
        _emailLabel.textColor = [UIColor whiteColor];
        _emailLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _emailLabel;
}
- (UILabel *)emailContent {
    if (!_emailContent) {
        _emailContent = [UILabel new];
        
        _emailContent.text = LocalString([self.defaults objectForKey:@"email"]);
        _emailContent.font = [UIFont systemFontOfSize:18];
        _emailContent.textColor = [UIColor whiteColor];
        _emailContent.adjustsFontSizeToFitWidth = YES;
    }
    return _emailContent;
}
- (UILabel *)passwordLabel {
    if (!_passwordLabel) {
        _passwordLabel = [UILabel new];
        _passwordLabel.text = LocalString(@"Password");
        _passwordLabel.font = [UIFont systemFontOfSize:18];
        _passwordLabel.textColor = [UIColor whiteColor];
        _passwordLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _passwordLabel;
}
- (UILabel *)passwordContent {
    if (!_passwordContent) {
        _passwordContent = [UILabel new];
        _passwordContent.text = LocalString([self.defaults objectForKey:@"passWord"]);
        _passwordContent.font = [UIFont systemFontOfSize:18];
        _passwordContent.textColor = [UIColor whiteColor];
        _passwordContent.adjustsFontSizeToFitWidth = YES;
    }
    return _passwordContent;
}

@end
