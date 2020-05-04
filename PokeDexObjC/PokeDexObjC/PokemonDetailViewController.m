//
//  PokemonDetailViewController.m
//  PokeDexObjC
//
//  Created by Craig Swanson on 5/4/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import "PokemonDetailViewController.h"
#import "PokeDexObjC-Swift.h"
#import "Pokemon.h"

void *PokemonDetailControllerContext = &PokemonDetailControllerContext;

@interface PokemonDetailViewController ()

@property PokemonAPI *sharedPokemonController;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *spriteImageView;
@property (strong, nonatomic) IBOutlet UILabel *identifierLabel;
@property (strong, nonatomic) IBOutlet UITextView *abilitiesTextView;

@end

@implementation PokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sharedPokemonController = PokemonAPI.sharedController;
    [self registerAsObserverForPokemonController:self.sharedPokemonController];
    [self.sharedPokemonController fillInDetailsFor:self.pokemon];
}

- (void)registerAsObserverForPokemonController:(PokemonAPI *)pokemonController {
    [pokemonController addObserver:self
                        forKeyPath:@"selectedPokemon"
                           options:0
                           context:PokemonDetailControllerContext];
}

- (void)unregisterAsObserverForController:(PokemonAPI *)pokemonController {
    [pokemonController removeObserver:self
                           forKeyPath:@"selectedPokemon"
                              context:PokemonDetailControllerContext];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (context == PokemonDetailControllerContext) {
        if ([keyPath isEqualToString:@"selectedPokemon"]) {
            [self updateViews];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)updateViews {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSNumber *idNumber = [NSNumber numberWithInteger:self.sharedPokemonController.selectedPokemon.identifier];
        self.nameLabel.text = self.sharedPokemonController.selectedPokemon.name;
        self.spriteImageView.image = self.sharedPokemonController.selectedPokemon.spriteImage;
        self.identifierLabel.text = [NSString stringWithFormat:@"%@", idNumber];
        self.abilitiesTextView.text = self.sharedPokemonController.selectedPokemon.abilities.description;
    });

}

- (void)dealloc {
    [self unregisterAsObserverForController:self.sharedPokemonController];
}

@end
