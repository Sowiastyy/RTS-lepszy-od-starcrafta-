function love:load()
    require 'ass/sc/graphics'
    class_data = require 'ass/sc/troop_data'
    troop = require 'ass/sc/troop'
    require 'ass/sc/im'
    require 'ass/sc/ti'
    require 'ass/sc/spells/sl'
    require 'ass/sc/castle'
    castle1 = NewCastle(1, 0, 0, 350)
    castle2 = NewCastle(-1, 900, 0, 350)
    gd=1
    win = love.graphics.newImage("ass/gh/epicwygrana.png")
    camera = require 'ass/sc/camera'
    lvl =1
    xp = 1
    xp_next = lvl*10
    score=10
    skillP = 0
    cdEnemy =  4
    difficulty = 3
end
function ToRoman(number)
    if number==0 then return "-" end
    local roman_number = ""
    local d = number
    if d>=5 then
        roman_number=roman_number.."V"
        d=d-5
    end
    while d>0 do
        roman_number = roman_number.."I"
        d=d-1
    end
    if roman_number=="IIII" then
        return "IV"
    end
    return roman_number
end
function love.update(dt)
    troops_update()
    --Update cooldowns
    local i = 1
    while i<=12 do
            cd[i] =  cd[i] - dt
            i=i+1
    end

    local i = 1
    while troops[i] do
        troops[i].cd =troops[i].cd - dt
        troops[i].stunTime=troops[i].stunTime-dt
        i=i+1
    end

    cdEnemy = cdEnemy - dt
    if troop_count-p_troops<p_troops then
        cdEnemy = cdEnemy - p_troops-(troop_count-p_troops)
    end
    gd = gd+0.05+(upg[1]*0.015)

    if cdEnemy<0 then
        troop_create(love.math.random(lvl), -1)
        troops[troop_count].x = 900
        troops[troop_count].dir =-1
        cdEnemy = difficulty
        difficulty = difficulty *(0.997)+3
    end
    castle1:update(dt)
    castle2:update(dt)
    ability:update(dt)
end

function love:draw()
    if score>0 then
        camera:draw()
        love.graphics.scale(2, 2)
        
        love.graphics.draw(grass, 0, 0)
        love.graphics.draw(grass, 500, 0)
        castle1:draw()
        castle2:draw()
        troops_draw()
        ability:draw()
        camera:undraw()
        love.graphics.draw(qwer, 0, 150)
        upgradeInterface()
        love.graphics.printf(ToRoman(skillP), 220, 160, 32, "center")
        InputManager()
        love.graphics.scale(0.5, 0.5)
        love.graphics.print("FPS: "..tostring(love.timer.getFPS( )))
        love.graphics.draw(gold, 206, 320)
        love.graphics.print(math.floor(gd), 246, 328)
        --spells
        troopsInterface()
        spellsInterface()
        love.graphics.print("LVL: "..lvl, 206, 376)
        love.graphics.print(p_troops.."/"..p_mtroops, 206, 360)
        love.graphics.rectangle("fill", 206, 392, 390/(xp_next/xp), 6)


    else
        love.graphics.draw(win)
    end
end