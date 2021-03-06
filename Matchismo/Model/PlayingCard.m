//
//  PlayingCard.m
//  Matchismo
//
//  Created by Peter DeVito on 11/10/13.
//  Copyright (c) 2013 Peter DeVito. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

#define RANK_MATCH_SCORE 4
#define SUIT_MATCH_SCORE 1

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    int tempScore = 0;
    NSMutableArray *searchCards = [[NSMutableArray alloc] init]; // hold temp array of Cards to compare
    NSArray *matchCards = [otherCards arrayByAddingObject:self]; // create array of all chosen Cards
    for (PlayingCard *compareCard in matchCards) {
        [searchCards setArray:matchCards]; // duplicate matchCards over to searchCards
        [searchCards removeObject:compareCard]; // remove our current comparison Card
        int tempRankScore = 0;
        int tempSuitScore = 0;
        for (PlayingCard *card in searchCards) { 
            if (card.rank == compareCard.rank) {
                tempRankScore += RANK_MATCH_SCORE;
            }
            if ([card.suit isEqualToString:compareCard.suit]) {
                tempSuitScore += SUIT_MATCH_SCORE;
            }
        }
        tempScore = (tempRankScore > tempSuitScore) ? tempRankScore : tempSuitScore;
        score = (score < tempScore) ? tempScore : score;
    }
    return score;
}

- (NSString *) contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;   // because we provide setter and getter

+ (NSArray *)validSuits
{
    return @[@"♠",@"♣",@"♥",@"♦"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
