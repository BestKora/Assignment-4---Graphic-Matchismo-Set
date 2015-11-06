//
//  GameSettingsViewController.m
//  Matchismo3
//
//  Created by Tatiana Kornilova on 11/15/13.
//  Copyright (c) 2013 Tatiana Kornilova. All rights reserved.
//

#import "GameSettingsViewController.h"
#import "GameSettings.h"

@interface GameSettingsViewController ()
@property (weak, nonatomic) IBOutlet UIStepper *bonusStepper;
@property (weak, nonatomic) IBOutlet UIStepper *penaltyStepper;
@property (weak, nonatomic) IBOutlet UIStepper *flipCostStepper;
@property (weak, nonatomic) IBOutlet UILabel *bonusLabel;
@property (weak, nonatomic) IBOutlet UILabel *penaltyLabal;
@property (weak, nonatomic) IBOutlet UILabel *flipCostLabel;

@property (nonatomic,strong) GameSettings *gameSettings;

@end

@implementation GameSettingsViewController

- (GameSettings *)gameSettings
{
    if (!_gameSettings) _gameSettings = [[GameSettings alloc] init];
    return _gameSettings;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupUI];
}
- (void) setupUI
{
    self.bonusStepper.value = self.gameSettings.bonus;
    self.penaltyStepper.value = self.gameSettings.penalty;
    self.flipCostStepper.value = self.gameSettings.flipCost;
    self.bonusLabel.text =[NSString stringWithFormat:@"Match Bonus: %d",self.gameSettings.bonus];
    self.penaltyLabal.text =[NSString stringWithFormat:@"Mismatch penalty: %d",self.gameSettings.penalty];
    self.flipCostLabel.text =[NSString stringWithFormat:@"Flip Cost: %d",self.gameSettings.flipCost];
}

- (IBAction)stepperChanged:(UIStepper *)sender
{
    self.bonusLabel.text =[NSString stringWithFormat:@"Match Bonus: %d",(int)round(self.bonusStepper.value)];
    self.gameSettings.bonus = (int)round(self.bonusStepper.value);
}
- (IBAction)stepperPenaltyChanged:(UIStepper *)sender
{
    self.penaltyLabal.text =[NSString stringWithFormat:@"Mismatch penalty: %d",(int)round(self.penaltyStepper.value)];
    self.gameSettings.penalty = (int)round(self.penaltyStepper.value);
}
- (IBAction)stepperFlipCostChanged:(UIStepper *)sender
{
    self.flipCostLabel.text =[NSString stringWithFormat:@"Flip Cost: %d",(int)round(self.flipCostStepper.value)];
    self.gameSettings.flipCost = (int)round(self.flipCostStepper.value);
}

@end
