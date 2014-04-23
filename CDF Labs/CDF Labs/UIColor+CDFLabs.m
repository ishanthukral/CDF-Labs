//
//  UIColor+CDFLabs.m
//  CDF Labs
//
//  Created by Ishan Thukral on 2014-04-22.
//  Copyright (c) 2014 Ishan Thukral. All rights reserved.
//

#import "UIColor+CDFLabs.h"

@implementation UIColor (CDFLabs)

+ (UIColor *)labCellGreenColor {
    return [UIColor colorWithRed:0.35 green:0.82 blue:0.51 alpha:1];
}

+ (UIColor *)labCellRedColor {
    return [UIColor colorWithRed:0.89 green:0.19 blue:0.21 alpha:1];
}

+ (UIColor *)labCellBackgroundColor {
    return [UIColor colorWithRed:0.89 green:0.89 blue:0.94 alpha:1];
}

+ (UIColor *)collectionViewBackgroundColor {
    return [UIColor colorWithRed:0.29 green:0.29 blue:0.29 alpha:1];
}

+ (UIColor *)navigationBarColor {
    return [UIColor colorWithRed:0.18 green:0.17 blue:0.18 alpha:1];
}

@end
