// Copyright (c) 2015 Robert Pyzalski
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        //physicsWorld.gravity = CGVectorMake(0.0, -0.2)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            //squareBits(touch.locationInNode(self))
            explodeBits(touch.locationInNode(self))
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        self.enumerateChildNodesWithName("Point") {
            node, stop in
            if (node.position.y < 0) {
                node.removeFromParent()
            }
        }
    }
    
    func squareBits(location: CGPoint) {
        for x in -5...5 {
            for y in -5...5 {
                let point = SKShapeNode(rectOfSize: CGSizeMake(0.5, 0.5))
                point.name = "Point"
                point.strokeColor = SKColor.whiteColor()
                point.position = CGPointMake(location.x + CGFloat(x * 5), location.y + CGFloat(y * 5))
                
                self.addChild(point)
            }
        }
    }
    
    func explodeBits(location: CGPoint) {
        for _ in 1...100 {
            let point = SKShapeNode(rectOfSize: CGSizeMake(0.5, 0.5))
            point.name = "Point"
            point.strokeColor = SKColor.whiteColor()
            point.position = location
            
            let pointPhysics = SKPhysicsBody(rectangleOfSize: CGSizeMake(1, 1))
            point.physicsBody = pointPhysics
            point.physicsBody?.mass = CGFloat(0.1)
            
            self.addChild(point)
            point.physicsBody?.applyImpulse(CGVectorMake(randomInRange(-10, 10), randomInRange(50, 60)))
        }
    }
    
    func randomInRange(randomMin: Float, _ randomMax: Float) -> CGFloat {
        let randomRange = randomMax - randomMin
        return CGFloat(randomRange * (Float(arc4random()) / Float(UINT32_MAX)) + randomMin)
    }
}
