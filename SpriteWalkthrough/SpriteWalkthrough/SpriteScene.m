//
//  SpriteScene.m
//  SpriteWalkthrough
//
//  Created by Michael T on 2014-10-30.
//  Copyright (c) 2014 Intense Noodles. All rights reserved.
//

#import "SpriteScene.h"

@interface SpriteScene ()
@property BOOL contentcreated;
@end

@implementation SpriteScene

-(void)didMoveToView:(SKView *)view {
    if (!self.contentcreated){
        [self createscenecontent];
        self.contentcreated = YES;
    }
}

-(void)createscenecontent {
    self.backgroundColor = [SKColor blueColor];
    self.scaleMode = SKSceneScaleModeAspectFill;
    [self addChild:[self newspritenode]];
}

-(SKLabelNode*)newspritenode {
    SKLabelNode* node = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    node.text = @"hello y'all";
    node.fontSize = 42;
    node.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    return node;
}

@end
