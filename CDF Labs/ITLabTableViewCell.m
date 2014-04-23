//
//  ITLabTableViewCell.m
//  CDF Labs
//
//  Created by Ishan Thukral on 2014-04-22.
//  Copyright (c) 2014 Ishan Thukral. All rights reserved.
//

#import "ITLabTableViewCell.h"

@implementation ITLabTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupCellWithLab:(ITLab *)lab {
    self.labName.text = lab.labName;
    self.totalMachines.text = [NSString stringWithFormat:@"%@", lab.totalMachines];
    self.freeMachines.text = [NSString stringWithFormat:@"%@", lab.freeMachines];
    self.busyMachines.text = [NSString stringWithFormat:@"%@", lab.busyMachines];
}

@end
