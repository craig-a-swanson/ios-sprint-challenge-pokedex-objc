//
//  Pokemon.h
//  PokeDexObjC
//
//  Created by Craig Swanson on 5/3/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Pokemon : NSObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly) NSString *detailURL;
@property (nonatomic, readonly) NSInteger identifier;
@property (nonatomic, readonly) NSString *sprite;
@property (nonatomic) UIImage *spriteImage;
@property (nonatomic, readonly, copy) NSArray *abilities;
@property (nonatomic, readonly) NSArray<Pokemon *> *allPokemon;

- (instancetype)initWithName:(NSString *)name
                  identifier:(NSInteger)identifier
                      sprite:(NSString *)sprite
                   abilities:(NSArray *)abilities;

// Initializer used in populating the table view
- (instancetype)initTableViewWithName:(NSString *)name
                            detailURL:(NSString *)detailURL;

// initWithDictionary is used to decode JSON for the detail view controller
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

// initWithAllPokemon and initTableViewWithDictionary are used to decode JSON for the table view controller
- (instancetype)initWithAllPokemon:(NSArray<Pokemon *> *)allPokemon;
- (instancetype)initTableViewWithDictionary:(NSDictionary *)dictionary;


@end

NS_ASSUME_NONNULL_END
