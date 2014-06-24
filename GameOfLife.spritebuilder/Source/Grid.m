//
//  Grid.m
//  GameOfLife
//
//  Created by David Ott on 6/24/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Creature.h"




static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;

@implementation Grid{
    NSMutableArray *_gridArray;
    float _cellWidth;
    float _cellHeight;
}

-(void) onEnter
{
    [super onEnter];
    [self setupGrid];
    self.userInteractionEnabled = YES;
}

-(void) setupGrid
{
    _cellWidth = self.contentSize.width /GRID_COLUMNS;
    _cellHeight = self.contentSize.height / GRID_ROWS;
    
    float x =0;
    float y=0;
    
    _gridArray = [NSMutableArray array];
    
    for (int i=0; i< GRID_ROWS; i++)
    {
        _gridArray[i] = [NSMutableArray array];
        x =0;
        
        for (int j=0; j< GRID_COLUMNS; j++)
        {
            Creature *creature = [[Creature alloc] initCreature];
            creature.anchorPoint = ccp(0,0);
            creature.position = ccp(x,y);
            [self addChild:creature];
            
            _gridArray[i][j] = creature;
            creature.isAlive = NO;
            
            x+=_cellWidth;
        }
        y+=_cellHeight;
    }
}

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInNode:self];
    Creature *creature = [self creatureForTouchPosition:touchLocation];
    creature.isAlive =!creature.isAlive;
}

-(Creature *) creatureForTouchPosition:(CGPoint) touchPosition
{
    NSInteger row = touchPosition.y / (_cellHeight);
    NSInteger column = touchPosition.x / (_cellWidth);
    
    return _gridArray[row][column];
}

-(void) evolveStep
{
    //update each Creature's neighbor count
    [self countNeighbors];
    
    //update each Creature's state
    [self updateCreatures];
    
    //update the generation so the label's text will display the correct generation
    _generation++;
}

-(void) countNeighbors
{
    for (int i=0; i< [_gridArray count]; i++)
    {
        for (int j =0; j< [_gridArray count]; j++)
        {
            Creature *currentCreature = _gridArray[i][j];
            currentCreature.livingNeighbors = 0;
            
            for (int k = (i-1); k <= (i+1); k++)
            {
                for(int l = (j-1); l <= (j+1); l++)
                {
                    BOOL isIndexValid;
                    isIndexValid = [self isIndexValidForX:k andY:l];
                    
                    if(!((k ==i ) && (l == j)) && isIndexValid)
                    {
                        Creature *neighbor = _gridArray[k][l];
                        if (neighbor.isAlive)
                        {
                            currentCreature.livingNeighbors+=1;
                        }
                    }
                }
            }
        }
    }
}

-(void) updateCreatures
{
    for (int i=0; i<[_gridArray count]; i++)
    {
        for (int j=0; j<[_gridArray count]; j++)
        {
            Creature *currentCreature = _gridArray[i][j];
            if (currentCreature.livingNeighbors <=1 || currentCreature.livingNeighbors >=4)
            {
                currentCreature.isAlive = NO;
            }
            else
            {
                currentCreature.isAlive = YES;
            }
        }
    }
}

- (BOOL)isIndexValidForX:(int)x andY:(int)y
{
    BOOL isIndexValid = YES;
    if(x < 0 || y < 0 || x >= GRID_ROWS || y >= GRID_COLUMNS)
    {
        isIndexValid = NO;
    }
    return isIndexValid;
}

@end
