//
//  Creature.m
//  GameOfLife
//
//  Created by David Ott on 6/24/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "Creature.h"


@implementation Creature

-(instancetype) initCreature
{
    self = [super initWithImageNamed:@"GameOfLifeAssets/Assets/bubble.png"];
    
    if (self) {
        self.isAlive = NO;
    }
    
    return self;
}


-(void) setIsAlive:(BOOL) newState
{
    _isAlive = newState;
    self.visible = _isAlive;
}

@end
