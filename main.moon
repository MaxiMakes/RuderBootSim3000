export world
world = nil
wave = require 'wave'
waveList ={}


love.load= ->
    world = love.physics.newWorld( 0, 0, true)
    return


love.draw= ->
    for i,v in ipairs(waveList)
        v\draw!
    return


love.update= (dt)->
    world\update(dt)
love.keypressed= (key)->
   if key == "a" then
       --    new: (x, y,gap1=1, gap2=2, size=10, speed=10)=>

      newWave= wave(200, 200, 100, 400, 400)
      table.insert(waveList, newWave)
