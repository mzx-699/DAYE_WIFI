//
//  UIImageView+Common.m
//  digitalVersionTest
//
//  Created by apple on 2021/5/17.
//

#import "UIImageView+Common.h"

@implementation UIImageView (Common)
+ (UIImageView *)imageViewWithImageName:(NSString *)imageName {
    UIImageView *imageView = [[self alloc] initWithImage:[UIImage imageNamed:imageName]];
    [imageView sizeToFit];
    return imageView;
}

+ (UIImageView *)backGroundImageView {
    UIImageView *imageView = [self imageViewWithImageName:@"loginView"];
    imageView.frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 20);
    return imageView;
}
@end
