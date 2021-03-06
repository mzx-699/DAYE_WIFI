//
//  LCDModeHelplViewController.m
//  Giz_Mower
//
//  Created by 安建伟 on 2020/8/26.
//  Copyright © 2020 yusz. All rights reserved.
//

#import "LCDVersionHelplViewController.h"

@interface LCDVersionHelplViewController ()

@property (nonatomic, strong) UILabel *simpleModelLabel;
@property (nonatomic, strong) UILabel *lcdModelLabel;
@property (strong, nonatomic) UIImageView *oneModelImage;
@property (strong, nonatomic) UIImageView *twoModelImage;

@end

@implementation LCDVersionHelplViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavItem];
    UIImage *backImage = [UIImage imageNamed:@"loginView"];
    self.view.layer.contents = (id)backImage.CGImage;
    
    _oneModelImage = [self oneModelImage];
    _twoModelImage = [self twoModelImage];
}

- (void)setNavItem{
    self.navigationItem.title = LocalString(@"Help");
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = LocalString(@"Back");
    self.navigationItem.backBarButtonItem = backItem;
}


- (UIImageView *)oneModelImage{
    if (!_oneModelImage) {
        _oneModelImage = [[UIImageView alloc] init];
        [self.view addSubview:_oneModelImage];
        [_oneModelImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(280),yAutoFit(250)));
            make.bottom.equalTo(self.view.mas_centerY).offset(yAutoFit(-10.f));
            make.centerX.equalTo(self.view.mas_centerX);
        }];
        
        UIImageView *upOneImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_LCDmodel1_help"]];
        [self.view addSubview:upOneImage];
        [upOneImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(30),yAutoFit(30)));
            make.right.equalTo(self.oneModelImage.mas_left).offset(yAutoFit(-10.f));
            make.centerY.equalTo(self.oneModelImage.mas_centerY);
        }];
        
        
        UIImageView *upHelpImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_lcdHelpWifi"]];
        [_oneModelImage addSubview:upHelpImage];
        [upHelpImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(135),yAutoFit(120)));
            make.top.equalTo(self.oneModelImage.mas_top).offset(yAutoFit(5.f));
            make.right.equalTo(self.oneModelImage.mas_centerX).offset(yAutoFit(-2));
        }];
        
        UIImageView *upHelpTwoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_lcdModelHelp1"]];
        [_oneModelImage addSubview:upHelpTwoImage];
        [upHelpTwoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(135),yAutoFit(120)));
            make.top.equalTo(self.oneModelImage.mas_top).offset(yAutoFit(5.f));
            make.left.equalTo(self.oneModelImage.mas_centerX).offset(yAutoFit(2));
        }];
        
        UITextView *upText = [[UITextView alloc] init];
        upText.font = [UIFont systemFontOfSize:14.f];
        upText.backgroundColor = [UIColor clearColor];
        upText.textColor = [UIColor whiteColor];
        upText.textAlignment = NSTextAlignmentLeft;
        upText.text = LocalString(@"1.Turn on your Robot\n2.Change the interface as shown and press “OK”the text “Network Configuration...”will appear.\n3.Press the “CONNECT” button");
        [_oneModelImage addSubview:upText];
        [upText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(280), yAutoFit(100)));
            make.centerX.equalTo(self.oneModelImage.mas_centerX);
            make.top.mas_equalTo(upHelpTwoImage.mas_bottom).offset(yAutoFit(5));
        }];
        
        _oneModelImage.layer.borderWidth = 1.0;
        _oneModelImage.layer.borderColor = [UIColor whiteColor].CGColor;
        _oneModelImage.layer.cornerRadius = 10.f/HScale;
        
    }
    return _oneModelImage;
}

- (UIImageView *)twoModelImage{
    if (!_twoModelImage) {
        _twoModelImage = [[UIImageView alloc] init];
        [self.view addSubview:_twoModelImage];
        [_twoModelImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(280),yAutoFit(250)));
            make.top.equalTo(self.view.mas_centerY).offset(yAutoFit(10.f));
            make.centerX.equalTo(self.view.mas_centerX);
        }];
        
        UIImageView *downTwoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_LCDmodel2_help"]];
        [self.view addSubview:downTwoImage];
        [downTwoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(30),yAutoFit(30)));
            make.right.equalTo(self.twoModelImage.mas_left).offset(yAutoFit(-10.f));
            make.centerY.equalTo(self.twoModelImage.mas_centerY);
        }];
        
        UIImageView *downHelpImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_lcdHelpWifi"]];
        [_twoModelImage addSubview:downHelpImage];
        [downHelpImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(135),yAutoFit(120)));
            make.top.equalTo(self.twoModelImage.mas_top).offset(yAutoFit(5.f));
            make.right.equalTo(self.twoModelImage.mas_centerX).offset(yAutoFit(-2));
        }];
        
        UIImageView *downHelpTwoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_lcdModelHelp2"]];
        [_twoModelImage addSubview:downHelpTwoImage];
        [downHelpTwoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(135),yAutoFit(120)));
            make.top.equalTo(self.twoModelImage.mas_top).offset(yAutoFit(5.f));
            make.left.equalTo(self.twoModelImage.mas_centerX).offset(yAutoFit(2));
        }];
        
        UITextView *downText = [[UITextView alloc] init];
        downText.font = [UIFont systemFontOfSize:14.f];
        downText.backgroundColor = [UIColor clearColor];
        downText.textColor = [UIColor whiteColor];
        downText.textAlignment = NSTextAlignmentLeft;
        downText.text = LocalString(@"1.Turn on your Robot\n2.Change the interface as shown and press “OK”the text “Network Configuration...”will appear.\n3.Press the “CONNECT” button");
    
        [_twoModelImage addSubview:downText];
        [downText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(280), yAutoFit(100)));
            make.centerX.equalTo(self.twoModelImage.mas_centerX);
            make.top.mas_equalTo(downHelpTwoImage.mas_bottom).offset(yAutoFit(5));
        }];
        
        _twoModelImage.layer.borderWidth = 1.0;
        _twoModelImage.layer.borderColor = [UIColor whiteColor].CGColor;
        _twoModelImage.layer.cornerRadius = 10.f/HScale;
        
    }
    return _twoModelImage;
}


@end
