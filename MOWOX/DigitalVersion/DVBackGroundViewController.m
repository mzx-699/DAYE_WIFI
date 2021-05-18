//
//  DVBackGroundViewController.m
//  digitalVersionTest
//
//  Created by apple on 2021/5/17.
//

#import "DVBackGroundViewController.h"
#import "UIImageView+Common.h"
@interface DVBackGroundViewController ()
@property (nonatomic, strong) UIImageView *bgImageView;
@end

@implementation DVBackGroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bgImageView];
}

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [UIImageView backGroundImageView];
    }
    return _bgImageView;
}
@end
