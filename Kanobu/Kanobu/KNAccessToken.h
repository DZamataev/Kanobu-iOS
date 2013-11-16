//
//  KNAccessToken.h
//  Kanobu
//
//  Created by Admin on 16.11.13.
//  Copyright (c) 2013 Denis Zamataev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNAccessToken : NSObject

@property (nonatomic, strong) NSString * access_token;
@property (nonatomic, strong) NSString * token_type;
@property (nonatomic, strong) NSNumber * expires_in;
@property (nonatomic, strong) NSString * refresh_token;
@property (nonatomic, strong) NSString * scope;

@end
