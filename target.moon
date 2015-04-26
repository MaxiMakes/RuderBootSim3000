class Target
  SIZE = 100

  new: =>
    @body = love.physics.newBody(world, 650/2, 650/2, "static")
    --@shape = love.physics.newCircleShape(20)
    @shape = love.physics.newRectangleShape(50, 70)
    --@shape = love.physics.newPolygonShape(-50,-50,50,25,50,-50)
    @fixture = love.physics.newFixture(@body, @shape, 1)


