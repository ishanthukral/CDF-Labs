//
//  ITLab.h
//  CDF Labs
//
//  Created by Ishan Thukral on 2014-04-22.
//  Copyright (c) 2014 Ishan Thukral. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITLab : NSObject

- (instancetype)initWithLabName:(NSString *)labName
               andTotalMachines:(NSNumber *)totalMachines
                andFreeMachines:(NSNumber *)freeMachines
                andBusyMachines:(NSNumber *)busyMachines;

@property (nonatomic) NSString  *labName;
@property (nonatomic) NSNumber *totalMachines;
@property (nonatomic) NSNumber *freeMachines;
@property (nonatomic) NSNumber *busyMachines;
@property (nonatomic) NSNumber *percentageBusy;

@end
