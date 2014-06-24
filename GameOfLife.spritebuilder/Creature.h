//
//  Creature.h
//  GameOfLife
//
//  Created by David Ott on 6/24/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCSprite.h"

@interface Creature : CCSprite {
    
}
@property (nonatomic, assign) BOOL isAlive;
@property (nonatomic, assign) NSInteger livingNeighbors;

-(id) initCreature;

@end
