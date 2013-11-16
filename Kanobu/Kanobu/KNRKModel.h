//
//  KNSubmodel.h
//  Kanobu
//
//  Created by Admin on 16.11.13.
//  Copyright (c) 2013 Denis Zamataev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit.h>

@interface KNRKModel : NSObject

@property (nonatomic, strong) RKObjectManager* objectManager;
@property (nonatomic, strong) RKManagedObjectStore* managedObjectStore;

+ (instancetype)modelWithObjectManager:(RKObjectManager*)objectManager andManagedObjectStore:(RKManagedObjectStore*)managedObjectStore;
- (void)setupResponseDescriptors;
@end
