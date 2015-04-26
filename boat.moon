niceatan = (y,x) ->
  a = math.atan2(y,x)
  if a < 0
    a = -a
  else
    a = math.pi + math.pi - a
  return a

niceAngle = (a) ->
  if a > 2*math.pi or a <0
    a = a%(2*math.pi)
  return a

between = (a,b,c) ->
  return (a >= c and c <= b) or (a <= c and c >= b )

class Boat
  SPEED = 1000
  ROWSIZE = 50

  new: =>
    @body = love.physics.newBody(world, 650/2, 650/2, "dynamic")
    --@shape = love.physics.newCircleShape(20)
    @shape = love.physics.newRectangleShape(50, 70)
    --@shape = love.physics.newPolygonShape(-50,-50,50,25,50,-50)
    @fixture = love.physics.newFixture(@body, @shape, 1)

    @body\setLinearDamping(1)
    @body\setAngularDamping(1)
    
    @joystick = love.joystick.getJoysticks![1]
    assert(@joystick, "no joystick found")

    @rowleft = {0,0}
    @rowright = {0,0}

  update: (dt) =>
    ax,ay,_,ax2,ay2 = @joystick\getAxes!
    @\moveRow(dt,1,ax,ay)
    @\moveRow(dt,2,ax2,ay2)
    --@rowleft[1], @rowleft[2] = ax,ay
    --@rowright[1], @rowright[2] = ax2,ay2
    --@body\applyForce(SPEED*ax*dt,SPEED*ay*dt)

  draw: =>
    bx,by = @body\getX!, @body\getY!
    --love.graphics.circle("fill", @body\getX(), @body\getY(), @shape\getRadius())
    love.graphics.polygon("fill", @body\getWorldPoints(@shape\getPoints()))
    @drawRow(@rowleft)
    @drawRow(@rowright)

  moveRow: (dt,rown,x,y) =>
    a = niceatan(y,x)
    bd = niceAngle(@body\getAngle!)

    local row,d,l
    if rown == 1 then
      row = @rowleft
      d = 1
      if x < 0 then
        l = math.sqrt(math.pow(x,2) + math.pow(y,2))
      else
        l = 0
    elseif rown == 2 then
      row = @rowright
      d = -1
      if x > 0
        l = math.sqrt(math.pow(x,2) + math.pow(y,2))
      else
        l = 0

    mod = (a, n) -> a - math.floor(a/n) * n
    da = row[1] - a
    da = mod((da + math.pi), 2*math.pi) - math.pi
    da = da

    c = SPEED*da*l
    fpi = math.pi/2
    --@body\applyForce(@body\getLocalVector(0,SPEED*da*l))
    if row == @rowright
      @body\applyForce(-math.cos(bd+fpi)*c, -math.sin(bd+fpi)*c)
      @body\applyTorque(5000*da*l*d)
    else
      @body\applyForce(math.cos(bd+fpi)*c, math.sin(bd+fpi)*c)
      @body\applyTorque(-5000*da*l*d)
    
    row[1],row[2] = a,l

  drawRow: (row) =>
    bx,by = @body\getX!, @body\getY!
    bd = @body\getAngle!
    --a = math.atan2(row[2],row[1])
    --l = math.min(2,1/math.sqrt(math.pow(row[1],2) + math.pow(row[2],2)))
    a,l = row[1],row[2]
    love.graphics.line(bx,by,bx+ ROWSIZE*l*math.cos(a-bd), by-ROWSIZE*l*math.sin(a-bd))


return Boat
