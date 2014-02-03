require "map"
require "sprite"

local screenWidth,screenHeight
local map

function love.load()
	screenWidth=800
	screenHeight=600
	love.window.setMode(screenWidth, screenHeight,{vsync=false})
	love.graphics.setFont(love.graphics.newFont(12))
	
	map = Map(10,10)
	nerdy=Sprite(map,120,280)
	
end

function love.keypressed(key)
   if key == "escape" then
      love.event.quit()
   end
end

function love.update(dt)
 if love.keyboard.isDown("up")  then
    nerdy:move(0,-100* dt)
    nerdy:setFrame(1)
  end
  if love.keyboard.isDown("down")  then
    nerdy:move(0,100* dt)
    nerdy:setFrame(7)
  end
  if love.keyboard.isDown("left")  then
    nerdy:move(-100* dt,0)
    nerdy:setFrame(10)
  end
  if love.keyboard.isDown("right")  then
    nerdy:move(100* dt,0)
    nerdy:setFrame(4)
  end 
end

function love.draw()
	map:drawGround()
	
	
	for y=1,10 do
		if (math.floor((nerdy.y+46-100)/ 28) == (y-1) ) then
			nerdy:draw()
		end
		
		map:drawLayerRow(y)
	end

	love.graphics.setColor(255,128, 128, 255)
  love.graphics.print(love.timer.getFPS(), 10, 20)
	love.graphics.setColor(255,255, 255, 255)
end
