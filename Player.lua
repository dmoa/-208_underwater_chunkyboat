Player = class(
    Shape,
    function(self)
        self.image = love.graphics.newImage("player.png")
        Shape.init(self, WW / 2 - self.image:getWidth(), 210, self.image:getDimensions())
        self.friction = 0.3
        self.xv = 0
        self.xv_acceleration = 2000
        self.yv = 0
        self.rotating = false
        self.rotation = 0
    end
)

function Player:draw()
    love.graphics.draw(self.image, self.x, self.y, self.rotation)
end

function Player:update(dt)
    if not love.keyboard.isDown("a") and not love.keyboard.isDown("d") then
        self.xv = self.xv * math.pow(self.friction, dt)
        if self.xv < 25 and self.xv > - 25 then self.xv = 0 end
    end

    if self.xv > 400 then self.xv = 400 end
    if self.xv < - 400 then self.xv = -400 end

    if love.keyboard.isDown("a") then self.xv = self.xv - self.xv_acceleration * dt end
    if love.keyboard.isDown("d") then self.xv = self.xv + self.xv_acceleration * dt end

    self.x = self.x + self.xv * dt
    self.y = self.y + self.yv * dt

    if self.x < 0 then self.x = 0 self.xv = 0 end
    if self.x + self.width > WW then self.x = WW - self.width self.xv = 0 end

    for index, enemy in ipairs(enemies) do
        if self:isCollidingWith(enemy) then
            self.yv = scrollingSpeed / 1.2
            self.rotating = true
            lost = true
            loop:stop()
        end
    end
    if self.rotating then 
        self.rotation = self.rotation + dt * 2
    end
end