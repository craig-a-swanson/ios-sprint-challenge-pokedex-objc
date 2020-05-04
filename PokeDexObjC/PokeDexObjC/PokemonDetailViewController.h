//
//  PokemonDetailViewController.h
//  PokeDexObjC
//
//  Created by Craig Swanson on 5/4/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Pokemon;

NS_ASSUME_NONNULL_BEGIN

@interface PokemonDetailViewController : UIViewController

@property (nonatomic) Pokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
