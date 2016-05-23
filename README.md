Sane NSError
======================

Creating NSError can often be confusing. According to Apple's guidelines and how NSError is used by community it is safe to understand the error keys like this:

- NSLocalizedDescriptionKey => What went wrong, and why the error occurred
- NSLocalizedFailureReasonErrorKey => Why the error occurred
- NSLocalizedRecoverySuggestionErrorKey => What can be done to circumvent or fix the error

## Example code

Creating errors is much easier and ambiguous now:

```objc
NSError *error = [NSError errorWithDomain:ZYZUserServiceDomain
                                     code:0
                      whatWentWrongAndWhy:@"Could not log in due to incorrect username or password"
                                      why:@"Username or password is incorrect"
                               suggestion:@"Verify username and password is typed correctly"];
```

Handy properties:

```objc
@property (nonatomic, readonly) NSString *whatWentWrongAndWhy;  // NSLocalizedDescriptionKey
@property (nonatomic, readonly) NSString *why;                  // NSLocalizedFailureReasonErrorKey
@property (nonatomic, readonly) NSString *suggestion;           // NSLocalizedRecoverySuggestionErrorKey
```

Makes it very trivial to get the relevant information:

```objc
NSLog(@"Could not log in: %@", error.why);
```

## FAQ

Q: Why is there one key with both "what" and "why"? We already answer "why" in the "FailureReason"-key.  
A: This is how NSError is designed – which is great since it enables developers to choose between a well articulated and verbose sentence and a more simple one. 



## Keywords

NSError, easy, setup, explained, how to construct NSError, NSLocalizedDescriptionKey, NSLocalizedFailureReasonErrorKey, NSLocalizedRecoverySuggestionErrorKey, domain, code.


## Who's behind this?

You can reach me on twitter as [@hfossli](https://twitter.com/hfossli). Agens.no a company situated in Oslo, Norway.



[![Agens | Digital craftsmanship](http://static.agens.no/images/agens_logo_w_slogan_avenir_small.png)](http://agens.no/)
