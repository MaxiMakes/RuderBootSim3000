export world
pi = math.atan(1)*4
particleRadius= 0.1
r=  10
dens= 10000000

class wave
    parts: {}

    new: (x, y,gap1=1, gap2=2, size=10, speed=10)=>
        @gap1 = gap1
        @gap2 = gap2
        @parts= {}
        alpha = math.pi*2/size --360 for art
        @deltaGap= gap2 - gap1
        for i = 1+gap1, size+gap1
            if i >= @deltaGap
                dy = math.sin(alpha*i)*r
                dx = math.cos(alpha*i)*r
                part = {}
                part.body= love.physics.newBody( world, x+dx, y+dy, "dynamic" )
                part.shape= love.physics.newCircleShape(particleRadius)
                part.fix= love.physics.newFixture(part.body, part.shape, dens)
                part.body\applyLinearImpulse(dx*1000, dy*1000)
                table.insert(@parts, part)

    getAllPoints: =>
        points = {}
        for i,v in ipairs(@parts)
            table.insert(points, v.body\getX!)
            table.insert(points, v.body\getY!)
        return points
    update: (dt)=>
        return
    draw: =>
        for i, v in ipairs(@parts)
            love.graphics.circle("fill",v.body\getX!, v.body\getY!, particleRadius)
        love.graphics.line(@\getAllPoints!)
        return
