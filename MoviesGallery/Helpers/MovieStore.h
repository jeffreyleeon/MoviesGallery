#import <foundation/Foundation.h>

@interface MovieStore : NSObject

+(id) sharedInstance;

-(void) fetchTopMoviesWithCallback:(void(^)(id))callback;
-(void) fetchPopularMoviesWithCallback:(void(^)(id))callback;

@end