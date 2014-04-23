//
//  ITLabCollectionViewCell.h
//  CDF Labs
//
//  Created by Ishan Thukral on 2014-04-22.
//  Copyright (c) 2014 Ishan Thukral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITLab.h"

@interface ITLabCollectionViewCell : UICollectionViewCell

- (void)setupCellWithLab:(ITLab *)lab;

@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *freeMachines;
@property (weak, nonatomic) IBOutlet UILabel *totalMachines;
@end
