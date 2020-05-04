//
//  Pokemon.m
//  PokeDexObjC
//
//  Created by Craig Swanson on 5/3/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import "Pokemon.h"

@implementation Pokemon

- (instancetype)initWithName:(NSString *)name
                   detailURL:(NSURL *)detailURL
                  identifier:(NSUInteger)identifier
                      sprite:(NSURL *)sprite
                   abilities:(NSArray *)abilities {
    if (self = [super init]) {
        _name = [name copy];
        _detailURL = detailURL;
        _identifier = identifier;
        _sprite = sprite;
        _abilities = [abilities copy];
    }
    return self;
}

- (instancetype)initTableViewWithName:(NSString *)name detailURL:(NSURL *)detailURL {
    if (self = [super init]) {
        _name = [name copy];
        _detailURL = detailURL;
    }
    return self;
}

- (instancetype)initWithAllPokemon:(NSArray<Pokemon *> *)allPokemon {
    if (self = [super init]) {
        _allPokemon = allPokemon;
    }
    return self;
}

@end
