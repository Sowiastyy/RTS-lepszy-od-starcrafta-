local troop = {} 
    p_troops = 0
    p_mtroops = 10
    troop_count = 0
    function troop_init()
        local obj = {}
        obj.class = 1
        obj.x = 0
        obj.dir = 1
        obj.cd = 0
        obj.stunTime =  0
        obj.collide = false
        return obj
    end

        
    function troop_create(class, dir)
        if troop_count<100 then
            troop_count = troop_count +1
            troops[troop_count] = troop_init()
            troops[troop_count].class = class
            troops[troop_count].cd =1
            troops[troop_count].dir =dir
            troops[troop_count].health = class_data[class].health
            troops[troop_count].mhealth = class_data[class].health
            troops[troop_count].dmg = class_data[class].dmg
            troops[troop_count].attSpd = class_data[class].att_spd
            troops[troop_count].spd = class_data[class].spd
            troops[troop_count].range = class_data[class].range
            if troops[troop_count].dir == 1 then
                if p_troops>=p_mtroops then
                   table.remove(troops, troop_count)
                    troop_count=troop_count-1
                else
                    p_troops = p_troops +1
                end
            end
        end
    end
    
    troops = {}
    troop_create(1, -1)
    troops[1].x = 800

    troops[1].dir =-1
    function closest_enemy(id)
        local i=1
        local min, minID = 1000, 0
        while troops[i] and troop_count>1 do

            if math.abs(troops[id].x-troops[i].x)<min and troops[id].dir~=troops[i].dir and id~=i and math.abs(troops[id].x-troops[i].x)<troops[id].range then
                min=math.abs(troops[id].x-troops[i].x)
                minID = i
            end
            
            i=i+1
        end
        return minID
    end
    
    function troops_buff(id)
        local i=1
        while troops[i] and troop_count>1 do
            if math.abs(troops[id].x-troops[i].x)<troops[id].range and troops[id].dir==troops[i].dir and id~=i then
                troops[i].health = troops[i].health + (troops[id].dmg*2+upg[4]*3)
                troops[i].collide = true
                return
            end
            i=i+1
        end
    end

    function troops_attack(id)
        local closest = closest_enemy(id)

        if closest~=0 then
            troops[closest].health = troops[closest].health-troops[id].dmg
            if troops[id].class==5 then
                local i=1
                while troops[i] and troop_count>1 do
                    if troops[id].dir~=troops[i].dir and id~=i and math.abs(troops[id].x-troops[i].x)<troops[id].range then
                        print(i)
                        troops[i].health = troops[i].health-(10+upg[3]*4)
                    end
                    
                    i=i+1
                end
            end
            if troops[id].class==6 or troops[id].class==8 then
                troops[closest].health = troops[closest].health-upg[3]*4
            end 
            if troops[id].class==7 then
                troops[closest].stunTime=1
            end 
            if troops[id].class==8 then
                troops[id].health = troops[id].health + (troops[id].dmg/2+upg[4]*3)
            end 
            troops[closest].collide = true
        else
            if troops[id].dir == 1 then
                if math.abs(troops[id].x-castle2.x-81)<troops[id].range then
                    castle2.health = castle2.health - troops[id].dmg
                    if castle2.health<0 then
                        score=0
                    end
                end
            else
                if math.abs(troops[id].x-castle1.x)<troops[id].range then
                    castle1.health = castle1.health - troops[id].dmg
                    if castle1.health<0 then
                        love.event.quit("restart")
                    end
                end
            end
        end
    end
    function castle_collide(id)
        if troops[id].dir == 1 then
            if math.abs(troops[id].x-castle2.x-81)<54 then
                return true
            end
        else
            if math.abs(troops[id].x-castle1.x)<54 then
                return true
            end
        end
        return false
    end
    function troop_colliding(id)
        local i=1
        while troops[i] and troop_count>1 do
            if math.abs(troops[id].x-troops[i].x)<32 and id~=i and troops[i].dir~=troops[id].dir or castle_collide(id) then
                troops[id].collide=true
                return
            end
            i=i+1 
        end
        troops[id].collide=false
    end

    function troops_update()
        local i=1
        p_mtroops = 5+upg[3]*5
        while troops[i] do
            if troops[i].health<=0 then
                if troops[i].dir==-1 then
                    gd=6+gd+(2*troops[i].class)+(upg[1]*2)
                    xp = xp +(3*troops[i].class)
                    if xp>=xp_next then
                        lvl = lvl+1
                        xp = 1
                        skillP =skillP+1
                        xp_next = 9*lvl+lvl*lvl
                    end
                    cdEnemy= cdEnemy-1
                else
                    cdEnemy= cdEnemy-2+(0.6*troops[i].class)
                    p_troops = p_troops -1
                end

                table.remove(troops, i)
                troop_count = troop_count -1
                
            end

            i=i+1
        end
        local i=1
        while troops[i] do

            troop_colliding(i)
            if troops[i].stunTime<0 then
                if troops[i].collide==false then
                    troops[i].x = troops[i].x+(troops[i].dir*troops[i].spd)
                end

                if troops[i]==nil then return end
                if troops[i].cd<0  then
                    troops[i].cd = troops[i].attSpd
                    troops_attack(i)
                    if troops[i].class==6 then
                        troops_buff(i)
                    end
                end
                if troops[i].health>troops[i].mhealth then
                    troops[i].health=troops[i].mhealth
                end
            end
            i=i+1
        end
        
    end

    function IfDirAdd(id)
        if troops[id].dir==-1 then
            return 32
        else
            return 0
        end
    end

    function troops_draw()
        local i=1
        while troops[i] do
            love.graphics.draw(classes, class_quad[troops[i].class], troops[i].x+IfDirAdd(i), 108, 0, troops[i].dir, 1)
            love.graphics.setColor(0, 0, 0)
            drawHP(troops[i].x+7, 106, 20, troops[i].mhealth, troops[i].health)
            i=i+1    
        end
        
    end
return troop