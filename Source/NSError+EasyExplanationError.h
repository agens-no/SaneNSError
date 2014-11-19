//
// Created by Agens AS for AGSError on 07.02.14.
//

#import <Foundation/Foundation.h>

@interface NSError (EasyExplanationError)

@property (nonatomic, readonly) NSString *eee_whatWentWrongAndWhy;
@property (nonatomic, readonly) NSString *eee_why;
@property (nonatomic, readonly) NSString *eee_suggestion;

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
                      extraUserInfo:(NSError *)extraInfo;

- (instancetype)eee_errorWithDomain:(NSString *)domain
                               code:(NSUInteger)code
                 getExplanationFrom:(NSError *)underlyingError;

- (instancetype)eee_errorWithDomain:(NSString *)domain
                               code:(NSUInteger)code
                 getExplanationFrom:(NSError *)underlyingError
                      extraUserInfo:(NSDictionary *)extraInfo;

- (void)eee_throwException;

- (void)eee_throwExceptionWithName:(NSString *)name;

@end

