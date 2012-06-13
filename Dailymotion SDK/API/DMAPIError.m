//
//  DMAPIError.m
//  Dailymotion SDK iOS
//
//  Created by Olivier Poitrey on 11/06/12.
//  Copyright (c) 2012 Dailymotion. All rights reserved.
//

#import "DMAPIError.h"

NSString * const DailymotionTransportErrorDomain = @"DailymotionTransportErrorDomain";
NSString * const DailymotionAuthErrorDomain = @"DailymotionAuthErrorDomain";
NSString * const DailymotionApiErrorDomain = @"DailymotionApiErrorDomain";

@implementation DMAPIError

+ (NSError *)errorWithMessage:(NSString *)message domain:(NSString *)domain type:(NSString *)type response:(NSURLResponse *)response data:(NSData *)data
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    if (type)
    {
        [userInfo setObject:type forKey:@"error"];
    }
    if (message)
    {
        [userInfo setObject:message forKey:NSLocalizedDescriptionKey];
    }
    if (response)
    {
        [userInfo setObject:[NSNumber numberWithInt:httpResponse.statusCode] forKey:@"status-code"];

        if ([httpResponse.allHeaderFields valueForKey:@"Content-Type"])
        {
            [userInfo setObject:[httpResponse.allHeaderFields valueForKey:@"Content-Type"] forKey:@"content-type"];
        }
    }
    if (data)
    {
        [userInfo setObject:[data copy] forKey:@"content-data"];
    }

    NSInteger code = 0;
    if ([type isKindOfClass:[NSNumber class]])
    {
        code = type.intValue;
    }

    return [NSError errorWithDomain:domain code:code userInfo:userInfo];
}


@end