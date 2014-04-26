//
//  ITLabStore.h
//  CDF Labs
//
//  Created by Ishan Thukral on 2014-04-22.
//  Copyright (c) 2014 Ishan Thukral. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITLab.h"

@interface ITLabStore : NSObject

+ (instancetype)sharedInstance;
- (void)refreshData;
- (NSArray *)labs;
- (void)addLab:(ITLab *)lab;

@end
