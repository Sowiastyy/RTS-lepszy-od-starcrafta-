function troopsInterface()
    local i = 1
    local j = i
    local h = 312
    while i<=8 do
        if i>4 then
            j=i-4
            h=358
        else
            j=i
            h=312
        end
        love.graphics.draw(classes, class_quad[i], 558+(j*50), h)

        love.graphics.print(i, 558+(j*50)-6, h-6)

        love.graphics.setColor(1, 1, 0)
        love.graphics.print(class_data[i].cost, 558+(j*50)+22, h+22)
        love.graphics.print(class_data[i].cost, 558+(j*50)+23, h+23)
        love.graphics.setColor(0, 0, 0, 0.5)

        local n = cd[i+104]-cd[i+4]
        if n>cd[i+104] then n=cd[i+104] end
        love.graphics.rectangle("fill", 558+(j*50)-6, h-6+42*(n/cd[i+104]), 46, 42-42*(n/cd[i+104]))

        love.graphics.setColor(1, 1, 1, 1)
        if lvl<i then
            love.graphics.draw(lock, 558+(j*50)-6, h-6)
        end
        i=i+1
    end
end
function spellsInterface()
    local i = 1
    while i<=2 do
        love.graphics.draw(spells, spells_quad[i], 6+((i-1)*50), 322)

        --Mana cost
        --love.graphics.setColor(1, 1, 0)
        --love.graphics.print(class_data[i].cost, 558+(j*50)+22, h+22)
        --love.graphics.print(class_data[i].cost, 558+(j*50)+23, h+23)
        
        love.graphics.setColor(0, 0, 0, 0.5)
        local n = cd[i+100]-cd[i]
        if n>cd[i+100] then n=cd[i+100] end
        love.graphics.rectangle("fill", ((i-1)*50)+6, 322+40*(n/cd[i+100]), 46, 40-40*(n/cd[i+100]))

        love.graphics.setColor(1, 1, 1, 1)
        if lvl<i*2 then
            love.graphics.draw(lock, 6+i*50-50, 322)
        end

        i=i+1
    end
end
function upgradeInterface()
    local i = 1
    while i<=4 do
        local h = 150
        if i>2 then
            j=i-2
            h=179
        else
            j=i
            h=164
        end
        love.graphics.draw(upgrade, up_quad[i][upg[i]], 232+j*20, h)
        i=i+1
    end
end