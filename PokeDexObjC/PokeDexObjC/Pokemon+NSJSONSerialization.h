//
//  Pokemon+NSJSONSerialization.h
//  PokeDexObjC
//
//  Created by Craig Swanson on 5/3/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import "Pokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface Pokemon (NSJSONSerialization)

- (instancetype)initTableViewWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
