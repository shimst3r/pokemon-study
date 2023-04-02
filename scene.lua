function new_scene()
    local scene = {}
    scene.floors = {
        wall = { n = 016, col = 0, row = 0, w = 15, h = 2 },
        floor = { n = 001, col = 0, row = 3, w = 15, h = 12 },
    }
    scene.sprites = {
        bed = { n = 072, col = 0, row = 12, w = 2, h = 4 },
        pc = { n = 070, col = 0, row = 0, w = 2, h = 4 },
        plant = { n = 074, col = 12, row = 12, w = 2, h = 4 },
        snes = { n = 096, col = 6, row = 10, w = 2, h = 2 },
        stairs = { n = 078, col = 14, row = 3, w = 2, h = 2 },
        table = { n = 066, col = 2, row = 1, w = 4, h = 3 },
        tv = { n = 064, col = 6, row = 8, w = 2, h = 2 },
        window1 = { n = 032, col = 10, row = 0.5, w = 2, h = 2 },
        window2 = { n = 032, col = 13, row = 0.5, w = 2, h = 2 },
    }

    function scene:draw()
        for _, f in pairs(self.floors) do
            for col = f.col, f.col + f.w do
                for row = f.row, f.row + f.h do
                    mset(col, row, f.n)
                end
            end
        end
        map()
        --[[
            add additional sprites to map after rendering so that they
            won't be displayed as map tiles (which would render the
            transparency useless), but I can still use mget + fget for
            collision detection.
        --]]
        for _, s in pairs(self.sprites) do
            for col = s.col, s.col + s.w - 1 do
                for row = s.row, s.row + s.h - 1 do
                    mset(col, row, s.n)
                end
            end
            spr(s.n, 8 * s.col, 8 * s.row, s.w, s.h)
        end
    end

    return scene
end
