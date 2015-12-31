setscreen ("graphics:600,500")
View.Set ("offscreenonly")
var redcircle : boolean := true
var greencircle : boolean := true
var yellowcircle : boolean := true
var bluecircle : boolean := true
var redx : int := 500
var greenx : int := 500
var yellowx : int := 500
var bluex : int := 500
var randoms : int
var x : int := 9
const redbutton : int := 88
const greenbutton : int := 56
const yellowbutton : int := 248
const bluebutton : int := 104
var title : int
title := Pic.FileNew ("title 2.jpg")
var background_image : int
background_image := Pic.FileNew ("background.jpg")
var lost : int
lost := Pic.FileNew ("lost page.jpg")

Pic.SetTransparentColor (title, green)

process generateCircles
    loop
	randoms := Rand.Int (-5, 15)
	if redcircle = false and randoms = 1 then
	    redcircle := true
	elsif greencircle = false and randoms = 2 then
	    greencircle := true
	elsif yellowcircle = false and randoms = 3 then
	    yellowcircle := true
	elsif bluecircle = false and randoms = 3 then
	    bluecircle := true
	end if
	delay (25)
    end loop
end generateCircles

process draw
    loop
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
	drawfillbox (63, 0, 5 + 63, 0 + 500, black)
	drawfillbox (188, 0, 5 + 188, 0 + 500, black)
	drawfillbox (313, 0, 5 + 313, 0 + 500, black)
	drawfillbox (438, 0, 5 + 438, 0 + 500, black)
	drawfillbox (563, 0, 5 + 563, 0 + 500, black)
	drawfillbox (0, 60, 0 + 600, 60 + 5, black)
	delay (20)
	View.Update
	Pic.Draw (background_image, 0, 0, 0)
	Pic.Draw (title, 235, 390, picMerge)
	put x
    end loop
end draw

process num1
    loop
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

process goats
    loop
	if redx = 10 and redx >= 0 and redx <= 40 then
	    x := x - 1
	    delay (500)
	end if
	if greenx = 10 and greenx >= 0 and greenx <= 40 then
	    x := x - 1
	    delay (500)
	end if
	if yellowx = 10 and yellowx >= 0 and yellowx <= 40 then
	    x := x - 1
	    delay (500)
	end if
	if bluex = 10 and bluex >= 0 and bluex <= 40 then
	    x := x - 1
	    delay (500)
	end if
    end loop
end goats

process gainpoints
    loop
	if (redx = 10 and redx >= 0 and redx <= 40) or (greenx = 10 and greenx >= 0 and greenx <= 40) or (yellowx = 10 and yellowx >= 0 and yellowx <= 40) or (bluex = 10 and bluex >= 0 and bluex <= 
	    40) then
	    delay (3000)
	    x := x + 1
	end if
	if x <= 0 then
	    loop
		Pic.Draw (lost, 0, 0, 0)
	    end loop
	end if
    end loop
end gainpoints

process hit
    loop
	if redbutton = 58 and redx >= 0 and redx <= 40 then
	    put "skillay"
	end if
    end loop
end hit

fork gainpoints
fork goats
fork generateCircles
fork hit
fork draw
fork num1
fork num2
fork num3
fork num4
