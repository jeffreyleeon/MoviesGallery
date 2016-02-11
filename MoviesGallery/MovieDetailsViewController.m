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
#define FONT_SIZE 18

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
    height = 70;
    [self addPopularityWithHeight: height];
    
    // Add release date
    height = 50;
    [self addReleaseDateWithHeight: height];
    
    // Add overview
    [self addOverviewWithHeight: height];
    
    [_scrollView setContentSize: CGSizeMake(SCREEN_WIDTH, _accumulatedHeight)];
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
        
        [_scrollView addSubview: _playerView];
    } else {
        float height = 300;
        CGRect imageViewRect = CGRectMake(0, _accumulatedHeight, SCREEN_WIDTH, height);
        
        AsyncImageView* imageView = [[AsyncImageView alloc] initWithFrame: imageViewRect];
        [imageView setBackgroundColor: [UIColor blackColor]];
        NSURL* posterURL = [_movie getPosterImageURL];
        if ([posterURL isKindOfClass: [NSURL class]]) {
            [imageView setImageURL: posterURL];
        } else {
            [imageView setImage: [UIImage imageNamed: @"poster-placeholder"]];
        }
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
    [title setFont: [UIFont boldSystemFontOfSize: FONT_SIZE]];
    [title setText: @"Popularity: "];
    
    CGRect valueRect = CGRectMake(0, _accumulatedHeight,
                                  SCREEN_WIDTH - RIGHT_MARGIN, height);
    UILabel* value = [[UILabel alloc] initWithFrame: valueRect];
    [value setTextAlignment: NSTextAlignmentRight];
    [value setTextColor: YELLOW_COLOR];
    [value setFont: [UIFont systemFontOfSize: FONT_SIZE]];
    NSString* popularity = [_movie getVoteAverageString];
    [value setText: [popularity stringByAppendingString: @" ★"]];
    
    [_scrollView addSubview: title];
    [_scrollView addSubview: value];
    _accumulatedHeight += height;
}

- (void) addReleaseDateWithHeight:(float) height {
    CGRect titleRect = CGRectMake(LEFT_MARGIN, _accumulatedHeight,
                                  SCREEN_WIDTH, height);
    UILabel* title = [[UILabel alloc] initWithFrame: titleRect];
    [title setTextColor: [UIColor whiteColor]];
    [title setFont: [UIFont boldSystemFontOfSize: FONT_SIZE]];
    [title setText: @"Release Date: "];
    
    CGRect valueRect = CGRectMake(0, _accumulatedHeight,
                                  SCREEN_WIDTH - RIGHT_MARGIN, height);
    UILabel* value = [[UILabel alloc] initWithFrame: valueRect];
    [value setTextAlignment: NSTextAlignmentRight];
    [value setTextColor: [UIColor whiteColor]];
    [value setFont: [UIFont systemFontOfSize: FONT_SIZE]];
    NSString* date = [_movie getReleaseDate];
    [value setText: date];
    
    [_scrollView addSubview: title];
    [_scrollView addSubview: value];
    _accumulatedHeight += height;
}

- (void) addOverviewWithHeight:(float) height {
    float tailingSpace = 90.0;
    CGRect titleRect = CGRectMake(LEFT_MARGIN, _accumulatedHeight,
                                  SCREEN_WIDTH, height);
    UILabel* title = [[UILabel alloc] initWithFrame: titleRect];
    [title setTextColor: [UIColor whiteColor]];
    [title setFont: [UIFont boldSystemFontOfSize: FONT_SIZE]];
    [title setText: @"Overview: "];
    
    UILabel* value = [[UILabel alloc] init];
    [value setTextColor: [UIColor whiteColor]];
    [value setFont: [UIFont systemFontOfSize: FONT_SIZE]];
    NSString* overview = [_movie getOverview];
    CGSize maxSize = CGSizeMake(SCREEN_WIDTH, 1000);
    CGRect overviewRect = [overview boundingRectWithSize: maxSize
                                            options: NSStringDrawingUsesLineFragmentOrigin
                                         attributes: @{NSFontAttributeName: value.font}
                                            context: Nil];
    
    [value setText: overview];
    [value setNumberOfLines: 0];
    value.frame = CGRectMake(LEFT_MARGIN, _accumulatedHeight + height / 3,
                             SCREEN_WIDTH - 2 * LEFT_MARGIN, overviewRect.size.height + tailingSpace);
    
    [_scrollView addSubview: title];
    [_scrollView addSubview: value];
    _accumulatedHeight += height;
    _accumulatedHeight += overviewRect.size.height;
    _accumulatedHeight += tailingSpace;
}

- (void) fetchTrailers {
    [_movieStore fetchTrailerOfMovie: _movie withCallback: ^(NSArray* trailerIds) {
        _trailerIdsArray = [[NSArray alloc] initWithArray: trailerIds copyItems: YES];
        [self initScrollView];
    }];
}

@end
