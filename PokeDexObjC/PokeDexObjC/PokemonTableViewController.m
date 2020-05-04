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

- (void)viewDidLoad {
    [super viewDidLoad];

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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowDetailSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PokemonDetailViewController *detailVC = segue.destinationViewController;
        
        Pokemon *currentPokemon = [self.internalPokemon objectAtIndex:indexPath.row];
        [PokemonAPI.sharedController fillInDetailsFor:currentPokemon];
        detailVC.pokemon = currentPokemon;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
