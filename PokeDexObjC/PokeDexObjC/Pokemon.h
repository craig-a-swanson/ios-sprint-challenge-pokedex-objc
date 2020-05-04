//
//  Pokemon.h
//  PokeDexObjC
//
//  Created by Craig Swanson on 5/3/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Pokemon : NSObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly) NSURL *detailURL;
@property (nonatomic, readonly) NSUInteger identifier;
@property (nonatomic, readonly) NSURL *sprite;
@property (nonatomic, readonly, copy) NSArray *abilities;

- (instancetype)initWithName:(NSString *)name
                   detailURL:(NSURL *)detailURL
                  identifier:(NSUInteger) identifier
                      sprite:(NSURL *)sprite
                   abilities:(NSArray *)abilities;

- (instancetype)initTableViewWithName:(NSString *)name
                            detailURL:(NSURL *)detailURL;

@end

NS_ASSUME_NONNULL_END
