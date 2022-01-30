//
//  OHNetworkProxy.m
//  BasicKitApp
//
//  Created by XuWang Real on 2022/1/30.
//  Copyright © 2022 曾谞旺. All rights reserved.
//

#import "OHNetworkProxy.h"
#import <NetworkExtension/NetworkExtension.h>

@interface OHNetworkProxy ()
@property (nonatomic, strong) NEVPNManager *manager;
@end

@implementation OHNetworkProxy

#pragma mark Public
- (void)start:(OHNetworkProxyErrorHandler)callback {
    NEVPNProtocolIPSec *config = [[NEVPNProtocolIPSec alloc] init];
    config.username = @"ourfor";
    config.serverAddress = @"localhost";
    config.authenticationMethod = NEVPNIKEAuthenticationMethodSharedSecret;
    config.disconnectOnSleep = NO;
    config.useExtendedAuthentication = YES;
    
    self.manager.protocolConfiguration = config;
    self.manager.localizedDescription = @"Network Proxy";
    [self.manager setEnabled:YES];
    [self.manager saveToPreferencesWithCompletionHandler:callback];
    [self.manager loadFromPreferencesWithCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            
        }
    }];
}


- (void)stop {
    [self.manager.connection stopVPNTunnel];
}


#pragma mark Getter
- (NEVPNManager *)manager {
    BeginLazyPropInit(manager)
    manager = [NEVPNManager sharedManager];
    EndLazyPropInit(manager)
}
@end
