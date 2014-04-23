//
//  ITLabCollectionViewCellPercentage.h
//  CDF Labs
//
//  Created by Ishan Thukral on 2014-04-23.
//  Copyright (c) 2014 Ishan Thukral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITLab.h"

@interface ITLabCollectionViewCellPercentage : UICollectionViewCell

- (void)setupCellWithLab:(ITLab *)lab;

@property (weak, nonatomic) IBOutlet UILabel *labBusyPercentage;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UIView *topCellBackground;
@property (weak, nonatomic) IBOutlet UIView *labNameBackground;

@end
