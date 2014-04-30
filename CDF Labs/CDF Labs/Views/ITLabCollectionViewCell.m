//
//  ITLabCollectionViewCell.m
//  CDF Labs
//
//  Created by Ishan Thukral on 2014-04-22.
//  Copyright (c) 2014 Ishan Thukral. All rights reserved.
//

#import "ITLabCollectionViewCell.h"
#import "UIColor+CDFLabs.h"

@implementation ITLabCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setupCellWithLab:(ITLab *)lab {
    self.labName.text = lab.labName;
    self.totalMachines.text = [NSString stringWithFormat:@"%@", lab.totalMachines];
    self.freeMachines.text = [NSString stringWithFormat:@"%@", lab.freeMachines];
    self.labNameBackground.backgroundColor = [UIColor labCellBackgroundColor];

    [self setupCellBackgroundForLab:lab];
}

- (void)setupCellBackgroundForLab:(ITLab *)lab {
    
    UIColor *cellBackgroundColor;
    
    if (lab.freeMachines.integerValue > 5) {
        cellBackgroundColor = [UIColor labCellGreenColor];
    } else {
        cellBackgroundColor = [UIColor labCellRedColor];
    }
    
    self.topCellBackground.backgroundColor = cellBackgroundColor;
    
}

@end
