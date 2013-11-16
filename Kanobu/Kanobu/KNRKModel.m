//
//  KNSubmodel.m
//  Kanobu
//
//  Created by Admin on 16.11.13.
//  Copyright (c) 2013 Denis Zamataev. All rights reserved.
//

#import "KNRKModel.h"

@implementation KNRKModel
+ (instancetype)modelWithObjectManager:(RKObjectManager *)objectManager andManagedObjectStore:(RKManagedObjectStore *)managedObjectStore {
    KNRKModel *obj = [KNRKModel new];
    obj.objectManager = objectManager;
    obj.managedObjectStore = managedObjectStore;
    return obj;
}

- (void)setupResponseDescriptors {
    
}
@end
