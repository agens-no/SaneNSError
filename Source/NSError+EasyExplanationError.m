//
// Created by Agens AS for AGSError on 07.02.14.
//

#import "NSError+EasyExplanationError.h"

# define EEEErrorAssert(expression, ...) \
    do {\
        if (!(expression)) {	\
                NSString *description = [NSString stringWithFormat:@"" __VA_ARGS__]; \
                NSString *reason = [NSString \
                    stringWithFormat: @"Assertion failed with expression (%s) in %@:%i %s. %@", \
                    #expression, \
                    [[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
                    __LINE__, \
                    __PRETTY_FUNCTION__, \
                    description]; \
                NSLog(@"Description: %@", description); \
                NSLog(@"Reason: %@", reason); \
                [[NSException exceptionWithName:NSInternalInconsistencyException reason:reason userInfo:nil] raise]; \
                abort(); \
        } \
    } while(0)

@implementation NSError (EasyExplanationError)

#pragma mark - Constructors

+ (instancetype)eee_errorWithDomain:(NSString *)domain
                               code:(NSUInteger)code
                whatWentWrongAndWhy:(NSString *)whatAndWhy
                                why:(NSString *)why
                         suggestion:(NSString *)suggestion
{
    return [self eee_errorWithDomain:domain
                                code:code
                 whatWentWrongAndWhy:whatAndWhy
                                 why:why
                          suggestion:suggestion
                     underlyingError:nil
                       extraUserInfo:nil];
}

+ (instancetype)eee_errorWithDomain:(NSString *)domain
                               code:(NSUInteger)code
                whatWentWrongAndWhy:(NSString *)whatAndWhy
                                why:(NSString *)why
                         suggestion:(NSString *)suggestion
                    underlyingError:(NSError *)underlyingError
{
    return [self eee_errorWithDomain:domain
                                code:code
                 whatWentWrongAndWhy:whatAndWhy
                                 why:why
                          suggestion:suggestion
                     underlyingError:underlyingError
                       extraUserInfo:nil];
}

+ (instancetype)eee_errorWithDomain:(NSString *)domain
                               code:(NSUInteger)code
                whatWentWrongAndWhy:(NSString *)whatAndWhy
                                why:(NSString *)why
                         suggestion:(NSString *)suggestion
                    underlyingError:(NSError *)underlyingError
                      extraUserInfo:(NSDictionary *)extraInfo
{
    NSMutableDictionary *userInfo = [NSMutableDictionary new];
    if(extraInfo != nil)
    {
        [userInfo addEntriesFromDictionary:userInfo];
    }
    [userInfo setValue:whatAndWhy forKey:NSLocalizedDescriptionKey];
    [userInfo setValue:why forKey:NSLocalizedFailureReasonErrorKey];
    [userInfo setValue:suggestion forKey:NSLocalizedRecoverySuggestionErrorKey];

    if(underlyingError != nil)
    {
        [userInfo setValue:underlyingError forKey:NSUnderlyingErrorKey];
    }

    NSError *error = [NSError errorWithDomain:domain code:code userInfo:userInfo];
    return error;
}

+ (instancetype)eee_errorWithDomain:(NSString *)domain
                               code:(NSUInteger)code
                 getExplanationFrom:(NSError *)underlyingError
{
    return [self eee_errorWithDomain:domain
                                code:code
                  getExplanationFrom:underlyingError
                       extraUserInfo:nil];
}

+ (instancetype)eee_errorWithDomain:(NSString *)domain
                               code:(NSUInteger)code
                 getExplanationFrom:(NSError *)underlyingError
                      extraUserInfo:(NSDictionary *)extraInfo
{
    EEEErrorAssert(underlyingError != nil, @"Can not initialize without underlyingError");

    NSMutableDictionary *userInfo = [NSMutableDictionary new];
    if(underlyingError.userInfo != nil)
    {
        [userInfo addEntriesFromDictionary:underlyingError.userInfo];
    }
    if(extraInfo != nil)
    {
        [userInfo addEntriesFromDictionary:extraInfo];
    }
    [userInfo setValue:underlyingError forKey:NSUnderlyingErrorKey];
    return [NSError errorWithDomain:domain code:code userInfo:userInfo];
}

- (instancetype)eee_useExplanationAndCreateErrorWithDomain:(NSString *)domain
                                                      code:(NSUInteger)code
{
    return [NSError eee_errorWithDomain:domain code:code getExplanationFrom:self];
}

- (instancetype)eee_useExplanationAndCreateErrorWithDomain:(NSString *)domain
                                                      code:(NSUInteger)code
                                             extraUserInfo:(NSDictionary *)extraInfo
{
    return [NSError eee_errorWithDomain:domain code:code getExplanationFrom:self extraUserInfo:extraInfo];
}

#pragma mark - Properties

- (NSString *)eee_whatWentWrongAndWhy
{
    return [self.userInfo objectForKey:NSLocalizedDescriptionKey];
}

- (NSString *)eee_why
{
    return [self.userInfo objectForKey:NSLocalizedFailureReasonErrorKey];
}

- (NSString *)eee_suggestion
{
    return [self.userInfo objectForKey:NSLocalizedRecoverySuggestionErrorKey];
}

#pragma mark - Exceptions

- (NSException *)eee_errorAsException
{
    return [self eee_errorAsExceptionWithName:NSGenericException];
}

- (NSException *)eee_errorAsExceptionWithName:(NSString *)name
{
    return [NSException exceptionWithName:name reason:self.eee_whatWentWrongAndWhy userInfo:self.userInfo];
}

@end
