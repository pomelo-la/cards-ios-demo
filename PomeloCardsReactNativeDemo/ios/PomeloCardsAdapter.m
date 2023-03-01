//
//  PomeloCardsAdapter.m
//  PomeloCardsReactNativeDemo
//
//  Created by Fernando Pena on 01/03/2023.
//

#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(PomeloCardsAdapter, NSObject)

RCT_EXTERN_METHOD(launchCards: (RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)

@end
