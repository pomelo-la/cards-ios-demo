//
//  PomeloCardsModule.m
//  PomeloCardsReactNativeDemo
//
//  Created by Fernando Pena on 01/03/2023.
//

#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(PomeloCardsModule, NSObject)

RCT_EXTERN_METHOD(launchCards:(NSString)email
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)

@end
