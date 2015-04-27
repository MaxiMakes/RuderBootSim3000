export world
wave = require 'wave'
waveList ={}

[[

<<<<<<< HEAD
=======
love.load= ->
    world = love.physics.newWorld( 0, 0, true)
    return


love.draw= ->
    for i,v in ipairs(waveList)
        print("main draw")
        v\draw!
    return


love.update= (dt)->
    world\update(dt)
>>>>>>> 792fb09c6a208af33b794b9b0af90faf78a15c2b
love.keypressed= (key)->
   if key == "a" then
       --    new: (x, y,gap1=1, gap2=2, size=10, speed=10)=>
      s = math.random(50, 150)
      newWave= wave(200, 200, 400)
      table.insert(waveList, newWave)
]]
Boat = require('boat')

SPAWNTIME = 5
nextspawn = 3

math.randomseed(os.time())

local boat
boxes = {}
love.load = ->
  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 0, true)

  boat = Boat!

  w,h = love.window.getDimensions!
  s = 3
  [[
  for i=1,1000
    b = {}
    b.body = love.physics.newBody(world, math.random(-s*w,s*w), math.random(-s*h,s*h), "dynamic")
    b.shape = love.physics.newRectangleShape(30, 30)
    b.fixture = love.physics.newFixture(b.body, b.shape, 1)
    b.body\setMass(5)
    table.insert(boxes,b)
  ]]

love.update = (dt) ->
  boat\update(dt)
  world\update(dt)
  nextspawn += dt
  
  if nextspawn > SPAWNTIME
    print("Spawn")
    w,h = love.window.getDimensions!
    newWave= wave(math.random(w), math.random(h), 400)
    table.insert(waveList, newWave)
    nextspawn = 0

love.draw = ->


  x,y = boat.body\getPosition!
  w,h = love.window.getDimensions!
  love.graphics.translate(-x+w/2,-y+h/2)
  for i,v in ipairs(waveList)
      v\draw!
  love.graphics.setColor(200,150,0)
  for i,v in ipairs(boxes)
    if i%500 == 0
      love.graphics.setColor(200,0,0)
    love.graphics.polygon("fill", v.body\getWorldPoints(v.shape\getPoints()))
    love.graphics.setColor(200,150,0)
  love.graphics.setColor(255,255,255)
  boat\draw!
  love.graphics.origin!

  return

love.keypressed = (key) ->
  if key == "escape"
    love.event.quit!
