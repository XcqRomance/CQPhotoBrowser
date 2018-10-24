//
//  CQPhotoBrowserMacroDefinition.m
//  CQPhotoBrowser
//
//  Created by didi on 2018/10/24.
//

#import <Foundation/Foundation.h>

#ifndef cq_kScreentWidth
#define cq_kScreentWidth [UIScreen mainScreen].bounds.size.width
#endif

#ifndef cq_kScreentHeight
#define cq_kScreentHeight [UIScreen mainScreen].bounds.size.height
#endif

#ifndef cq_is_iPhoneX_Series
#define cq_is_iPhoneX_Series (cq_kScreentHeight / cq_kScreentWidth > 2)
#endif

#ifndef cq_liuhaiHeight
#define cq_liuhaiHeight (cq_is_iPhoneX_Series ? 24 : 0)
#endif

#ifndef cq_kHomeIndicatorHeight
#define cq_kHomeIndicatorHeight (cq_is_iPhoneX_Series ? 34.f : 0.f)
#endif

#ifdef DEBUG
#define CQLog(fmt, ...)  NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define CQLog(...)
#endif

#define weakify(weakSelf)       __weak __typeof(self) weakSelf = self;
#define strongify(strongSelf)   __strong __typeof(self) strongSelf = weakSelf;


