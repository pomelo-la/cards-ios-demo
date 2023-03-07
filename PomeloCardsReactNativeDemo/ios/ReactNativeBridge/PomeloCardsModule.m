//
//  PomeloCardsModule.m
//  PomeloCardsReactNativeDemo
//
//  Created by Fernando Pena on 01/03/2023.
//

#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(PomeloCardsModule, NSObject)

RCT_EXTERN_METHOD(setupSDK:(nonnull NSString*)email)

RCT_EXTERN_METHOD(launchCardListWidget:(nonnull NSString*)cardId
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(launchChangePinWidget:(nonnull NSString*)cardId
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(launchActivateCardWidget:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)

@end
