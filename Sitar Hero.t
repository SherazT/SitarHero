%Sheraz Tariq
%Sitar Hero
%11/06/14
%The button must be pressed when the appropriate circle hits the horizontal black line on the bottom. You will start with 9 points and lose points when you miss, and regain points over time until you reach 0 and lose.
%Enjoy the music and have fun!

%set dimensions
setscreen ("graphics:600,500")
View.Set ("offscreenonly")

%7 Segment Display------------------------------
%declare pin number values
var pin2 : int := 1
var pin3 : int := 2
var pin4 : int := 4
var pin5 : int := 8
var pin6 : int := 16
var pin7 : int := 32
var pin8 : int := 64
var pin9 : int := 128

%make array of numbers
var number : array 0 .. 9 of int

%set the pin number values for all numbers
number (0) := pin4 + pin8
number (1) := pin4 + pin2 + pin3 + pin8 + pin5 + pin6
number (2) := pin4 + pin7 + pin3
number (3) := pin4 + pin3 + pin5
number (4) := pin4 + pin2 + pin5 + pin6
number (5) := pin4 + pin9 + pin5
number (6) := pin4 + pin9
number (7) := pin4 + pin3 + pin8 + pin5 + pin6
number (8) := pin4
number (9) := pin4 + pin5
%------------------------------------------------

%declare variables and constants
%circle shown or not shown boolean
var redcircle : boolean := true
var greencircle : boolean := true
var yellowcircle : boolean := true
var bluecircle : boolean := true
%start circles at top
var redx : int := 500
var greenx : int := 500
var yellowx : int := 500
var bluex : int := 500
%declare random variable
var randoms : int
%declare the parallelget values for each button
const redbutton : int := 88
const greenbutton : int := 56
const yellowbutton : int := 248
const bluebutton : int := 104
%points are set to 9 at the start
var x : int := 9
%declare title and intitalize
var title : int
title := Pic.FileNew ("title 2.jpg")
%declare background and intitalize
var background_image : int
background_image := Pic.FileNew ("background.jpg")
%declare lost page and intitalize
var lost : int
lost := Pic.FileNew ("lost page.jpg")

%set the title tranparent
Pic.SetTransparentColor (title, green)

%generate circles randomly
process generateCircles
    loop
	%generate number
	randoms := Rand.Int (-5, 15)
	%generate circles based on random number and that they are not visible at the current time
	if redcircle = false and randoms = 1 then
	    redcircle := true
	elsif greencircle = false and randoms = 2 then
	    greencircle := true
	elsif yellowcircle = false and randoms = 3 then
	    yellowcircle := true
	elsif bluecircle = false and randoms = 4 then
	    bluecircle := true
	end if
	delay (25)
    end loop
end generateCircles

%draw everything
process draw
    loop
	%draw the circles
	if redcircle = true then
	    drawfilloval (125, redx, 20, 20, red)
	end if
	if greencircle = true then
	    drawfilloval (250, greenx, 20, 20, green)
	end if
	if yellowcircle = true then
	    drawfilloval (375, yellowx, 20, 20, yellow)
	end if
	if bluecircle = true then
	    drawfilloval (500, bluex, 20, 20, blue)
	end if
	%draw the black bars seperating the circles
	drawfillbox (63, 0, 5 + 63, 0 + 500, black)
	drawfillbox (188, 0, 5 + 188, 0 + 500, black)
	drawfillbox (313, 0, 5 + 313, 0 + 500, black)
	drawfillbox (438, 0, 5 + 438, 0 + 500, black)
	drawfillbox (563, 0, 5 + 563, 0 + 500, black)
	drawfillbox (0, 60, 0 + 600, 60 + 5, black)
	%draw a black circle in the place of circle when clicked at right time
	if parallelget = redbutton and redx >= 0 and redx <= 40 then
	    drawfilloval (125, redx, 20, 20, black)
	end if
	if parallelget = greenbutton and greenx >= 0 and greenx <= 40 then
	    drawfilloval (250, greenx, 20, 20, black)
	end if
	if parallelget = yellowbutton and yellowx >= 0 and yellowx <= 40 then
	    drawfilloval (375, yellowx, 20, 20, black)
	end if
	if parallelget = bluebutton and bluex >= 0 and bluex <= 40 then
	    drawfilloval (500, bluex, 20, 20, black)
	end if
	delay (20)
	%refresh screen
	View.Update
	%draw background and title
	Pic.Draw (background_image, 0, 0, 0)
	Pic.Draw (title, 235, 390, picMerge)
	%output score onto 7 segment display
	if x > -1 and x < 10 then
	    parallelput (number (x))
	end if
    end loop
end draw

process num1
    loop
	%move the red circle down by increments of 5
	if redcircle = true then
	    loop
		for decreasing q : 500 .. -10 by 5
		    redx := q
		    delay (20)
		end for
		redcircle := false
		exit %when redx = -10
	    end loop
	end if
    end loop
end num1

process num2
    loop
	%move the green circle down by increments of 5
	if greencircle = true then
	    loop
		for decreasing q : 500 .. -10 by 5
		    greenx := q
		    delay (20)
		end for
		greencircle := false
		exit % when greenx = -10
	    end loop
	end if
    end loop
end num2

process num3
    loop
	if yellowcircle = true then
	    %move the yellow circle down by increments of 5
	    loop
		for decreasing q : 500 .. -10 by 5
		    yellowx := q
		    delay (20)
		end for
		yellowcircle := false
		exit % when yellowx = -10
	    end loop
	end if
    end loop
end num3

process num4
    loop
	if bluecircle = true then
	    loop
		%move the blue circle down by increments of 5
		for decreasing q : 500 .. -10 by 5
		    bluex := q
		    delay (20)
		end for
		bluecircle := false
		exit % when bluex = -10
	    end loop
	end if
    end loop
end num4

process DoMusic
    %play song
    loop
	Music.PlayFile ("song.mp3")
    end loop
end DoMusic

process hitpoints
    loop
	%reduce points when ball is missed
	%when ball reaches bottom
	if redx = 10 and redx >= 0 and redx <= 40 then
	    x := x - 1
	    %delay 500 so that only 1 score is subtracted
	    delay (500)
	end if
	if greenx = 10 and greenx >= 0 and greenx <= 40 then
	    x := x - 1
	    %delay 500 so that only 1 score is subtracted
	    delay (500)
	end if
	if yellowx = 10 and yellowx >= 0 and yellowx <= 40 then
	    x := x - 1
	    %delay 500 so that only 1 score is subtracted
	    delay (500)
	end if
	if bluex = 10 and bluex >= 0 and bluex <= 40 then
	    x := x - 1
	    %delay 500 so that only 1 score is subtracted
	    delay (500)
	end if
    end loop
end hitpoints

%regain points when not too many circles are missed
process gainpoints
    loop
	%if the cirles have been hit atleast once then start the process to regain the lost points
	if (redx = 10 and redx >= 0 and redx <= 40) or (greenx = 10 and greenx >= 0 and greenx <= 40) or (yellowx = 10 and yellowx >= 0 and yellowx <= 40) or (bluex = 10 and bluex >= 0 and bluex <=
		40) then
	    %delay 2500 so that points are regained accordingly
	    delay (2500)
	    %if the game has not ended yet then regain points
	    if x not= 0 then
	    %regain 2 points as much time has passed, in order to keep the game reasonable
		x := x + 2
	    end if
	end if
	%if game is lost then draw the lost screen
	if x <= 0 then
	    loop
		Pic.Draw (lost, 0, 0, 0)
	    end loop
	end if
    end loop
end gainpoints

%fork(call) all of the processes
fork generateCircles
fork gainpoints
fork hitpoints
fork draw
fork num1
fork num2
fork num3
fork num4
fork DoMusic
loop
    %when game is lost stop the music
    if x = 0 then
	Music.PlayFileStop
    end if
end loop
