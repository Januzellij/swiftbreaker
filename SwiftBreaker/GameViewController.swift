//
//  GameViewController.swift
//  SwiftBreaker
//
//  Created by Jake Januzelli on 6/9/14.
//  Copyright (c) 2014 Jake Januzelli. All rights reserved.
//

import UIKit
import SpriteKit
import CoreMotion

class GameViewController: UIViewController {
    
    let motionManager = CMMotionManager()
    var scene: GameScene!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.scene = GameScene(size: self.view.bounds.size)
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill

        let skView = self.view as SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        skView.presentScene(scene)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        motionManager.deviceMotionUpdateInterval = 1/60
        if motionManager.deviceMotionAvailable {
            motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: {data, error in
                let roll = data.attitude.roll
                let paddle = self.scene.childNodeWithName("Paddle")
                let paddleMove = SKAction.moveToX(self.findXforRotation(roll), duration: 1/60)
                paddle.runAction(paddleMove)
            } )
        }
        
        //NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "log", userInfo: nil, repeats: true)
    }

    override func shouldAutorotate() -> Bool {
        return false
    }

    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.toRaw())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    func log() {
        println(scene.childNodeWithName("Brick").frame)
        println(scene.childNodeWithName("Paddle").frame)
        println(self.view.frame)
    }
    
    func findXforRotation(rotation: Double) -> CGFloat {
        // I am extremely proud of this function. It took two days.
        
        // 30 degrees = pi/6 radians
        // -30 degrees = all the way to the left
        // 30 degrees = all the way to the right
        // Maps a rotation from -pi/6 to pi/6 to x value from 0 to screen width
        let floatRotation = CGFloat(rotation)
        let halfRange: CGFloat = CGFloat(M_PI)/6, range: CGFloat = CGFloat(M_PI)/3
        if floatRotation >= halfRange { return self.view.frame.width }
        else if floatRotation <= -halfRange { return 0 }
        else {
            // aligns negative to postive radian range with 0 to positive screen width range
            let scaledRotation = floatRotation + halfRange
            let widthFraction = scaledRotation / range
            return widthFraction * self.view.frame.width
        }
    }
}
