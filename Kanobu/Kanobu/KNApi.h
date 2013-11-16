//
//  KNApi.h
//  Kanobu
//
//  Created by Admin on 16.11.13.
//  Copyright (c) 2013 Denis Zamataev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface KNApi : NSManagedObject

@property (nonatomic, retain) NSString * shouts;
@property (nonatomic, retain) NSString * articles;
@property (nonatomic, retain) NSString * posts;
@property (nonatomic, retain) NSString * news;

@end
