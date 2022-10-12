function NewCastle(dir, xz, yz, rng)
    local obj = {
        team=dir,
        x = xz,
        y = yz,
        range = rng,
        cd = 1,
        health= 1000
    }
    
    function obj:update(delta)
        obj.cd = obj.cd - delta
        if obj.cd<0 then
            local i=1
            local min, minID = 1000, 0
            while troops[i] and troop_count>1 do

                if math.abs(obj.x-troops[i].x)<min and obj.team~=troops[i].dir and math.abs(obj.x-troops[i].x)<obj.range then
                    min=troops[i].x
                    minID = i
                end
                
                i=i+1
            end
            if minID ==0 then return end
            troops[minID].health =(troops[minID].health - 20) + obj.team*5
            obj.cd = 1.5
        end
    end
    function obj:draw()
        if obj.team==-1 then
            love.graphics.draw(castle_src, obj.x+108, 0, 0, -1, 1)
            drawHP(obj.x+10, 144, 80, 1000, obj.health)
        else
            love.graphics.draw(castle_src, obj.x, 0)
            drawHP(obj.x+17, 144, 80, 1000, obj.health)
        end
    end
    return obj
end

