//
//  Player.m
//  Jerboable
//
//  Created by Kevin Lunden on 11/29/20.
//  Copyright (c) 2020 Razeware, LLC. All rights reserved.
//

#import "Player.h"
//1
#import "SKTUtils.h"

@implementation Player

- (instancetype)initWithImageNamed:(NSString *)name {
  if (self == [super initWithImageNamed:name]) {
    self.velocity = CGPointMake(0.0, 0.0);
  }
  return self;
}

- (void)update:(NSTimeInterval)delta
{
  CGPoint gravity = CGPointMake(0.0, -450.0);
  CGPoint gravityStep = CGPointMultiplyScalar(gravity, delta);
  CGPoint forwardMove = CGPointMake(800.0, 0.0);
  CGPoint forwardMoveStep = CGPointMultiplyScalar(forwardMove, delta);

  self.velocity = CGPointAdd(self.velocity, gravityStep);
  self.velocity = CGPointMake(self.velocity.x * 0.9, self.velocity.y);

    CGPoint jumpForce = CGPointMake(0.0, 310.0);
    float jumpCutoff = 150.0;

    //handles jumping
    if (self.mightAsWellJump && self.onGround) {
        self.velocity = CGPointAdd(self.velocity, jumpForce);
        //Absolutely crucial to have arcade jumpy noises
        [self runAction:[SKAction playSoundFileNamed:@"jumpy.wav" waitForCompletion:NO]];
    } else if (!self.mightAsWellJump && self.velocity.y > jumpCutoff) {
        self.velocity = CGPointMake(self.velocity.x, jumpCutoff);
    }
    
    //Handles movement behavior
  if (self.forwardMarch) {
    self.velocity = CGPointAdd(self.velocity, forwardMoveStep);
  }
  CGPoint minMovement = CGPointMake(0.0, -450);
  CGPoint maxMovement = CGPointMake(120.0, 250.0);
  self.velocity = CGPointMake(Clamp(self.velocity.x, minMovement.x, maxMovement.x), Clamp(self.velocity.y, minMovement.y, maxMovement.y));
  
  CGPoint velocityStep = CGPointMultiplyScalar(self.velocity, delta);
  
  self.desiredPosition = CGPointAdd(self.position, velocityStep);
}



- (CGRect)collisionBoundingBox {
  CGRect boundingBox = CGRectInset(self.frame, 2, 0);
  CGPoint diff = CGPointSubtract(self.desiredPosition, self.position);
  return CGRectOffset(boundingBox, diff.x, diff.y);
}

@end


