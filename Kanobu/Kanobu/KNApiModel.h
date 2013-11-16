//
//  KNModel.h
//  Kanobu
//
//  Created by Admin on 16.11.13.
//  Copyright (c) 2013 Denis Zamataev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KNRKModel.h"

@class KNLoginModel;

#define DAL [KNApiModel sharedInstance]

@interface KNApiModel : KNRKModel

+ (KNApiModel*)sharedInstance;

@property (nonatomic, strong) KNLoginModel *login;

- (void)setupRestKit;
@end
