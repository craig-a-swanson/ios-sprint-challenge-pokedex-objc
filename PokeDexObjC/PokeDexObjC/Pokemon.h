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
@property (nonatomic, readonly, copy) NSString *identifier;
@property (nonatomic, readonly) NSURL *sprite;
@property (nonatomic, readonly, copy) NSArray *abilities;
@property (nonatomic, readonly) NSArray<Pokemon *> *allPokemon;

- (instancetype)initWithName:(NSString *)name
                  identifier:(NSString *) identifier
                      sprite:(NSURL *)sprite
                   abilities:(NSArray *)abilities;

- (instancetype)initTableViewWithName:(NSString *)name
                            detailURL:(NSURL *)detailURL;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (instancetype)initWithAllPokemon:(NSArray<Pokemon *> *)allPokemon;
- (instancetype)initTableViewWithDictionary:(NSDictionary *)dictionary;


@end

NS_ASSUME_NONNULL_END
