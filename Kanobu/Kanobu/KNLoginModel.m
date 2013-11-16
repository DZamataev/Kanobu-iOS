//
//  KNLoginModel.m
//  Kanobu
//
//  Created by Admin on 06.11.13.
//  Copyright (c) 2013 Denis Zamataev. All rights reserved.
//

#import "KNLoginModel.h"
#import "KNAccessToken.h"

#define CLIENT_ID @""
#define CLIENT_SECRET @""

@implementation KNLoginModel
- (id)init {
    self = [super init];
    if (self) {
        self.objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://kanobu.ru"]];
        [self.objectManager.HTTPClient setAuthorizationHeaderWithUsername:CLIENT_ID password:CLIENT_SECRET];
    }
    return self;
}

- (void)setupResponseDescriptors {
    RKObjectMapping *acessTokenMapping = [RKObjectMapping mappingForClass:[KNAccessToken class]];
    [acessTokenMapping addAttributeMappingsFromArray:@[@"access_token",@"token_type",@"expires_in",@"refresh_token", @"scope"]];
    RKResponseDescriptor *acessTokenPostResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:acessTokenMapping
                                                                                                  method:RKRequestMethodPOST
                                                                                             pathPattern:@"/oauth/token"
                                                                                                 keyPath:nil
                                                                                             statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.objectManager addResponseDescriptor:acessTokenPostResponseDescriptor];
}

- (void)loginWithUsername:(NSString*)username andPassword:(NSString*)password {
    NSString *grant_type = @"password";
    [self.objectManager postObject:nil path:@"/oauth/token"
                        parameters:@{ @"grant_type":grant_type, @"username":username, @"password":password }
                           success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                               
                           }
                           failure:^(RKObjectRequestOperation *operation, NSError *error) {
                               
                           }];
}
@end
