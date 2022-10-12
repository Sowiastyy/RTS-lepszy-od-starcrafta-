camera = {}
    camera.x, camera.y = 0, 0
    
    function camera.update()
        mx, my = love.mouse.getPosition()
        local sx, sy = 800, 400
        local change_x =0
        if love.keyboard.isDown("a") and camera.x<0 then
            change_x = change_x +10
        end
        if love.keyboard.isDown("d") and camera.x>-1185 then
            change_x = change_x -10
        end
        camera.x = camera.x+change_x
    end
    function camera:draw()
        camera.update()
        love.graphics.translate(camera.x, camera.y)
    end
    function camera:undraw()
        love.graphics.translate(-camera.x/2, -camera.y/2)
    end
return camera