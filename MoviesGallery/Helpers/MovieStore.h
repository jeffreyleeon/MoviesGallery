#import <foundation/Foundation.h>

@interface MovieStore : NSObject

+(id) sharedInstance;

-(void) fetchTopMoviesWithCallback:(void(^)(id))callback;
-(void) fetchPopularMoviesWithCallback:(void(^)(id))callback;
-(void) fetchCurrentMoviesWithCallback:(void(^)(id))callback;
-(void) fetchComingSoonMoviesWithCallback:(void(^)(id))callback;

@end