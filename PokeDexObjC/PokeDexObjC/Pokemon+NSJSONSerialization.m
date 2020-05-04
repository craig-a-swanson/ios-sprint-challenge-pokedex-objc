//
//  Pokemon+NSJSONSerialization.m
//  PokeDexObjC
//
//  Created by Craig Swanson on 5/3/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import "Pokemon+NSJSONSerialization.h"

@implementation Pokemon (NSJSONSerialization)


- (instancetype)initTableViewWithArray:(NSArray *)array {
    
    NSMutableArray *pokemonArray = [[NSMutableArray alloc] init];
    NSDictionary *pokemonDictionary = [array objectAtIndex:0];
    
    for (NSDictionary *dictionary in pokemonDictionary) {
    
    NSString *name = [dictionary objectForKey:@"name"];
    if (![name isKindOfClass:[NSString class]]) return nil;
    
    NSURL *detailURL = [dictionary objectForKey:@"url"];
    if (![detailURL isKindOfClass:[NSURL class]]) return nil;
    
        Pokemon *newPokemon = [[Pokemon alloc] initTableViewWithName:name detailURL:detailURL];
        [pokemonArray addObject:newPokemon];
    }
    self = [self initWithAllPokemon:pokemonArray];
    return self;
}

@end
