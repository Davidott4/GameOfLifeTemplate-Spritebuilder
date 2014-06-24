//
//  Grid.h
//  GameOfLife
//
//  Created by David Ott on 6/24/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Grid : CCSprite {
    
}
@property (nonatomic, assign) NSInteger totalAlive;
@property (nonatomic, assign) NSInteger generation;
-(void) evolveStep;
-(void) countNeighbors;
-(void) updateCreatures;
-(BOOL)isIndexValidForX:(int)x andY:(int)y;
@end
