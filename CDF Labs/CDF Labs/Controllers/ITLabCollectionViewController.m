//
//  ITLabCollectionViewController.m
//  CDF Labs
//
//  Created by Ishan Thukral on 2014-04-22.
//  Copyright (c) 2014 Ishan Thukral. All rights reserved.
//

#import "ITLabCollectionViewController.h"
#import "ITLabCollectionViewCellPercentage.h"
#import "ITLabCollectionViewCell.h"
#import "ITLabInfoView.h"
#import "UIColor+CDFLabs.h"
#import "ITConstants.h"
#import "ITLabStore.h"
#import "ITLab.h"
#import <FXBlurView/FXBlurView.h>
#import <Shimmer/FBShimmeringView.h>

@interface ITLabCollectionViewController ()

@property (nonatomic) NSString *viewMode;
@property (nonatomic) FXBlurView *blurView;
@property (nonatomic) ITLabInfoView *infoView;

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
    [self setupNavbarButtons];
    [self setupNavBarColors];
    [self setupViewMode];
    
    [[self navigationItem] setTitle:kAppName];
    
    [[self collectionView] setBackgroundColor:[UIColor collectionViewBackgroundColor]];
    
    [[self collectionView] registerNib:[UINib nibWithNibName:NSStringFromClass([ITLabCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([ITLabCollectionViewCell class])];
    [[self collectionView] registerNib:[UINib nibWithNibName:NSStringFromClass([ITLabCollectionViewCellPercentage class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([ITLabCollectionViewCellPercentage class])];
}


# pragma mark - Setup Methods

- (void)setupRefreshControl {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:refreshControl];
    self.collectionView.alwaysBounceVertical = YES;
}

- (void)setupNavbarButtons {
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"info"] style:UIBarButtonItemStylePlain target:self action:@selector(showInfoView:)];
    [[self navigationItem] setLeftBarButtonItem:filterButton];
}

- (void)setupNavBarColors {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[[self navigationController] navigationBar] setBarTintColor:[UIColor navigationBarColor]];
    [[[self navigationController] navigationBar] setTintColor:[UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1]];
    [[[self navigationController] navigationBar] setTranslucent:YES];
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1]}];
}

- (void)setupViewMode {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.viewMode = [defaults objectForKey:kViewModeNSUserDefaultsKey];
    if (!self.viewMode) {
        self.ViewMode = kViewModeCount;
        [defaults setObject:self.viewMode forKey:kViewModeNSUserDefaultsKey];
        [defaults synchronize];
    }
}


# pragma mark - UICollectionView Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *labs = [[ITLabStore sharedInstance] labs];
    
    if (!labs.count) {
        [self refresh:nil];
    }
    
    return [labs count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ITLab *lab = [[[ITLabStore sharedInstance] labs] objectAtIndex:indexPath.item];
    
    UICollectionViewCell *cell;
    
    if ([self.viewMode isEqualToString:kViewModeCount]) {
    
        cell = (ITLabCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ITLabCollectionViewCell class]) forIndexPath:indexPath];
        [(ITLabCollectionViewCell *)cell setupCellWithLab:lab];
    
    } else {
    
        cell = (ITLabCollectionViewCellPercentage *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ITLabCollectionViewCellPercentage class]) forIndexPath:indexPath];
        [(ITLabCollectionViewCellPercentage *)cell setupCellWithLab:lab];
    }
    
    return cell;
}


#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self switchViewModes];
    [[self collectionView] reloadData];
    
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

- (IBAction)showInfoView:(id)sender {
    [self.view setClipsToBounds:NO];
    
    [self setupBlurView];
    [self setupInfoView];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.infoView.alpha = 1.0;
        self.blurView.alpha = 1.0;
    } completion:^(BOOL finished) {
       [[[self navigationItem] leftBarButtonItem] setEnabled:NO];
    }];
}

- (IBAction)dismissInfoView:(id)sender {
    
    [UIView animateWithDuration:0.3f animations:^{
        self.infoView.alpha = 0.0;
        self.blurView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [[self infoView] removeFromSuperview];
        [[self blurView] removeFromSuperview];
        [[[self navigationItem] leftBarButtonItem] setEnabled:YES];
    }];
}

- (IBAction)showSourceCode:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kGithubLink]];
}

- (IBAction)showTwitter:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kTwitterLink]];
}


#pragma mark - Helper Methods

- (void)setupBlurView {
    self.blurView = [[FXBlurView alloc] initWithFrame:self.view.superview.bounds];
    self.blurView.blurRadius = 8.0f;
    self.blurView.dynamic = NO;
    self.blurView.underlyingView = self.view;
    self.blurView.tintColor = [UIColor clearColor];
    self.blurView.alpha = 0.0f;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissInfoView:)];
    [self.blurView addGestureRecognizer:tap];
    
    [[self view] addSubview:self.blurView];
}

- (void)setupInfoView {
    self.infoView = [ITLabInfoView infoView];
    
    [self.infoView.twitterButton addTarget:self action:@selector(showTwitter:) forControlEvents:UIControlEventTouchUpInside];
    [self.infoView.sourceCodeButton addTarget:self action:@selector(showSourceCode:) forControlEvents:UIControlEventTouchUpInside];
    
    self.infoView.center = self.view.center;
    self.infoView.alpha = 0.0f;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissInfoView:)];
    [self.infoView addGestureRecognizer:tap];
    
    [[self view] addSubview:self.infoView];
}

- (void)switchViewModes {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([self.viewMode isEqualToString:kViewModeCount]) {
        self.viewMode = kViewModePercent;
    } else {
        self.viewMode = kViewModeCount;
    }
    
    [defaults setObject:self.viewMode forKey:kViewModeNSUserDefaultsKey];
}

@end
