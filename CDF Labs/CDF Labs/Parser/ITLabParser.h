//
//  ITLabParser.h
//  CDF Labs
//
//  Created by Ishan Thukral on 2014-04-22.
//  Copyright (c) 2014 Ishan Thukral. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HTMLNodesToLabPropertyMap) {
    labName,
    freeMachines,
    busyMachines,
    totalMachines
};

@interface ITLabParser : NSObject

+ (instancetype)sharedInstance;
- (void)downloadLabData;

@end
