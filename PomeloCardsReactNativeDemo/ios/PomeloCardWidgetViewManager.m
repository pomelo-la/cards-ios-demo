//
//  PomeloCardWidgetViewManager.m
//  PomeloCardsReactNativeDemo
//
//  Created by Fernando Pena on 02/03/2023.
//

//#import <Foundation/Foundation.h>
//#import "React/RCTViewManager.h"
//
//@interface RCT_EXTERN_MODULE(PomeloCardWidgetViewManager, NSObject)
//
//@end

#import <Foundation/Foundation.h>
#import "React/RCTViewManager.h"

@interface RCT_EXTERN_MODULE(PomeloCardWidgetViewManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(setupParams, NSDictionary)

@end
