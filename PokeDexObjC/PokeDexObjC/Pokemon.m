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
                  identifier:(NSString *)identifier
                      sprite:(NSURL *)sprite
                   abilities:(NSArray *)abilities {
    if (self = [super init]) {
        _name = [name copy];
        _identifier = [identifier copy];
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

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSArray *abilities = [dictionary objectForKey:@"abilities"];
    
    NSMutableArray *abilitiesArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in abilities) {
        NSDictionary *abilityDictionary = [dictionary objectForKey:@"ability"];
        NSString *name = [abilityDictionary objectForKey:@"name"];
        if (![name isKindOfClass:[NSString class]]) return nil;
        
        [abilitiesArray addObject:name];
    }
    
    NSString *identifier = [dictionary objectForKey:@"id"];
    
    NSString *characterName = [dictionary objectForKey:@"name"];
    
    NSDictionary *spriteDictionary = [dictionary objectForKey:@"sprites"];
    NSURL *spriteURL = [spriteDictionary objectForKey:@"front_default"];
    
    self = [self initWithName:characterName identifier:identifier sprite:spriteURL abilities:abilitiesArray];
    
    return self;
}

- (instancetype)initTableViewWithDictionary:(NSDictionary *)dictionary {
    NSArray *array = [dictionary objectForKey:@"results"];
    NSMutableArray *pokemonArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in array) {
        
        NSString *name = [dictionary objectForKey:@"name"];
        if (![name isKindOfClass:[NSString class]]) return nil;
        
        NSURL *detailURL = [dictionary objectForKey:@"url"];
        if (![detailURL isKindOfClass:[NSString class]]) return nil;
        
        Pokemon *newPokemon = [[Pokemon alloc] initTableViewWithName:name detailURL:detailURL];
        [pokemonArray addObject:newPokemon];
    }
    self = [self initWithAllPokemon:pokemonArray];
    return self;
}

@end
