//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Tatiana Kornilova on 11/2/13.
//  Copyright (c) 2013 Tatiana Kornilova. All rights reserved.
//
// Abstract class. Must implement methods as describeed below.

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"
#import "GameSettings.h"


@interface CardGameViewController : UIViewController

@property (nonatomic)NSUInteger numberOfMatches;
@property (nonatomic)BOOL addCardsAfterDelete;
@property (nonatomic) CGSize maxCardSize;


// protected
// for subclasses
- (Deck *)createDeck;   //abstract
- (NSUInteger) startingCardCount; //abstract

- (UIView *)cellViewForCard:(Card *)card inRect:(CGRect)rect; //abstract
- (void) updateCell:(UIView *)cell usingCard:(Card *)card animate:(BOOL)animate; //abstract


@end
