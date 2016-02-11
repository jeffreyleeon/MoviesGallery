//
//  MovieDetailsViewController.m
//  MoviesGallery
//
//  Created by Jeffrey on 11/2/2016.
//  Copyright © 2016 jeffreyleeon. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import <AsyncImageView/AsyncImageView.h>
#include "constants.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define LEFT_MARGIN 30
#define RIGHT_MARGIN 30

@interface MovieDetailsViewController ()

@end

@implementation MovieDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTintColor: [UIColor whiteColor]];
    [self setTitle: [_movie getTitle]];
    
    [self initScrollView];
    
    _movieStore = [MovieStore sharedInstance];
    [self fetchTrailers];
    
}

- (void) initScrollView {
    _accumulatedHeight = 0;
    
    // Add trailer or image
    float height = 300;
    [self addTrailerOrImageWithHeight: height];
    
    // Add popularity
    height = 80;
    [self addPopularityWithHeight: height];
    
    // Add overview
//    height = 50;
//    [self addOverviewWithHeight: height];
}

- (void) addTrailerOrImageWithHeight:(float) height {
    if ([_trailerIdsArray count] > 0) {
        CGRect playerViewRect = CGRectMake(0, _accumulatedHeight, SCREEN_WIDTH, height);
        
        _playerView = [[UIView alloc] initWithFrame: playerViewRect];
        NSString* identifier = [_trailerIdsArray objectAtIndex: 0];
        XCDYouTubeVideoPlayerViewController *videoPlayerViewController =
        [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier: identifier];
        [videoPlayerViewController presentInView: _playerView];
        [videoPlayerViewController.moviePlayer play];
        [videoPlayerViewController.moviePlayer setShouldAutoplay: NO];
        
        [_scrollView addSubview: _playerView];
    } else {
        float height = 300;
        CGRect imageViewRect = CGRectMake(0, _accumulatedHeight, SCREEN_WIDTH, height);
        
        AsyncImageView* imageView = [[AsyncImageView alloc] initWithFrame: imageViewRect];
        [imageView setBackgroundColor: [UIColor blackColor]];
        [imageView setImageURL: [_movie getPosterImageURL]];
        [imageView setContentMode: UIViewContentModeScaleAspectFit];
        
        [_scrollView addSubview: imageView];
    }
    _accumulatedHeight += height;
}

- (void) addPopularityWithHeight:(float) height {
    CGRect titleRect = CGRectMake(LEFT_MARGIN, _accumulatedHeight,
                                  SCREEN_WIDTH, height);
    UILabel* title = [[UILabel alloc] initWithFrame: titleRect];
    [title setTextColor: [UIColor whiteColor]];
    [title setFont: [UIFont boldSystemFontOfSize: 20]];
    [title setText: @"Popularity: "];
    
    CGRect valueRect = CGRectMake(0, _accumulatedHeight,
                                  SCREEN_WIDTH - RIGHT_MARGIN, height);
    UILabel* value = [[UILabel alloc] initWithFrame: valueRect];
    [value setTextAlignment: NSTextAlignmentRight];
    [value setTextColor: YELLOW_COLOR];
    [value setFont: [UIFont boldSystemFontOfSize: 20]];
    NSString* popularity = [_movie getVoteAverageString];
    [value setText: [popularity stringByAppendingString: @" ★"]];
    
    [_scrollView addSubview: title];
    [_scrollView addSubview: value];
    _accumulatedHeight += height;
}

- (void) fetchTrailers {
    [_movieStore fetchTrailerOfMovie: _movie withCallback: ^(NSArray* trailerIds) {
        _trailerIdsArray = [[NSArray alloc] initWithArray: trailerIds copyItems: YES];
        [self initScrollView];
    }];
}

@end
