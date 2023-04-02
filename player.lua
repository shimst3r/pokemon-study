function new_ash(x, y)
    local ash = { x = x, y = y, dir = "down", lock = false, frame = 0, animation_count = 0 }

    function ash:animate(scene)
        self.animation_count = self.animation_count + 1
        if self.animation_count % 3 == 2 then
            self.frame = (self.frame + 1) % 4
            if not ash:collision(scene) then
                if self.dir == "left" then
                    self.x = self.x - 0.25
                elseif self.dir == "up" then
                    self.y = self.y - 0.25
                elseif self.dir == "right" then
                    self.x = self.x + 0.25
                elseif self.dir == "down" then
                    self.y = self.y + 0.25
                end
            end
        end
        if self.animation_count % 12 == 0 then
            self.lock = false
        end
    end

    function ash:collision(scene)
        if self.dir == "left" then
            return fget(mget(self.x - 0.25, self.y + 1.5), 0)
        elseif self.dir == "up" then
            return fget(mget(self.x, self.y + 1), 0)
        elseif self.dir == "right" then
            return fget(mget(self.x + 2, self.y + 1.5), 0)
        elseif self.dir == "down" then
            return fget(mget(self.x, self.y + 2), 0)
        end
        return false
    end

    function ash:draw()
        local x = self.x
        local y = self.y
        local dir = self.dir
        local sprite_offset = self.frame % 2 == 0 and 0 or 1
        if dir == "left" then
            spr(012 + 2 * sprite_offset, x * 8, y * 8, 2, 2, true)
        elseif dir == "up" then
            spr(008 + 2 * sprite_offset, x * 8, y * 8, 2, 2, self.frame == 3)
        elseif dir == "right" then
            spr(012 + 2 * sprite_offset, x * 8, y * 8, 2, 2)
        elseif dir == "down" then
            spr(004 + 2 * sprite_offset, x * 8, y * 8, 2, 2, self.frame == 3)
        end
    end

    function ash:event_listener()
        if btn(⬅️) then
            self.dir = "left"
            self.lock = true
        elseif btn(⬆️) then
            self.dir = "up"
            self.lock = true
        elseif btn(➡️) then
            self.dir = "right"
            self.lock = true
        elseif btn(⬇️) then
            self.dir = "down"
            self.lock = true
        end
    end

    function ash:update(scene)
        if not self.lock then
            ash:event_listener()
        else
            ash:animate(scene)
        end
    end

    return ash
end
