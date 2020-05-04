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
    
    NSDictionary *dictionary = [array objectAtIndex:0];
    
    NSString *name = [dictionary objectForKey:@"name"];
    if (![name isKindOfClass:[NSString class]]) return nil;
    
    NSURL *detailURL = [dictionary objectForKey:@"url"];
    if (![detailURL isKindOfClass:[NSURL class]]) return nil;
    
    return [self initTableViewWithName:name detailURL:detailURL];
}

@end
