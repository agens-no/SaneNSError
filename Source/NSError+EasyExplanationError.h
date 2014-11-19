//
// Created by Agens AS for AGSError on 07.02.14.
//

#import <Foundation/Foundation.h>


@interface NSError (EasyExplanationError)

/*
 * Examples
 *
 * whatWentWrongAndWhy: Could not log in due to bad username and/or password
 * why: Username and/or password is incorrect
 * suggestion: Verify username and password is typed correctly
 */

@property (nonatomic, readonly) NSString *eee_whatWentWrongAndWhy; // NSLocalizedDescriptionKey
@property (nonatomic, readonly) NSString *eee_why; // NSLocalizedFailureReasonErrorKey
@property (nonatomic, readonly) NSString *eee_suggestion; // NSLocalizedRecoverySuggestionErrorKey

+ (instancetype)eee_errorWithDomain:(NSString *)domain
                               code:(NSUInteger)code
                whatWentWrongAndWhy:(NSString *)whatAndWhy
                                why:(NSString *)why
                         suggestion:(NSString *)suggestion;

+ (instancetype)eee_errorWithDomain:(NSString *)domain
                               code:(NSUInteger)code
                whatWentWrongAndWhy:(NSString *)whatAndWhy
                                why:(NSString *)why
                         suggestion:(NSString *)suggestion
                    underlyingError:(NSError *)underlyingError;

+ (instancetype)eee_errorWithDomain:(NSString *)domain
                               code:(NSUInteger)code
                whatWentWrongAndWhy:(NSString *)whatAndWhy
                                why:(NSString *)why
                         suggestion:(NSString *)suggestion
                    underlyingError:(NSError *)underlyingError
                      extraUserInfo:(NSDictionary *)extraInfo;

+ (instancetype)eee_errorWithDomain:(NSString *)domain
                               code:(NSUInteger)code
                 getExplanationFrom:(NSError *)underlyingError;

+ (instancetype)eee_errorWithDomain:(NSString *)domain
                               code:(NSUInteger)code
                 getExplanationFrom:(NSError *)underlyingError
                      extraUserInfo:(NSDictionary *)extraInfo;

- (instancetype)eee_useExplanationAndCreateErrorWithDomain:(NSString *)domain
                                                      code:(NSUInteger)code;

- (instancetype)eee_useExplanationAndCreateErrorWithDomain:(NSString *)domain
                                                      code:(NSUInteger)code
                                             extraUserInfo:(NSDictionary *)extraInfo;

- (NSException *)eee_errorAsException;

- (NSException *)eee_errorAsExceptionWithName:(NSString *)name;

@end

