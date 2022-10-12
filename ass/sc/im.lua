local im = {}
    --declare the cooldowns
    cd = {0, 0, 0, 0, 
          1, 1, 1, 1, 1, 1, 1, 1
    }
    cd[101] = 30
    cd[102] = 40
    cd[103] = 50
    cd[104] = 60

    cd[105] = 3
    cd[106] = 4
    cd[107] = 5
    cd[108] = 6
    cd[109] = 8
    cd[110] = 8
    cd[111] = 10
    cd[112] = 16
    upg = {1, 1, 1, 1}
    function BuyTroop(troop, price)
        if cd[troop+4]<0 and gd>price then
            
            gd=gd-price
            troop_create(troop, 1)
            cd[troop+4] = cd[troop+104]
        end
    end

    function UseSpell(spell)
        if spell<=4 then
            love.graphics.draw(qwerPress, qwer_quad[spell], ((spell-1)*25)+4, 183)
        end  
        if cd[spell]<0 then
            cd[spell] = cd[spell+100]
            ability.spell[spell].active = true
        end
    end
    function UpgradeSmth(upgr)
        if upg[upgr]==3 then return end
        if skillP==0 then return end
        upg[upgr]=upg[upgr]+1
        skillP=skillP-1
    end

    function InputManager()
        cd[101] = 34-upg[2]*4
        cd[102] = 45-upg[2]*5
        cd[103] = 56-upg[2]*6
        cd[104] = 67-upg[2]*7
        if love.keyboard.isDown("q") and lvl>=2 then
            UseSpell(1)
        end
        if love.keyboard.isDown("w") and lvl>=4 then
            UseSpell(2)
        end
        if love.keyboard.isDown("e") and lvl>=6 then
            UseSpell(3)
        end
        if love.keyboard.isDown("r") and lvl>=8 then
            UseSpell(4)
        end
        local i =1 
        while i<=8 do
            if love.keyboard.isDown(i) and lvl>=i then
                BuyTroop(i, class_data[i].cost)
            end
            i=i+1
        end
        local i =1 
        while i<=4 do
            if love.keyboard.isDown(i) and love.keyboard.isDown("lctrl") then
                UpgradeSmth(i)
            end
            i=i+1
        end
    end

return im