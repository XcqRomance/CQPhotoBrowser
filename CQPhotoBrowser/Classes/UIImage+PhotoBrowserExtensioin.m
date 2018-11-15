//
//  UIImage+PhotoBrowserExtensioin.m
//  CQPhotoBrowser
//
//  Created by didi on 2018/11/15.
//

#import "UIImage+PhotoBrowserExtensioin.h"

@implementation UIImage (PhotoBrowserExtensioin)

+ (nullable UIImage *)cq_imageNamed:(NSString *)name {
    NSBundle *currenBuddle = [NSBundle bundleForClass:NSClassFromString(@"CQPhotoBrowser")];
    NSDictionary *dict = currenBuddle.infoDictionary;
    NSString *bunddleName = dict[@"CFBundleExecutable"];
    NSUInteger scale = (NSUInteger)[UIScreen mainScreen].scale;
    NSString *imageName = [NSString stringWithFormat:@"%@@%lux",name,(unsigned long)scale];
    NSString *imagePath = [currenBuddle pathForResource:imageName ofType:@"png" inDirectory:[NSString stringWithFormat:@"%@.bundle",bunddleName]];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}

@end
