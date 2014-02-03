require "class"

Map = class(function(m,width,height)
	m.width=width
	m.height=height
	m.layers=2
	m.tiles = {}
	m.tileOccupied = {}
   
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
	
	
	
	--[===[
   m.layerBatch ={}
   
	for y=1,height do
		c=0
		for x=1,width do
				if(m.tiles[x][y][2]>=0) then
					c=c+1
				end
		end
		
		m.layerBatch[y]=love.graphics.newSpriteBatch(m.tileset,c)
		for x=1,width do
			if(m.tiles[x][y][2]>=0) then
				m.layerBatch[y]:add(m.tileQuads[m.tiles[x][y][2]],(x-1)*60, (y-1)*28)
			end
		end
	end--]===]
   
end)

function Map:init()
  
  for x=1,self.width do
    self.tiles[x] = {}
    self.tileOccupied[x] = {}
    for y=1,self.height do
      self.tiles[x][y] = {}
      self.tileOccupied[x][y] = 0
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

function Map:setOccupied(pixelX,pixelY,v)
	x=math.floor((pixelX-100)/60)
	y=math.floor((pixelY-100)/28)

	if(x>=0 and y>=0 and x < self.width and y < self.height) then
		self.tileOccupied[x+1][y+1]=v
	end
end

function Map:drawGround()
  love.graphics.draw(self.groundBatch,100,100)
end

function Map:drawLayerRow(y)

	for x=1,self.width do
		if(y==1 or self.tileOccupied[x][y-1]==0) then
			love.graphics.setColor(255,255, 255, 255)
		else
			love.graphics.setColor(255,255, 255, 155)
		end
	
		if(self.tiles[x][y][2]>=0) then
			love.graphics.draw(self.tileset,self.tileQuads[self.tiles[x][y][2]],(x-1)*60+100, (y-1)*28+88)
		end
	end
	love.graphics.setColor(255,255, 255, 255)
end


