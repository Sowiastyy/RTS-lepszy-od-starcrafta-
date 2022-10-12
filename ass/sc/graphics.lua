love.graphics.setDefaultFilter("nearest", "nearest")
love.graphics.setBackgroundColor(0.2, 0.15, 0.65)

local d = "ass/gh/"

classes         = love.graphics.newImage(d.."characters.png")
dot             = love.graphics.newImage(d.."dot.png")
qwer            = love.graphics.newImage(d.."qwer.png")
grass           = love.graphics.newImage(d.."xddd.png")
qwerPress       = love.graphics.newImage(d.."qwerPressed.png")
gold            = love.graphics.newImage(d.."gold.png")
lock            = love.graphics.newImage(d.."lock.png")
fireball        = love.graphics.newImage(d.."fireball.png")
lightning        = love.graphics.newImage(d.."lightning.png")
spells          = love.graphics.newImage(d.."spells.png")
upgrade         = love.graphics.newImage(d.."upgrade_phase.png")
castle_src         = love.graphics.newImage(d.."castle.png")



local i=1
qwer_quad = {}
while i<=4 do
    qwer_quad[i] = love.graphics.newQuad((i-1)*22, 0, 22, 15, 88, 15)
    i=i+1
end

local i=1
class_quad = {}
while i<=8 do
    class_quad[i] = love.graphics.newQuad((i-1)*32, 0, 32, 32, 256, 32)
    i=i+1
end

local i=1
spells_quad = {}
while i<=2 do
    spells_quad[i] = love.graphics.newQuad((i-1)*44, 0, 44, 40, 88, 40)
    i=i+1
end

local i=1
up_quad = {}
while i<=4 do
    local j=1
    up_quad[i] = {}
    while j<=3 do
        up_quad[i][j] = love.graphics.newQuad((j-1)*16, (i-1)*12, 16, 12, 48, 48)
        j=j+1
    end
    i=i+1
end
function drawHP(x, y, width, mh, h)
    love.graphics.rectangle("line", x, y, width, 2)
    love.graphics.setColor(0.1, 0.1, 0.1)
    love.graphics.rectangle("fill", x, y, width, 2)
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", x, y, width/(mh/h), 2)
    love.graphics.setColor(1, 1, 1)
end
return