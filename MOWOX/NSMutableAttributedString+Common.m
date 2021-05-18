//
//  NSMutableAttributedString+Common.m
//  图文混排
//
//  Created by apple on 2021/5/18.
//

#import "NSMutableAttributedString+Common.h"

@implementation NSMutableAttributedString (Common)
+ (NSAttributedString *)imageToAttributedStringWithImage:(UIImage *)image andFont:(UIFont *)font {
    CGFloat lineHeight = font.lineHeight;
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = image;
    CGFloat width = image.size.width / image.size.height * lineHeight;
    attachment.bounds = CGRectMake(0, -2, width, lineHeight);
    
    return [NSAttributedString attributedStringWithAttachment:attachment];;
}
+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string andFont:(UIFont *)font andImages:(NSArray *)imageArray andLabels:(NSArray *)labelArray {
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithString:string];
    int count = (int)imageArray.count;
    for (int i = count - 1; i > -1; i--) {
        [strM replaceCharactersInRange:[string rangeOfString:labelArray[i]] withAttributedString:[self imageToAttributedStringWithImage:imageArray[i] andFont:font]];
    }
    return strM;
}
@end
