//
//  PokemonTableViewController.m
//  PokeDexObjC
//
//  Created by Craig Swanson on 5/3/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import "PokemonTableViewController.h"
#import "PokeDexObjC-Swift.h"
#import "Pokemon.h"
#import "PokemonDetailViewController.h"

@interface PokemonTableViewController ()

@property (nonatomic) NSArray<Pokemon *> *internalPokemon;

@end

@implementation PokemonTableViewController

// MARK: - View Controller Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    // Create the sharedcontroller singleton and then call the method to fetch all pokemon for the table view data
    PokemonAPI *sharedPokemonController = PokemonAPI.sharedController;

    [sharedPokemonController fetchAllPokemonWithCompletion:^(Pokemon * _Nullable possiblePokemon, NSError * _Nullable possibleError) {
        if (possibleError) {
            NSLog(@"Error retrieving all Pokemon for Table View: %@", possibleError);
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.internalPokemon = sharedPokemonController.pokemons;
            [self.tableView reloadData];
        });
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.internalPokemon.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    Pokemon *currentPokemon = self.internalPokemon[indexPath.row];
    cell.textLabel.text = currentPokemon.name;
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowDetailSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PokemonDetailViewController *detailVC = segue.destinationViewController;
        
        Pokemon *currentPokemon = [self.internalPokemon objectAtIndex:indexPath.row];
        detailVC.pokemon = currentPokemon;
    }
}

@end
