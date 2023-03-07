//
//  RCTSwiftLog.h
//  PomeloCardsReactNativeDemo
//
//  Created by Fernando Pena on 07/03/2023.
//

#ifndef RCTSwiftLog_h
#define RCTSwiftLog_h

#import <Foundation/Foundation.h>

@interface RCTSwiftLog : NSObject

+ (void)error:(NSString * _Nonnull)message file:(NSString * _Nonnull)file line:(NSUInteger)line;
+ (void)warn:(NSString * _Nonnull)message file:(NSString * _Nonnull)file line:(NSUInteger)line;
+ (void)info:(NSString * _Nonnull)message file:(NSString * _Nonnull)file line:(NSUInteger)line;
+ (void)log:(NSString * _Nonnull)message file:(NSString * _Nonnull)file line:(NSUInteger)line;
+ (void)trace:(NSString * _Nonnull)message file:(NSString * _Nonnull)file line:(NSUInteger)line;

@end

#endif /* RCTSwiftLog_h */
