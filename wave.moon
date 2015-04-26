export world
pi = math.atan(1)*4
particleRadius= 0.5
r=  20
dens= 10000000

class wave
    parts: {}

    new: (x, y,size=10)=>
        @gap1 = gap1
        @gap2 = gap2
        @parts= {}
        alpha = math.pi*2/size --360 for art


        for i = 1, size

            dy = math.sin(alpha*i)*r
            dx = math.cos(alpha*i)*r
            rand = math.random(1,4)
            if rand != 4
                gap = true
                print("NO GAP!")
            else
                gap = false
                print("GAP!")
            --if gap == false
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
            print("Wave Draw!")
            love.graphics.circle("fill",v.body\getX!, v.body\getY!, particleRadius)
            --love.graphics.line(@\getAllPoints!)
        return
