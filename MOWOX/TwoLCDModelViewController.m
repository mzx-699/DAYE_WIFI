//
//  TwoLCDModelViewController.m
//  Giz_Mower
//
//  Created by 安建伟 on 2020/8/27.
//  Copyright © 2020 yusz. All rights reserved.
//

#import "TwoLCDModelViewController.h"
#import "TwoLCDModelHelpViewController.h"
#import "APFinishViewController.h"

@interface TwoLCDModelViewController ()

@property (strong, nonatomic) UIImageView *twoModelImage;
@property (nonatomic, strong) UIButton *connectBtn;
@property (strong, nonatomic) UIButton * bgViewBtn;

@end

@implementation TwoLCDModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavItem];
    UIImage *backImage = [UIImage imageNamed:@"loginView"];
    self.view.layer.contents = (id)backImage.CGImage;
    
    _twoModelImage = [self twoModelImage];
    _connectBtn = [self connectBtn];
    _bgViewBtn = [self bgViewBtn];
}

- (void)setNavItem{
    self.navigationItem.title = LocalString(@"Model 2");
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = LocalString(@"Back");
    self.navigationItem.backBarButtonItem = backItem;
}


- (UIImageView *)twoModelImage{
    if (!_twoModelImage) {
        _twoModelImage = [[UIImageView alloc] init];
        [self.view addSubview:_twoModelImage];
        [_twoModelImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(300),yAutoFit(400)));
            make.top.equalTo(self.view.mas_top).offset(yAutoFit(80.f));
            make.centerX.equalTo(self.view.mas_centerX);
        }];
        
        UIImageView *upImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_lcdHelpWifi"]];
        [_twoModelImage addSubview:upImage];
        [upImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(260),yAutoFit(130)));
            make.top.equalTo(self.twoModelImage.mas_top).offset(yAutoFit(5.f));
            make.centerX.equalTo(self.twoModelImage.mas_centerX);
        }];
        
        UIImageView *upTwoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_lcdModelHelp2"]];
        [_twoModelImage addSubview:upTwoImage];
        [upTwoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(260),yAutoFit(130)));
            make.top.equalTo(upImage.mas_bottom).offset(yAutoFit(3.f));
            make.centerX.equalTo(self.twoModelImage.mas_centerX);
        }];
        
        UITextView *upText = [[UITextView alloc] init];
        upText.font = [UIFont systemFontOfSize:15.f];
        upText.backgroundColor = [UIColor clearColor];
        upText.textColor = [UIColor whiteColor];
        upText.textAlignment = NSTextAlignmentLeft;
        upText.text = LocalString(@"1.Turn on your Robot\n2.Change the interface as shown and press “OK”the text “Network Configuration...”will appear.\n3.Press the “CONNECT” button");
        [_twoModelImage addSubview:upText];
        [upText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(250), yAutoFit(100)));
            make.centerX.equalTo(self.twoModelImage.mas_centerX);
            make.top.mas_equalTo(upTwoImage.mas_bottom).offset(yAutoFit(5));
        }];
        
        _twoModelImage.layer.borderWidth = 1.0;
        _twoModelImage.layer.borderColor = [UIColor whiteColor].CGColor;
        _twoModelImage.layer.cornerRadius = 10.f/HScale;
        
    }
    return _twoModelImage;
}

- (UIButton *)connectBtn{
    if (!_connectBtn) {
        _connectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_connectBtn setBackgroundImage:[UIImage imageNamed:@"img_connect_Btn"] forState:UIControlStateNormal];
        //[_connectBtn setTitle:LocalString(@"Next") forState:UIControlStateNormal];
        //[_connectBtn.titleLabel setFont:[UIFont systemFontOfSize:18.f]];
        //[_connectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];ConnectWifi
        [_connectBtn setBackgroundColor:[UIColor clearColor]];
        [_connectBtn addTarget:self action:@selector(ConnectWifi) forControlEvents:UIControlEventTouchUpInside];
        _connectBtn.enabled = YES;
        [self.view addSubview:_connectBtn];
        [_connectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(280), yAutoFit(50)));
            make.top.equalTo(self.twoModelImage.mas_bottom).offset(yAutoFit(30));
            make.centerX.mas_equalTo(self.view.mas_centerX);
        }];
        
    }
    return _connectBtn;
}

- (UIButton *)bgViewBtn{
    if (!_bgViewBtn) {
        _bgViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgViewBtn.backgroundColor = [UIColor clearColor];
        [_bgViewBtn addTarget:self action:@selector(goOneHelp) forControlEvents:UIControlEventTouchUpInside];
        _bgViewBtn.enabled = YES;
        [self.view addSubview:_bgViewBtn];
        [_bgViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(120), yAutoFit(50)));
            make.left.equalTo(self.view.mas_centerX).offset(yAutoFit(50.f));
            make.top.equalTo(self.connectBtn.mas_bottom).offset(yAutoFit(20));
        }];
        
        UIImageView *helpImg = [[UIImageView alloc] init];
        [helpImg setImage:[UIImage imageNamed:@"img_help"]];
        [_bgViewBtn addSubview:helpImg];
        [helpImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(20), yAutoFit(20)));
            make.left.equalTo(self.bgViewBtn.mas_left).offset(yAutoFit(10));
            make.centerY.equalTo(self.bgViewBtn.mas_centerY);
        }];

        UILabel *helplabel = [[UILabel alloc] init];
        helplabel.text = LocalString(@"Help");
        helplabel.font = [UIFont systemFontOfSize:20.f];
        helplabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        helplabel.textAlignment = NSTextAlignmentCenter;
        helplabel.adjustsFontSizeToFitWidth = YES;
        [_bgViewBtn addSubview:helplabel];
        [helplabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(yAutoFit(30), yAutoFit(20)));
            make.centerY.equalTo(self.bgViewBtn.mas_centerY);
            make.left.equalTo(helpImg.mas_right).offset(yAutoFit(10));
        }];
        
    }
    return _bgViewBtn;
}

- (void)goOneHelp{
    
    TwoLCDModelHelpViewController *HelpVC = [[TwoLCDModelHelpViewController alloc] init];
    [self.navigationController pushViewController:HelpVC animated:YES];
}

-(void)ConnectWifi{
    /*
     *在App内连接ap热点
     */
//    NSString *wifiName = @"XPG-";
//    NSLog(@"wifiName%@",[[GizManager getCurrentWifi] substringWithRange:NSMakeRange(0, 4)]);
//    if ([[[GizManager getCurrentWifi] substringWithRange:NSMakeRange(0, 4)] isEqualToString:wifiName]) {
//        finishViewController *VC = [[finishViewController alloc] init];
//        [self.navigationController pushViewController:VC animated:YES];
//    }else{
//        [self showAlert];
//    }

    NSString *wifiName = @"Robot_Mower";
    if ([[GizManager getCurrentWifi] hasPrefix:wifiName]) {
        APFinishViewController *VC = [[APFinishViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        [self showAlert];
    }
}

- (void)showAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:LocalString(@"Jump prompt") message:LocalString(@"Connect hotspots “Robot_Mower” in settings") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:LocalString(@"OK") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:LocalString(@"Cancel") style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

@end
