//
//  MovieDetailsViewController.m
//  MoviesGallery
//
//  Created by Jeffrey on 11/2/2016.
//  Copyright © 2016 jeffreyleeon. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import <AsyncImageView/AsyncImageView.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

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
    float accumulatedHeight = 0;
    
    // Add trailer or image
    float height = 300;
    [self addTrailerOrImageWithHeight: height];
    accumulatedHeight += height;
    
}

- (void) addTrailerOrImageWithHeight:(float) height {
    if ([_trailerIdsArray count] > 0) {
        CGRect playerViewRect = CGRectMake(0, 0, SCREEN_WIDTH, height);
        
        _playerView = [[UIView alloc] initWithFrame: playerViewRect];
        NSString* identifier = [_trailerIdsArray objectAtIndex: 0];
        XCDYouTubeVideoPlayerViewController *videoPlayerViewController =
        [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier: identifier];
        [videoPlayerViewController presentInView: _playerView];
        [videoPlayerViewController.moviePlayer play];
        
        [_scrollView addSubview: _playerView];
    } else {
        float height = 300;
        CGRect imageViewRect = CGRectMake(0, 0, SCREEN_WIDTH, height);
        
        AsyncImageView* imageView = [[AsyncImageView alloc] initWithFrame: imageViewRect];
        [imageView setBackgroundColor: [UIColor blackColor]];
        [imageView setImageURL: [_movie getPosterImageURL]];
        [imageView setContentMode: UIViewContentModeScaleAspectFit];
        
        [_scrollView addSubview: imageView];
    }
}

- (void) fetchTrailers {
    [_movieStore fetchTrailerOfMovie: _movie withCallback: ^(NSArray* trailerIds) {
        _trailerIdsArray = [[NSArray alloc] initWithArray: trailerIds copyItems: YES];
        [self initScrollView];
    }];
}

@end
