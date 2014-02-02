require "class"

Sprite = class(function(s,x,y)
	s.x=x
	s.y=y
	
   s.img=love.graphics.newImage( "nerdy.png" )
   s.img:setFilter("nearest", "linear")
   
   s.currentFrame=2
	
	s.frameQuad = {}
   
	i=1
	for y=0, 3 do
		for x=0, 2 do
			s.frameQuad[i] = love.graphics.newQuad(x*34,y*46, 34, 46,s.img:getWidth(), s.img:getHeight())
			i=i+1
		end
	end
	
	
	
end)

function Sprite:setPos(nx,ny)
	self.x=nx
	self.y=ny
end

function Sprite:move(dx,dy)
	self.x=self.x+dx
	self.y=self.y+dy
end

function Sprite:setFrame(f)
	self.currentFrame=f
end


function Sprite:draw()

    love.graphics.draw(self.img, self.frameQuad[self.currentFrame], self.x, self.y)

end
