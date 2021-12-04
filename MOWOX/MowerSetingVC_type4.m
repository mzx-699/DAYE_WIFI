//
//  MowerSetingVC_type4.m
//  Giz_Mower
//
//  Created by 安建伟 on 2020/10/9.
//  Copyright © 2020 yusz. All rights reserved.
//

#import "MowerSetingVC_type4.h"
#import "RainDelayView.h"
@interface MowerSetingVC_type4 ()

///@brife 帧数据控制单例
@property (strong,nonatomic) BluetoothDataManage *bluetoothDataManage;

@property (strong, nonatomic)  UILabel *rainLabel;
@property (strong, nonatomic)  UILabel *boundaryLabel;
@property (strong, nonatomic)  UILabel *helixLabel;
@property (nonatomic, strong) UILabel *ultrasoundLabel;
@property (strong, nonatomic)  UILabel *rainDelayLabel;
@property (strong, nonatomic)  UIButton *rainyesButton;
@property (strong, nonatomic)  UIButton *rainnoButton;
@property (strong, nonatomic)  UIButton *boundaryyesButton;
@property (strong, nonatomic)  UIButton *boundarynoButton;
@property (strong, nonatomic)  UIButton *helixyesButton;
@property (strong, nonatomic)  UIButton *helixnoButton;
@property (nonatomic, strong) RainDelayView *rainDelayView;
@property (strong, nonatomic)  UIButton *ultrasoundyesButton;
@property (strong, nonatomic)  UIButton *ultrasoundnoButton;
@property (strong, nonatomic)  UIButton *okButton;

@end

@implementation MowerSetingVC_type4

static int isRain = 0;
static int isBoundary = 0;
static int isHelix = 0;
static int isUltrasound = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
    self.navigationItem.title = LocalString(@"Robot setting");
    
    self.bluetoothDataManage = [BluetoothDataManage shareInstance];
    
    [self viewLayoutSet];
    [self inquireMowerSetting];
    #pragma mark - 2021.10.18 改
    self.helixLabel.hidden = [[BluetoothDataManage shareInstance] updateHelixset];
    self.helixyesButton.hidden = [[BluetoothDataManage shareInstance] updateHelixset];
    self.helixnoButton.hidden = [[BluetoothDataManage shareInstance] updateHelixset];
    
    self.ultrasoundLabel.hidden = [[BluetoothDataManage shareInstance] updateultrasound];
    self.ultrasoundyesButton.hidden = [[BluetoothDataManage shareInstance] updateultrasound];
    self.ultrasoundnoButton.hidden = [[BluetoothDataManage shareInstance] updateultrasound];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recieveMowerSetting:) name:@"recieveMowerSetting" object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"recieveMowerSetting" object:nil];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewLayoutSet{
    
    CGFloat navHeight = self.navigationController.navigationBar.bounds.size.height;
    CGFloat statusHeight = 0;
    if (@available(iOS 13.0, *)) {
        statusHeight = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height;
        
    } else {
        statusHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        
    }
    
    UIImage *image = [UIImage imageNamed:@"返回1"];
    [self addLeftBarButtonWithImage:image action:@selector(backAction)];
    
    _rainLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] text:LocalString(@"MOW in the rain")];
    _boundaryLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] text:LocalString(@"Boundary cut")];
    _helixLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] text:LocalString(@"Helix Set")];
    _rainDelayLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] text:LocalString(@"Rain Delay Set")];
    _ultrasoundLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] text:LocalString(@"Ultrasound")];
    [_rainLabel setLabelStyle1];
    [_boundaryLabel setLabelStyle1];
    [_helixLabel setLabelStyle1];
    [_rainDelayLabel setLabelStyle1];
    [_ultrasoundLabel setLabelStyle1];
    
    _rainyesButton = [UIButton buttonWithTitle:LocalString(@"Yes") titleColor:[UIColor blackColor]];
    _rainnoButton = [UIButton buttonWithTitle:LocalString(@"NO") titleColor:[UIColor blackColor]];
    _boundaryyesButton = [UIButton buttonWithTitle:LocalString(@"Yes") titleColor:[UIColor blackColor]];
    _boundarynoButton = [UIButton buttonWithTitle:LocalString(@"NO") titleColor:[UIColor blackColor]];
    _ultrasoundyesButton = [UIButton buttonWithTitle:LocalString(@"Yes") titleColor:[UIColor blackColor]];
    _ultrasoundnoButton = [UIButton buttonWithTitle:LocalString(@"NO") titleColor:[UIColor blackColor]];
    _helixyesButton = [UIButton buttonWithTitle:LocalString(@"Yes") titleColor:[UIColor blackColor]];
    _helixnoButton = [UIButton buttonWithTitle:LocalString(@"NO") titleColor:[UIColor blackColor]];
    _okButton = [UIButton buttonWithTitle:LocalString(@"OK") titleColor:[UIColor blackColor]];
    
    [_rainyesButton setButtonStyle1];
    [_rainnoButton setButtonStyle1];
    [_boundaryyesButton setButtonStyle1];
    [_boundarynoButton setButtonStyle1];
    [_helixyesButton setButtonStyle1];
    [_helixnoButton setButtonStyle1];
    [_ultrasoundyesButton setButtonStyle1];
    [_ultrasoundnoButton setButtonStyle1];
    [_okButton setButtonStyle1];
    
    [_rainyesButton addTarget:self action:@selector(rainSetYes) forControlEvents:UIControlEventTouchUpInside];
    [_rainnoButton addTarget:self action:@selector(rainSetNo) forControlEvents:UIControlEventTouchUpInside];
    [_boundaryyesButton addTarget:self action:@selector(boundarySetYes) forControlEvents:UIControlEventTouchUpInside];
    [_boundarynoButton addTarget:self action:@selector(boundarySetNo) forControlEvents:UIControlEventTouchUpInside];
    [_helixyesButton addTarget:self action:@selector(helixSetYes) forControlEvents:UIControlEventTouchUpInside];
    [_helixnoButton addTarget:self action:@selector(helixSetNo) forControlEvents:UIControlEventTouchUpInside];
    [_ultrasoundyesButton addTarget:self action:@selector(ultrasoundSetYes) forControlEvents:UIControlEventTouchUpInside];
    [_ultrasoundnoButton addTarget:self action:@selector(ultrasoundSetNo) forControlEvents:UIControlEventTouchUpInside];
    [_okButton addTarget:self action:@selector(MowerSetting) forControlEvents:UIControlEventTouchUpInside];
    
    _rainDelayView = [[RainDelayView alloc] init];
    
    [self.view addSubview:_rainDelayLabel];
    [self.view addSubview:_rainLabel];
    [self.view addSubview:_boundaryLabel];
    [self.view addSubview:_ultrasoundLabel];
    [self.view addSubview:_helixLabel];
    [self.view addSubview:_rainyesButton];
    [self.view addSubview:_rainnoButton];
    [self.view addSubview:_boundaryyesButton];
    [self.view addSubview:_boundarynoButton];
    [self.view addSubview:_helixyesButton];
    [self.view addSubview:_helixnoButton];
    [self.view addSubview:_rainDelayView];
    [self.view addSubview:_ultrasoundyesButton];
    [self.view addSubview:_ultrasoundnoButton];
    [self.view addSubview:_okButton];
    
    
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if([deviceType isEqualToString:@"iPhone"]) {
        //iPhone
        [_rainDelayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(ScreenWidth * 0.82, ScreenHeight * 0.066));
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.equalTo(self.view.mas_top).offset(statusHeight + navHeight + 10);
        }];
    }else if([deviceType isEqualToString:@"iPad"]) {
        //iPad
        [_rainDelayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(ScreenWidth * 0.82, ScreenHeight * 0.066));
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.equalTo(self.view.mas_top).offset(ScreenHeight * 0.005 + 44 + 64);
        }];
    }
    
    
    [_rainDelayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth * 0.82, ScreenHeight * 0.066));
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.rainDelayLabel.mas_bottom).offset(ScreenHeight * 0.01);
    }];
    
    [_rainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth * 0.82, ScreenHeight * 0.066));
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.rainDelayView.mas_bottom).offset(ScreenHeight * 0.015);
    }];
    [_rainyesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth * 0.3653, ScreenHeight * 0.066));
        make.top.equalTo(self.rainLabel.mas_bottom).offset(ScreenHeight * 0.01);
        make.right.equalTo(self.view.mas_centerX).offset(- ScreenWidth * 0.0507);
    }];
    [_rainnoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth * 0.3653, ScreenHeight * 0.066));
        make.left.equalTo(self.view.mas_centerX).offset(ScreenWidth * 0.0507);
        make.centerY.equalTo(self.rainyesButton.mas_centerY);
    }];
    [_boundaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth * 0.82, ScreenHeight * 0.066));
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.rainyesButton.mas_bottom).offset(ScreenHeight * 0.015);
    }];
    [_boundaryyesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth * 0.3653, ScreenHeight * 0.066));
        make.top.equalTo(self.boundaryLabel.mas_bottom).offset(ScreenHeight * 0.01);
        make.left.equalTo(self.rainyesButton.mas_left);
    }];
    [_boundarynoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth * 0.3653, ScreenHeight * 0.066));
        make.centerY.equalTo(self.boundaryyesButton.mas_centerY);
        make.left.equalTo(self.rainnoButton.mas_left);
    }];
    
    
    [_ultrasoundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth * 0.82, ScreenHeight * 0.066));
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.boundaryyesButton.mas_bottom).offset(ScreenHeight * 0.015);
    }];
    
    [_ultrasoundyesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth * 0.3653, ScreenHeight * 0.066));
        make.top.equalTo(self.ultrasoundLabel.mas_bottom).offset(ScreenHeight * 0.01);
        make.left.equalTo(self.rainyesButton.mas_left);
    }];
    [_ultrasoundnoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth * 0.3653, ScreenHeight * 0.066));
        make.centerY.equalTo(self.ultrasoundyesButton.mas_centerY);
        make.left.equalTo(self.boundarynoButton.mas_left);
    }];
    [_helixLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth * 0.82, ScreenHeight * 0.066));
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.ultrasoundnoButton.mas_bottom).offset(ScreenHeight * 0.015);
    }];
    [_helixyesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth * 0.3653, ScreenHeight * 0.066));
        make.top.equalTo(self.helixLabel.mas_bottom).offset(ScreenHeight * 0.01);
        make.left.equalTo(self.rainyesButton.mas_left);
    }];
    [_helixnoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth * 0.3653, ScreenHeight * 0.066));
        make.centerY.equalTo(self.helixyesButton.mas_centerY);
        make.left.equalTo(self.rainnoButton.mas_left);
    }];
    [_okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth * 0.82, ScreenHeight * 0.066));
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.helixyesButton.mas_bottom).offset(ScreenHeight * 0.015);
    }];
    
}

#pragma mark - inquire MowerSetting

- (void)inquireMowerSetting{
    
    NSMutableArray *dataContent = [[NSMutableArray alloc] init];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    
    [self.bluetoothDataManage setDataType:0x19];
    [self.bluetoothDataManage setDataContent: dataContent];
    [self.bluetoothDataManage sendBluetoothFrame];
}

- (void)recieveMowerSetting:(NSNotification *)notification{
    NSDictionary *dict = [notification userInfo];
    NSNumber *rain = dict[@"rain"];
    NSNumber *boundary = dict[@"boundary"];
    NSNumber *helix = dict[@"helix"];
    NSNumber *hour = dict[@"hour"];
    NSNumber *min = dict[@"min"];
    NSNumber *ultrasound = dict[@"ultrasound"];
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([rain intValue] == 0) {
            [self rainSetNo];
        }else{
            [self rainSetYes];
        }
        if ([boundary intValue] == 0) {
            [self boundarySetNo];
        }else{
            [self boundarySetYes];
        }
        if ([helix intValue] == 0) {
            [self helixSetNo];
        }else{
            [self helixSetYes];
        }
        if ([ultrasound intValue] == 0) {
            [self ultrasoundSetNo];
        }else{
            [self ultrasoundSetYes];
        }
        self.rainDelayView.hourTextField.text = [NSString stringWithFormat:@"%d", hour.intValue];
        self.rainDelayView.minTextField.text = [NSString stringWithFormat:@"%d", min.intValue];
        
    });
    
}


#pragma mark - button target
- (void)rainSetYes{
    isRain = 1;
    [self.rainyesButton.layer setBackgroundColor:[UIColor lightGrayColor].CGColor];
    [self.rainnoButton.layer setBackgroundColor:[UIColor clearColor].CGColor];
}

- (void)rainSetNo{
    isRain = 0;
    [self.rainyesButton.layer setBackgroundColor:[UIColor clearColor].CGColor];
    [self.rainnoButton.layer setBackgroundColor:[UIColor lightGrayColor].CGColor];
}

- (void)boundarySetYes{
    isBoundary = 1;
    [self.boundaryyesButton.layer setBackgroundColor:[UIColor lightGrayColor].CGColor];
    [self.boundarynoButton.layer setBackgroundColor:[UIColor clearColor].CGColor];
}

- (void)boundarySetNo{
    isBoundary = 0;
    [self.boundaryyesButton.layer setBackgroundColor:[UIColor clearColor].CGColor];
    [self.boundarynoButton.layer setBackgroundColor:[UIColor lightGrayColor].CGColor];
}

- (void)ultrasoundSetYes{
    isUltrasound = 1;
    [self.ultrasoundyesButton.layer setBackgroundColor:[UIColor lightGrayColor].CGColor];
    [self.ultrasoundnoButton.layer setBackgroundColor:[UIColor clearColor].CGColor];
}

- (void)ultrasoundSetNo{
    isUltrasound = 0;
    [self.ultrasoundyesButton.layer setBackgroundColor:[UIColor clearColor].CGColor];
    [self.ultrasoundnoButton.layer setBackgroundColor:[UIColor lightGrayColor].CGColor];
}
- (void)helixSetYes{
    isHelix = 1;
    [self.helixyesButton.layer setBackgroundColor:[UIColor lightGrayColor].CGColor];
    [self.helixnoButton.layer setBackgroundColor:[UIColor clearColor].CGColor];
}

- (void)helixSetNo{
    isHelix = 0;
    [self.helixyesButton.layer setBackgroundColor:[UIColor clearColor].CGColor];
    [self.helixnoButton.layer setBackgroundColor:[UIColor lightGrayColor].CGColor];
}
- (void)setRainDelayAlert {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please input the correct rain delay time, and make sure total minutes are less than 600." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *done = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:nil];
    [ac addAction:done];
    [self presentViewController:ac animated:NO completion:nil];
}
- (void)MowerSetting{
    NSNumber *hour = [NSNumber numberWithInt:0];
    NSNumber *min = [NSNumber numberWithInt:0];
    if (![self.rainDelayView.hourTextField.text isEqualToString:@""]) {
        hour = @([self.rainDelayView.hourTextField.text integerValue]);
    }
    if (![self.rainDelayView.minTextField.text isEqualToString:@""]) {
        min = @([self.rainDelayView.minTextField.text integerValue]);
    }
    if(!(((hour.intValue * 60 + min.intValue) < 600) && ((hour.intValue * 60 + min.intValue) >= 1))) {
        [self setRainDelayAlert];
        return;
    }
    if(hour.intValue == 0 && !(min.intValue < 60 && min.intValue > 0)) {
        [self setRainDelayAlert];
        return;
    }
    if(hour.intValue != 0 && !(min.intValue < 60 && min.intValue >= 0)) {
        [self setRainDelayAlert];
        return;
    }
    
    NSMutableArray *dataContent = [[NSMutableArray alloc] init];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:isRain]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:isBoundary]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:isUltrasound]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:isHelix]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:hour.unsignedIntegerValue]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:min.unsignedIntegerValue]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    [dataContent addObject:[NSNumber numberWithUnsignedInteger:0x00]];
    
    [self.bluetoothDataManage setDataType:0x09];
    [self.bluetoothDataManage setDataContent: dataContent];
    [self.bluetoothDataManage sendBluetoothFrame];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
