//
//  ITLabCollectionViewController.m
//  CDF Labs
//
//  Created by Ishan Thukral on 2014-04-22.
//  Copyright (c) 2014 Ishan Thukral. All rights reserved.
//

#import "ITLabCollectionViewController.h"
#import "ITLabCollectionViewCell.h"
#import "ITConstants.h"
#import "ITLabStore.h"
#import "ITLab.h"

@interface ITLabCollectionViewController ()

@end

@implementation ITLabCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self setupRefreshControl];
    [self setupFilterButton];
    [self setupNavBarColors];
    
    [[self navigationItem] setTitle:kAppName];
    
    [[self collectionView] registerNib:[UINib nibWithNibName:NSStringFromClass([ITLabCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([ITLabCollectionViewCell class])];
}


# pragma mark - Setup Methods

- (void)setupRefreshControl {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:refreshControl];
    self.collectionView.alwaysBounceVertical = YES;
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


# pragma mark - UICollectionView Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[[ITLabStore sharedInstance] labs] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ITLabCollectionViewCell *cell = (ITLabCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ITLabCollectionViewCell class]) forIndexPath:indexPath];
    
    ITLab *lab = [[[ITLabStore sharedInstance] labs] objectAtIndex:indexPath.item];
    
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
            [[self collectionView] reloadData];
            [(UIRefreshControl *)sender endRefreshing];
        });
        
    });
    
}

@end
