//
//  ITLabTableViewController.m
//  CDF Labs
//
//  Created by Ishan Thukral on 2014-04-22.
//  Copyright (c) 2014 Ishan Thukral. All rights reserved.
//

#import "ITLabTableViewController.h"
#import "ITLabTableViewCell.h"
#import "ITConstants.h"
#import "ITLabStore.h"
#import "ITLab.h"

@interface ITLabTableViewController ()

@end

@implementation ITLabTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupRefreshControl];
    [self setupFilterButton];
    [self setupNavBarColors];
    
    [[self navigationItem] setTitle:kAppName];
    
    [[self tableView] registerNib:[UINib nibWithNibName:NSStringFromClass([ITLabTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([ITLabTableViewCell class])];
}


# pragma mark - Setup Methods

- (void)setupRefreshControl {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self setRefreshControl:refreshControl];
}

- (void)setupFilterButton {
    
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"filter"] style:UIBarButtonItemStylePlain target:nil action:nil];
    [[self navigationItem] setRightBarButtonItem:filterButton];
    
}

- (void)setupNavBarColors {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[[self navigationController] navigationBar] setBarTintColor:[UIColor colorWithRed:0.21 green:0.33 blue:0.45 alpha:0.8]];
    [[[self navigationController] navigationBar] setTintColor:[UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1]];
    [[[self navigationController] navigationBar] setTranslucent:YES];
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1]}];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[ITLabStore sharedInstance] labs] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ITLabTableViewCell *cell = (ITLabTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ITLabTableViewCell class]) forIndexPath:indexPath];

    ITLab *lab = [[[ITLabStore sharedInstance] labs] objectAtIndex:indexPath.row];
    
    [cell setupCellWithLab:lab];
    
    return cell;
}


# pragma mark - IBActions

- (IBAction)refresh:(id)sender {
    
    dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(backgroundQueue, ^{
       
        [[ITLabStore sharedInstance] refreshData];
        
        dispatch_async(mainQueue, ^{
            [[self tableView] reloadData];
            [(UIRefreshControl *)sender endRefreshing];
        });
        
    });
    
}

@end
