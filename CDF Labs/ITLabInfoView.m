//
//  ITLabInfoView.m
//  CDF Labs
//
//  Created by Ishan Thukral on 2014-04-23.
//  Copyright (c) 2014 Ishan Thukral. All rights reserved.
//

#import "ITLabInfoView.h"

@implementation ITLabInfoView

+ (instancetype)infoView {
    ITLabInfoView *infoView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ITLabInfoView class]) owner:nil options:nil] lastObject];
    
    if ([infoView isKindOfClass:[ITLabInfoView class]]) {
        return infoView;
    } else {
        return nil;
    }
}

@end
