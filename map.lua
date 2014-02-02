require "class"

Map = class(function(m,width,height)
	m.width=width
	m.height=height
	m.layers=2
	m.tiles = {}
   
   m:init()
   
   m.tileset=love.graphics.newImage( "summer.png" )
   m.tileset:setFilter("nearest", "linear")
   
   m.tileQuads = {}
   
	for i=0, 3 do
		m.tileQuads[i] = love.graphics.newQuad(i*60,0, 60, 40,m.tileset:getWidth(), m.tileset:getHeight())
   end
   
   
   m.groundBatch = love.graphics.newSpriteBatch(m.tileset, width*height)
   
	for x=1,width do
		for y=1,height do
			m.groundBatch:add(m.tileQuads[m.tiles[x][y][1]],(x-1)*60, (y-1)*28)
		end
	end
	
	c=0
	for x=1,width do
		for y=1,height do
			if(m.tiles[x][y][2]>=0) then
				c=c+1
			end
		end
	end
	
	
   m.layerBatch = love.graphics.newSpriteBatch(m.tileset,c)
   
   for x=1,width do
		for y=1,height do
			if(m.tiles[x][y][2]>=0) then
				m.layerBatch:add(m.tileQuads[m.tiles[x][y][2]],(x-1)*60, (y-1)*28)
			end
		end
	end
   
end)

function Map:init()
  
  for x=1,self.width do
    self.tiles[x] = {}
    for y=1,self.height do
      self.tiles[x][y] = {}
		for l=1,self.layers do
			if(l==1) then
				self.tiles[x][y][l]=math.random(0,2)
			else
				if(math.random(0,100)>50) then
					self.tiles[x][y][l]=-1
				else
					self.tiles[x][y][l]=3
				end
			end
				
		end
    end
  end
end

function Map:getTile(x,y,l)
	return self.tiles[x][y][l]
end

function Map:draw()
  love.graphics.draw(self.groundBatch,100,100,0,1,1)
  love.graphics.draw(self.layerBatch,100,88,0,1,1)
end


