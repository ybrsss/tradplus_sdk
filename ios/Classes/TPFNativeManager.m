//
//  TPFNativeManager.m
//  tradplus_sdk
//
//  Created by xuejun on 2022/7/13.
//

#import "TPFNativeManager.h"
#import <TradPlusAds/TradPlusAds.h>
#import "TPFNative.h"

@interface TPFNativeManager()

@property (nonatomic,strong)NSMutableDictionary <NSString *,TPFNative *>*nativeAds;
@end

@implementation TPFNativeManager

+ (TPFNativeManager *)sharedInstance
{
    static TPFNativeManager *nativeManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        nativeManager = [[TPFNativeManager alloc] init];
    });
    return nativeManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.nativeAds = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result
{
    NSString *adUnitID = call.arguments[@"adUnitID"];
    if([@"native_load" isEqualToString:call.method])
    {
        [self loadAdWithAdUnitID:adUnitID methodCall:call];
    }
    else if([@"native_ready" isEqualToString:call.method])
    {
        [self isAdReadyWithAdUnitID:adUnitID result:result];
    }
    else if([@"native_entryAdScenario" isEqualToString:call.method])
    {
        [self entryAdScenarioWithAdUnitID:adUnitID methodCall:call];
    }
    else if([@"native_getLoadedCount" isEqualToString:call.method])
    {
        [self getLoadedCount:adUnitID result:result];
    }
    else if([@"native_setCustomAdInfo" isEqualToString:call.method])
    {
        [self setCustomAdInfoWithAdUnitID:adUnitID methodCall:call];
    }
}

- (TPFNative *)getNativeWithAdUnitID:(NSString *)adUnitID
{
    if([self.nativeAds valueForKey:adUnitID])
    {
        return self.nativeAds[adUnitID];
    }
    return nil;
}

- (void)loadAdWithAdUnitID:(NSString *)adUnitID methodCall:(FlutterMethodCall*)call
{
    TPFNative *native = [self getNativeWithAdUnitID:adUnitID];
    if(native == nil)
    {
        native = [[TPFNative alloc] init];
        self.nativeAds[adUnitID] = native;
    }
    NSDictionary *extraMap = call.arguments[@"extraMap"];
    NSInteger loadCount = 0;
    CGFloat maxWaitTime = 0;
    if(extraMap != nil)
    {
        CGFloat templateWidth = [extraMap[@"templateWidth"] floatValue];
        CGFloat templateHeight = [extraMap[@"templateHeight"] floatValue];
        if(templateWidth == 0)
        {
            templateWidth = 320;
        }
        if(templateHeight == 0)
        {
            templateHeight = 250;
        }
        [native setTemplateRenderSize:CGSizeMake(templateWidth, templateHeight)];
        id customMap = extraMap[@"customMap"];
        if(customMap != nil && [customMap isKindOfClass:[NSDictionary class]])
        {
            [native setCustomMap:customMap];
        }
        id localParams = extraMap[@"localParams"];
        if(localParams != nil && [localParams isKindOfClass:[NSDictionary class]])
        {
            [native setLocalParams:localParams];
        }
        BOOL openAutoLoadCallback = [extraMap[@"openAutoLoadCallback"] boolValue];
        if(openAutoLoadCallback)
        {
            [native openAutoLoadCallback];
        }
        loadCount = [extraMap[@"loadCount"] integerValue];
        maxWaitTime = [extraMap[@"maxWaitTime"] floatValue];
    }
    [native setAdUnitID:adUnitID];
    if(loadCount > 0)
    {
        [native loadAds:loadCount maxWaitTime:maxWaitTime];
    }
    else
    {
        [native loadAdWithMaxWaitTime:maxWaitTime];
    }
}

- (void)isAdReadyWithAdUnitID:(NSString *)adUnitID result:(FlutterResult)result;
{
    BOOL isReady = NO;
    TPFNative *native = [self getNativeWithAdUnitID:adUnitID];
    if(native != nil)
    {
        isReady = native.isAdReady;
    }
    else
    {
        MSLogInfo(@"native adUnitID:%@ not initialize",adUnitID);
    }
    result(@(isReady));
}

- (void)entryAdScenarioWithAdUnitID:(NSString *)adUnitID methodCall:(FlutterMethodCall*)call
{
    TPFNative *native = [self getNativeWithAdUnitID:adUnitID];
    NSString *sceneId = call.arguments[@"sceneId"];
    if(native != nil)
    {
        [native entryAdScenario:sceneId];
    }
    else
    {
        MSLogInfo(@"native adUnitID:%@ not initialize",adUnitID);
    }
}

- (void)getLoadedCount:(NSString *)adUnitID result:(FlutterResult)result
{
    TPFNative *native = [self getNativeWithAdUnitID:adUnitID];
    if(native != nil)
    {
        result(@([native getLoadedCount]));
    }
    else
    {
        MSLogInfo(@"native adUnitID:%@ not initialize",adUnitID);
    }
}

- (void)setCustomAdInfoWithAdUnitID:(NSString *)adUnitID methodCall:(FlutterMethodCall*)call
{
    TPFNative *native = [self getNativeWithAdUnitID:adUnitID];
    NSDictionary *customAdInfo = call.arguments[@"customAdInfo"];
    if(native != nil)
    {
        [native setCustomAdInfo:customAdInfo];
    }
    else
    {
        MSLogInfo(@"native adUnitID:%@ not initialize",adUnitID);
    }
}

@end
