//: # Gig Poster 5
//: The following two statements are required to make the playground run. Please do not remove.
import Cocoa
import PlaygroundSupport

/*:
 Each image is exactly 400 pixels wide by 600 pixels tall.
 
 Your goal is to precisely reproduce this image:
 
 ![talking-heads-no-grid](talking-heads-no-grid.png "Talking Heads")
 ![talking-heads-with-grid](talking-heads-with-grid.png "Talking Heads")
 
 By precisely reproducing this image, you will demonstrate your understanding of:
 
 * sequence (order of statements in a program)
 * conditionals (making decisions with ``if`` statements)
 * iteration (use of loops to repeat statements)
 * arrays (a data structure that stores related pieces of information)
 * use of arithmetic operators in expressions
 
 You may use the color constants created below to obtain the correct colors.
 
 Remember that you can refer to the [Canvas class documentation](https://www.russellgordon.ca/canvasgraphics/documentation/classes/canvas), as needed.
 
 ## Use Source Control
 
 To create evidence that supports your case for exceeding expectations for thread 3:
 
 * You *must* commit and push regularly ... *not* just at the end of this task.
 
 * You *must* complete your work prior to 3:30 PM on Wednesday, February 12, 2020.
 
 Good luck! You've got this! 👊🏻👊🏼👊🏽👊🏾👊🏿
 */

// Create a new canvas
let canvas = Canvas(width: 400, height: 600)

// COLORS
let deepOrange = Color(hue: 8, saturation: 78, brightness: 93, alpha: 100)
let offWhite = Color(hue: 81, saturation: 5, brightness: 88, alpha: 100)
let brightYellow = Color(hue: 46, saturation: 71, brightness: 98, alpha: 100)

// Begin your solution here...
canvas.fillColor = deepOrange
canvas.drawRectangle(at: Point(x:0,y:0), width: 400, height: 600)

//Add triangles
for x in 0...8 {
    for y in 0...8 {
        var triangles:[Point] = []
        triangles.append(Point(x:44.44*Double(x),y:200.00+44.44*Double(y)))
        triangles.append(Point(x:44.44*Double(x)+44.44,y:200.00+44.44*Double(y)))
        triangles.append(Point(x:44.44*Double(x)+44.44,y:200.00+44.44*Double(y)+44.44))
        canvas.drawShapesWithBorders=false
        if x>=y {
            canvas.fillColor = brightYellow
        }else{
            canvas.fillColor = offWhite
        }
        canvas.drawCustomShape(with: triangles)
        
    }
}
//Add text
canvas.textColor = offWhite
//Title
canvas.drawText(message: "taking heads", at: Point(x:20,y:140), size: 42)

canvas.drawText(message: "friday, saturday, sunday", at: Point(x:20,y:30), size: 8)
canvas.drawText(message: "september 12, 13, 14, 1975", at: Point(x:20,y:15), size: 8)
canvas.drawText(message: "at cbgb and omfug", at: Point(x:150,y:30), size: 8)
canvas.drawText(message: "315 bowery, new york city", at: Point(x:150,y:15), size: 8)
canvas.drawText(message: "also appearing:", at: Point(x:280,y:30), size: 8)
canvas.drawText(message: "from brooklyn, the shirts", at: Point(x:280,y:15), size: 8)





////Last, draw a grid for referennce
//for y in stride(from: 0, through: 600, by: 50){
//    canvas.drawLine(from: Point(x:0,y:y), to: Point(x:400,y:y))
//}
//for x in stride(from: 0, through: 400, by: 50){
//    canvas.drawLine(from: Point(x: x, y: 0), to: Point(x: x, y: 600))
//}

/*:
 ## Use Source Control
 
 To create evidence that supports your case for exceeding expectations for thread 3:
 
 * You *must* commit and push regularly ... *not* just at the end of this task.
 
 * You *must* complete your work prior to 3:30 PM on Wednesday, February 12, 2020.
 
 
 ## Template code
 The code below is necessary to see results in the Assistant Editor at right. Please do not remove.
 */
PlaygroundPage.current.liveView = canvas

