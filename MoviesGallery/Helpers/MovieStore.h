#import <foundation/Foundation.h>
#import "../Models/Movie.h"

@interface MovieStore : NSObject

+(id) sharedInstance;

-(void) fetchTopMoviesWithCallback:(void(^)(id))callback;
-(void) fetchPopularMoviesWithCallback:(void(^)(id))callback;
-(void) fetchCurrentMoviesWithCallback:(void(^)(id))callback;
-(void) fetchComingSoonMoviesWithCallback:(void(^)(id))callback;
-(void) fetchTrailerOfMovie:(Movie*)movie withCallback:(void(^)(id))callback;
-(void) searchMovies:(NSString*)keywords withCallback:(void(^)(id))callback;

@end