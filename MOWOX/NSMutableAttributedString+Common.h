//
//  NSMutableAttributedString+Common.h
//  图文混排
//
//  Created by apple on 2021/5/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (Common)
+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string andFont:(UIFont *)font andImages:(NSArray *)imageArray andLabels:(NSArray *)labelArray;
@end

NS_ASSUME_NONNULL_END
