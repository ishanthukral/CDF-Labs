//
//  ITLabStore.m
//  CDF Labs
//
//  Created by Ishan Thukral on 2014-04-22.
//  Copyright (c) 2014 Ishan Thukral. All rights reserved.
//

#import "ITLabStore.h"
#import "ITLabParser.h"

static ITLabStore *instance;

@interface ITLabStore ()

@property (nonatomic) NSMutableArray *labStore;

@end

@implementation ITLabStore

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [ITLabStore new];
        instance.labStore = [NSMutableArray new];
    });
    return instance;
}

- (NSArray *)labs {
    return [self labStore];
}

- (void)addLab:(ITLab *)lab {
    [[self labStore] addObject:lab];
}

- (void)refreshData {
    self.labStore = [NSMutableArray new];
    [[ITLabParser sharedInstance] downloadLabData];
}

@end
