//
//  ViewController.m
//  MoviesGallery
//
//  Created by Jeffrey on 31/1/2016.
//  Copyright © 2016 jeffreyleeon. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <AsyncImageView/AsyncImageView.h>
#import "ViewController.h"
#import "MovieDetailsViewController.h"
#include "constants.h"

#define GO_TO_DETAILS_SEGUE @"pushFromPopularToDetail"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_swipeView setPagingEnabled: YES];
    [_swipeView setScrollEnabled: YES];
    
    _movieStore = [MovieStore sharedInstance];
    
    [self fetchPopularMovies];
    
    [self scheduleAutoScrolling];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *) swipeView {
    return [_popularMovies count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    Movie* movie = [_popularMovies objectAtIndex: index];
    return [self viewOfSwipeViewForMovie: movie forIndex: index];
}

- (UIView*)viewOfSwipeViewForMovie:(Movie*)movie forIndex:(NSInteger)index {
    UIView* _view = [[UIView alloc] init];
    [_view setBackgroundColor: [UIColor blackColor]];
    
    CGRect imageViewFrame = CGRectMake(0, 0, _swipeView.frame.size.width, _swipeView.frame.size.height * 0.6);
    NSURL* url = [movie getPosterImageURL];
    AsyncImageView* imageView = [[AsyncImageView alloc] initWithFrame: imageViewFrame];
    [imageView setImageURL: url];
    [imageView setContentMode: UIViewContentModeScaleAspectFit];
    [_view addSubview: imageView];
    
    float topMargin = 80;
    float margin = 40;
    CGRect overviewLabelFrame = CGRectMake(margin, imageViewFrame.size.height - topMargin,
                                        _swipeView.frame.size.width - 2 * margin, 300);
    UILabel* overviewLabel = [[UILabel alloc] initWithFrame: overviewLabelFrame];
    [overviewLabel setTextAlignment: NSTextAlignmentCenter];
    [overviewLabel setTextColor: [UIColor whiteColor]];
    [overviewLabel setNumberOfLines: 5];
    [overviewLabel setClipsToBounds: YES];
    [overviewLabel setFont: [UIFont systemFontOfSize: 17]];
    [overviewLabel setText: [movie getOverview]];
    [_view addSubview: overviewLabel];
    
    CGRect detailsButtonFrame = CGRectMake(margin, imageViewFrame.size.height + 140,
                                           _swipeView.frame.size.width - 2 * margin, 40);
    UIButton* detailsBtn = [[UIButton alloc] initWithFrame: detailsButtonFrame];
    [detailsBtn setTitle: @"More Details" forState: UIControlStateNormal];
    [detailsBtn setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [detailsBtn setBackgroundColor: YELLOW_COLOR];
    [detailsBtn.layer setCornerRadius: 5];
    [detailsBtn setClipsToBounds: YES];
    [detailsBtn setTag: index];
    [detailsBtn addTarget: self
                   action: @selector(goMovieDetails:)
         forControlEvents: UIControlEventTouchUpInside];
    [_view addSubview: detailsBtn];
    
    return _view;
}

- (void)goMovieDetails:(UIButton*)button {
    _selectedMovie = [_popularMovies objectAtIndex: button.tag];
    [self performSegueWithIdentifier: GO_TO_DETAILS_SEGUE sender: self];
}

- (CGSize)swipeViewItemSize:(SwipeView *) swipeView {
    return _swipeView.bounds.size;
}

- (void) fetchPopularMovies {
    [_movieStore fetchPopularMoviesWithCallback: ^(NSMutableArray* movies) {
        _popularMovies = [[NSArray alloc] initWithArray: movies];
        [_swipeView reloadData];
    }];
}

- (void) scheduleAutoScrolling {
    [NSTimer scheduledTimerWithTimeInterval: 30.0
                                     target: self
                                   selector: @selector(nextPopularMovie)
                                   userInfo: NULL
                                    repeats: YES];
}

- (void) nextPopularMovie {
    // First page is at index 0
    NSInteger currentPage = [_swipeView currentPage];
    NSInteger nextPage = currentPage + 1;
    if (nextPage == [_popularMovies count]) {
        nextPage = 0;
    }
    [_swipeView scrollToPage: nextPage duration: 0.5];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString: GO_TO_DETAILS_SEGUE]) {
        MovieDetailsViewController* destinationViewController = segue.destinationViewController;
        [destinationViewController setMovie: _selectedMovie];
    }
}

@end
