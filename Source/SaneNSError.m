//
// Authors:
// Håvard Fossli <hfossli@gmail.com>
//
// Copyright (c) 2013 Agens AS (http://agens.no/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "SaneNSError.h"

# define SNEAssert(expression, ...) \
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

@implementation NSError (SaneNSError)

#pragma mark - Constructors

+ (instancetype)errorWithDomain:(NSString *)domain
                           code:(NSInteger)code
            whatWentWrongAndWhy:(NSString *)whatAndWhy
                            why:(NSString *)why
                     suggestion:(NSString *)suggestion
{
    return [self errorWithDomain:domain
                            code:code
             whatWentWrongAndWhy:whatAndWhy
                             why:why
                      suggestion:suggestion
                 underlyingError:nil
                   extraUserInfo:nil];
}

+ (instancetype)errorWithDomain:(NSString *)domain
                           code:(NSInteger)code
            whatWentWrongAndWhy:(NSString *)whatAndWhy
                            why:(NSString *)why
                     suggestion:(NSString *)suggestion
                underlyingError:(NSError *)underlyingError
{
    return [self errorWithDomain:domain
                            code:code
             whatWentWrongAndWhy:whatAndWhy
                             why:why
                      suggestion:suggestion
                 underlyingError:underlyingError
                   extraUserInfo:nil];
}

+ (instancetype)errorWithDomain:(NSString *)domain
                           code:(NSInteger)code
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

+ (instancetype)errorWithDomain:(NSString *)domain
                           code:(NSInteger)code
             getExplanationFrom:(NSError *)underlyingError
{
    return [self errorWithDomain:domain
                            code:code
              getExplanationFrom:underlyingError
                   extraUserInfo:nil];
}

+ (instancetype)errorWithDomain:(NSString *)domain
                           code:(NSInteger)code
             getExplanationFrom:(NSError *)underlyingError
                  extraUserInfo:(NSDictionary *)extraInfo
{
    SNEAssert(underlyingError != nil, @"Can not initialize without underlyingError");

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

- (instancetype)useExplanationAndCreateErrorWithDomain:(NSString *)domain
                                                  code:(NSInteger)code
{
    return [NSError errorWithDomain:domain code:code getExplanationFrom:self];
}

- (instancetype)useExplanationAndCreateErrorWithDomain:(NSString *)domain
                                                  code:(NSInteger)code
                                         extraUserInfo:(NSDictionary *)extraInfo
{
    return [NSError errorWithDomain:domain code:code getExplanationFrom:self extraUserInfo:extraInfo];
}

#pragma mark - Properties

- (NSString *)whatWentWrongAndWhy
{
    return [self.userInfo objectForKey:NSLocalizedDescriptionKey];
}

- (NSString *)why
{
    return [self.userInfo objectForKey:NSLocalizedFailureReasonErrorKey];
}

- (NSString *)suggestion
{
    return [self.userInfo objectForKey:NSLocalizedRecoverySuggestionErrorKey];
}

#pragma mark - Exceptions

- (NSException *)errorAsException
{
    return [self errorAsExceptionWithName:NSGenericException];
}

- (NSException *)errorAsExceptionWithName:(NSString *)name
{
    return [NSException exceptionWithName:name reason:self.whatWentWrongAndWhy userInfo:self.userInfo];
}

@end
