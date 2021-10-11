import Foundation


//CREATING AN ARRAY FOR REFACTORING OF THE GAME'S BARRIERS AND TARGETS
var barriers: [Shape] = []
var targets: [Shape] = []

//ESTABLISHES THAT THE CONSTANT "CIRCLE" IS AN OVAL AND DETERMINES ITS SIZE
let ball = OvalShape(width: 40, height: 40)


//AS PART OF CREATING THE FUNNEL - FIRST ESTABLLISHES AN ARRAY THAT SETS OUT ITS DIMENSIONS
let funnelPoints = [
    Point(x: 0, y: 50),
    Point(x: 80, y: 50),
    Point(x: 60, y: 0),
    Point(x: 20, y: 0)
]


//CREATES THE SHAPE "FUNNEL" USING THE DIMENSIONS FROM THE funnelPoints ARRAY
let funnel = PolygonShape(points:
   funnelPoints)


//CREATES THE DIAMOND TARGET
let targetPoints = [
    Point(x: 10, y: 0),
    Point(x: 0, y: 10),
    Point(x: 10, y: 20),
    Point(x: 20, y: 10)
]

let target = PolygonShape(points:
   targetPoints)


/*
The setup() function is called once when the app launches. Without it, your app won't compile.
Use it to set up and start your app.

You can create as many other functions as you want, and declare variables and constants,
at the top level of the file (outside any function). You can't write any other kind of code,
for example if statements and for loops, at the top level; they have to be written inside
of a function.
*/

fileprivate func setupBall() {
    //CAUSES THE BALL TO BEHAVE ACCORDING TO REAL WORLD PHYSICS
    ball.hasPhysics = true
    //SETS INITIAL POSITION OF THE BALL
    ball.position = Point(x: 250, y: 600)
    //ADDS THE BALL (aka THE CIRCLE) TO THE SCENE
    scene.add(ball)
    ball.fillColor = .blue
    ball.onCollision = ballCollided(with:)
    ball.isDraggable = false
    ball.bounciness = 0.6
    scene.trackShape(ball)
    ball.onExitedScene = ballExitedScene
    ball.onTapped = resetGame
}


//THE ORIGINAL FUNCTION FOR THE BARRIERS HAS BEEN MODIFIED AS PART OF THE REFACTORING....
fileprivate func addBarrier(at position: Point, width: Double, height: Double, angle: Double) {
    let barrierPoints = [
        Point(x: 0, y: 0),
        Point(x: 0, y: height),
        Point(x: width, y: height),
        Point(x: width, y: 0)
    ]
    
    let barrier = PolygonShape(points: barrierPoints)
    barriers.append(barrier)
        
    //ADDS BARRIER TO THE SCENE
    barrier.position = position
    //CAUSES THE BARRIER TO BLOCK OTHER OBJECTS
    barrier.hasPhysics = true
    barrier.fillColor = .cyan
    barrier.angle = angle
    scene.add(barrier)
    
    //LOCKS THE BARRIER IN ITS LOCATION
    barrier.isImmobile = true
    //USED FOR GETTING THE COORDINATES OF THE SHAPES TO FEED INTO THE ARRAYS
    scene.onShapeMoved = printPosition(of:)
}

fileprivate func setupFunnel() {
    //ADDS A FUNNEL TO THE SCENE
    funnel.position = Point(x: 200, y:                              scene.height - 25)
    scene.add(funnel)
    funnel.fillColor = .green
    funnel.onTapped = dropBall
    funnel.isDraggable = false
}


//TEMPORARY FUNCTION CREATED TO HELP LOCATE THE TARGETS AND BARRIERS
func printPosition(of shape: Shape) {
    print(shape.position)
}


// HANDLES COLLISIONS BETWEEN THE BALL AND THE TARGETS
func ballCollided(with otherShape: Shape) {
    if otherShape.name != "target" { return }
    otherShape.fillColor = .black
}


//HANDLES WHEN THE BALL LEAVES THE SCREEN AREA
func ballExitedScene() {
    for barrier in barriers {
    barrier.isDraggable = true
    }
}

//CREATES THE TARGETS
func addTarget(at position: Point) {            //pg253
    let targetPoints = [
        Point(x: 0, y: 0),
        Point(x: 0, y: 10),
        Point(x: 10, y: 20),
        Point(x: 20, y: 10)

         ]
    
    let target = PolygonShape(points: targetPoints)
    targets.append(target)
    
    
    //ADDS TARGET TO THE SCENE
    target.position = position
    //CHARACTERISTICS OF TARGET
    target.hasPhysics = true
    target.isImmobile = true
    target.isImpermeable = true
    target.fillColor = .orange
    target.isDraggable = false
    scene.add(target)
    
    //TEMPORARY CODE TO HELP SET LOCATIONS
    scene.onShapeMoved = printPosition(of:)
}


//DROPS THE BALL BY MOVING THE BALL TO THE FUNNEL'S POSITION
func dropBall() {
    ball.position = funnel.position
    ball.stopAllMotion()
    for barrier in barriers {
        barrier.isDraggable = true
    }
}


func resetGame() {
    ball.position = Point(x: 0, y: -80)
}

//LAYS OUT THE COMPONENTS OF THE GAME: BALL, BARRIERS (3), TARGETS(2), FUNNEL(1)
func setup() {
    setupBall()
    //BARRIER IN MIDDLE
    addBarrier(at: Point(x: 200, y: 150),
       width: 80, height: 25, angle: 0)
    //BARRIER ON RIGHT
    addBarrier(at: Point(x:294, y: 216), width: 60, height: 25, angle: 0.2)
    //BARRIER ON LEFT
    addBarrier(at: Point(x:100, y: 216), width: 60, height: 25, angle: -0.2)
    setupFunnel()
    addTarget(at: Point(x: 177, y: 598))
    addTarget(at: Point(x: 349, y: 522))
    addTarget(at: Point(x: 137, y: 393))
     
}




