//
//  Movie.h
//  MoviesGallery
//
//  Created by Jeffrey on 31/1/2016.
//  Copyright © 2016 jeffreyleeon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject {
}

@property (readonly) NSInteger movieId;
@property (readonly) NSInteger adult;
@property (readonly) NSInteger video;
@property (readonly) NSInteger voteCount;
@property (readonly) float popularity;
@property (readonly) float voteAverage;
@property (readonly) NSString* title;
@property (readonly) NSString* overview;
@property (readonly) NSString* posterImagePath;
@property (readonly) NSString* language;
@property (readonly) NSString* releaseDate;
//@property (readonly) NSArray* genreIds;

- (id)initWithDictionary:(NSDictionary *) dictionary;
- (NSInteger) getMovieId;
- (NSString*) getTitle;
- (NSString*) getOverview;
- (NSString*) getVoteAverageString;
- (NSURL*) getPosterImageURL;
- (NSData*) getPosterImageData;
- (NSString*) getReleaseDate;

@end
