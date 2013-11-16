//
//  KNModel.m
//  Kanobu
//
//  Created by Admin on 16.11.13.
//  Copyright (c) 2013 Denis Zamataev. All rights reserved.
//

#import "KNApiModel.h"
#import "KNLoginModel.h"

// Log levels: off, error, warn, info, verbose
static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation KNApiModel
+ (KNApiModel*)sharedInstance
{
    static KNApiModel* instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[KNApiModel alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        [self setupRestKit];
        self.login = [KNLoginModel new];
    }
    return self;
}

- (void)setupRestKit {
    
    NSURL *baseURL = [NSURL URLWithString:@"http://demo-rest.kanobu.ru"];
    self.objectManager = [RKObjectManager managerWithBaseURL:baseURL];
    
    // Enable Activity Indicator Spinner
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    // Initialize managed object store
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    self.managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    self.objectManager.managedObjectStore = self.managedObjectStore;
    
    // Complete Core Data stack initialization
    
    [self.managedObjectStore createPersistentStoreCoordinator];
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"Kanobu.sqlite"];
    NSString *seedPath = nil;
    NSError *presistentStoreAddingError;
    NSPersistentStore *persistentStore = [self.managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:seedPath withConfiguration:nil options:nil error:&presistentStoreAddingError];
    
    if (!persistentStore) {
        DDLogError(@"Failed to add persistent store with error: %@", presistentStoreAddingError);
        NSError *fileRemovalError, *persistentStoreAddingAgainError;
        DDLogVerbose(@"Removing incompatible persistent store at path: %@", storePath);
        [[NSFileManager defaultManager] removeItemAtPath:storePath error:&fileRemovalError];
        if (!fileRemovalError) {
            persistentStore = [self.managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:seedPath withConfiguration:nil options:nil error:&persistentStoreAddingAgainError];
            NSAssert(persistentStore, @"Failed to add persistent store after deliting old one with error: %@", persistentStoreAddingAgainError);
        }
        else {
            DDLogError(@"Cannot remove old store at path: %@\n error: %@", storePath, fileRemovalError);
        }
    }
    
    // Create the managed object contexts
    [self.managedObjectStore createManagedObjectContexts];
    
    // Configure a managed object cache to ensure we do not create duplicate objects
    self.managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:self.managedObjectStore.persistentStoreManagedObjectContext];
    
    [RKObjectManager setSharedManager:self.objectManager];
}

- (void)setupResponseDescriptors {
    RKEntityMapping *apiMapping = [RKEntityMapping mappingForEntityForName:@"KNApi" inManagedObjectStore:self.managedObjectStore];
//    userMapping.identificationAttributes = @[ @"userID" ];
    [apiMapping addAttributeMappingsFromArray:@[@"shouts",@"articles",@"posts",@"news"]];
    RKResponseDescriptor *apiGetResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:apiMapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:@"/api"
                                                                                           keyPath:nil
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.objectManager addResponseDescriptor:apiGetResponseDescriptor];
}

- (void)loadApi {
    
}
@end
