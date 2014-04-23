//
//  ITLab.m
//  CDF Labs
//
//  Created by Ishan Thukral on 2014-04-22.
//  Copyright (c) 2014 Ishan Thukral. All rights reserved.
//

#import "ITLab.h"

@implementation ITLab

- (instancetype)initWithLabName:(NSString *)labName
               andTotalMachines:(NSNumber *)totalMachines
                andFreeMachines:(NSNumber *)freeMachines
                andBusyMachines:(NSNumber *)busyMachines {
    
    self = [super init];
    
    if (self) {
        self.labName       = labName;
        self.totalMachines = totalMachines;
        self.freeMachines  = freeMachines;
        self.busyMachines  = busyMachines;
        
        [self setupPercentagesForLab:self];
    }
    
    return self;
}

- (void)setupPercentagesForLab:(ITLab *)lab {
    float total = [self.totalMachines floatValue];
    float busy  = [self.busyMachines floatValue];
    float percentageBusy = (busy/total) * 100;
    self.percentageBusy = [NSNumber numberWithInteger:percentageBusy];
}

@end
