//
//  CQPhotoBrowserMacroDefinition.m
//  CQPhotoBrowser
//
//  Created by didi on 2018/10/24.
//

#import <Foundation/Foundation.h>

#define is_iPhoneX_Series ([UIScreen mainScreen].bounds.size.height / [UIScreen mainScreen].bounds.size.width > 2)

#define liuhaiHeight (is_iPhoneX_Series ? 24 : 0)
