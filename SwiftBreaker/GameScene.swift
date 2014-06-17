//
//  GameScene.swift
//  SwiftBreaker
//
//  Created by Jake Januzelli on 6/9/14.
//  Copyright (c) 2014 Jake Januzelli. All rights reserved.
//

import SpriteKit

extension UIColor {
    class func randomColor() -> UIColor {
        let colors: Dictionary<UInt32, UIColor> = [
            1: UIColor.purpleColor(),
            2: UIColor.greenColor(),
            3: UIColor.redColor(),
            4: UIColor.orangeColor(),
            5: UIColor.grayColor(),
            6: UIColor.blueColor()
        ]
        let randomIndex = arc4random_uniform(6) + 1
        return colors[randomIndex]!
    }
}

class GameScene: SKScene {
    
    init(size: CGSize) {
        super.init(size: size)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        let edges = SKNode()
        edges.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        edges.physicsBody.friction = 0
        edges.physicsBody.restitution = 1
        addChild(edges)
        
        // I should probably make an extension with easy SKNode factory methods to get rid of this bloody boilerplate
        
        let brick = SKSpriteNode(color: UIColor.randomColor(), size: CGSize(width: 80, height: 50))
        brick.position = CGPoint(x: CGRectGetMidX(self.frame) , y: CGRectGetMidY(self.frame))
        brick.name = "Brick"
        brick.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 80, height: 50))
        brick.physicsBody.friction = 0
        brick.physicsBody.restitution = 1
        brick.physicsBody.dynamic = false
        addChild(brick)
        
        let paddle = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 60, height: 10))
        paddle.position = CGPoint(x: CGRectGetMidX(self.frame), y: 100)
        paddle.name = "Paddle"
        paddle.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 60, height: 10))
        paddle.physicsBody.friction = 0
        paddle.physicsBody.restitution = 1
        paddle.physicsBody.dynamic = false
        addChild(paddle)
        
        let ball = SKShapeNode(circleOfRadius: 5)
        ball.fillColor = UIColor.whiteColor()
        ball.position = CGPoint(x: CGRectGetMidX(self.frame), y: 110)
        ball.name = "Ball"
        
        // these properties are neccesary for the ball to go forever
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 5)
        ball.physicsBody.mass = 1
        ball.physicsBody.friction = 0
        ball.physicsBody.restitution = 1
        ball.physicsBody.linearDamping = 0
        ball.physicsBody.usesPreciseCollisionDetection = true
        
        addChild(ball)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func start() {
        let ball = childNodeWithName("Ball")
        ball.physicsBody.applyImpulse(CGVector(dx: 200, dy: 200))
    }
}
