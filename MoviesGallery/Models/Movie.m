//
//  Movie.m
//  MoviesGallery
//
//  Created by Jeffrey on 31/1/2016.
//  Copyright © 2016 jeffreyleeon. All rights reserved.
//

#import "Movie.h"

#define ID_KEY @"id"
#define ADULT_KEY @"adult"
#define VIDEO_KEY @"video"
#define VOTE_COUNT_KEY @"vote_count"
#define POPULARITY_KEY @"popularity"
#define VOTE_AVERAGE_KEY @"vote_average"
#define TITLE_KEY @"title"
#define OVERVIEW_KEY @"overview"
#define POSTER_PATH_KEY @"poster_path"
#define LANGUAGE_KEY @"original_language"

#define IMAGE_BASE_PATH @"https://image.tmdb.org/t/p/w185"

@implementation Movie

- (id)initWithDictionary:(NSDictionary *) dictionary {
    if (self = [super init]) {
        _movieId = [[dictionary objectForKey: ID_KEY] integerValue];
        _adult = [[dictionary objectForKey: ADULT_KEY] integerValue];
        _video = [[dictionary objectForKey: VIDEO_KEY] integerValue];
        _voteCount = [[dictionary objectForKey: VOTE_COUNT_KEY] integerValue];
        _popularity = [[dictionary objectForKey: POPULARITY_KEY] doubleValue];
        _voteAverage = [[dictionary objectForKey: VOTE_AVERAGE_KEY] doubleValue];
        _title = [dictionary objectForKey: TITLE_KEY];
        _overview = [dictionary objectForKey: OVERVIEW_KEY];
        NSString* posterPath = [dictionary objectForKey: POSTER_PATH_KEY];
        if (posterPath &&
            ![posterPath isKindOfClass:[NSNull class]]) {
            _posterImagePath = [IMAGE_BASE_PATH stringByAppendingString: [dictionary objectForKey: POSTER_PATH_KEY]];
        }
        _language = [dictionary objectForKey: LANGUAGE_KEY];
    }
    return self;
}

- (NSInteger) getMovieId {
    return _movieId;
}

- (NSString*) getTitle {
    return _title;
}

- (NSString*) getOverview {
    return _overview;
}

- (NSData*) getPosterImageData {
    NSURL* url = [NSURL URLWithString: _posterImagePath];
    NSData* imageData = [NSData dataWithContentsOfURL: url];
    return imageData;
}

@end
