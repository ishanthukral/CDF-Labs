//
//  ITLabInfoView.h
//  CDF Labs
//
//  Created by Ishan Thukral on 2014-04-23.
//  Copyright (c) 2014 Ishan Thukral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ITLabInfoView : UIView

+ (instancetype)infoView;

@property (weak, nonatomic) IBOutlet UIButton *sourceCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *twitterButton;

@end
