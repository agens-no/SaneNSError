//
// Authors:
// Håvard Fossli <hfossli@agens.no>
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

#import <Foundation/Foundation.h>

@interface NSError (SaneNSError)

/*
 * Examples
 *
 * whatWentWrongAndWhy: Could not log in due to incorrect username and/or password
 * why: Username and/or password is incorrect
 * suggestion: Verify username and password is typed correctly
 */

@property (nonatomic, readonly) NSString *whatWentWrongAndWhy;  // NSLocalizedDescriptionKey
@property (nonatomic, readonly) NSString *why;                  // NSLocalizedFailureReasonErrorKey
@property (nonatomic, readonly) NSString *suggestion;           // NSLocalizedRecoverySuggestionErrorKey

+ (instancetype)errorWithDomain:(NSString *)domain
                           code:(NSInteger)code
            whatWentWrongAndWhy:(NSString *)whatAndWhy
                            why:(NSString *)why
                     suggestion:(NSString *)suggestion;

+ (instancetype)errorWithDomain:(NSString *)domain
                           code:(NSInteger)code
            whatWentWrongAndWhy:(NSString *)whatAndWhy
                            why:(NSString *)why
                     suggestion:(NSString *)suggestion
                underlyingError:(NSError *)underlyingError;

+ (instancetype)errorWithDomain:(NSString *)domain
                           code:(NSInteger)code
            whatWentWrongAndWhy:(NSString *)whatAndWhy
                            why:(NSString *)why
                     suggestion:(NSString *)suggestion
                underlyingError:(NSError *)underlyingError
                  extraUserInfo:(NSDictionary *)extraInfo;

+ (instancetype)errorWithDomain:(NSString *)domain
                           code:(NSInteger)code
             getExplanationFrom:(NSError *)underlyingError;

+ (instancetype)errorWithDomain:(NSString *)domain
                           code:(NSInteger)code
             getExplanationFrom:(NSError *)underlyingError
                  extraUserInfo:(NSDictionary *)extraInfo;

- (instancetype)useExplanationAndCreateErrorWithDomain:(NSString *)domain
                                                  code:(NSInteger)code;

- (instancetype)useExplanationAndCreateErrorWithDomain:(NSString *)domain
                                                  code:(NSInteger)code
                                         extraUserInfo:(NSDictionary *)extraInfo;

- (NSException *)errorAsException;

- (NSException *)errorAsExceptionWithName:(NSString *)name;

@end

