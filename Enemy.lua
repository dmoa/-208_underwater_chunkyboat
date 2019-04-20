Enemy = class(
    Shape,
    function(self)
        self.image = love.graphics.newImage("fish.png")
        Shape.init(self, love.math.random(WW - self.image:getWidth() / 2) , WH + 30, self.image:getDimensions())
        self.yv = (love.math.random(400) + 200) * -1
    end
)

function Enemy:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

function Enemy:update(dt)
    self.y = self.y + self.yv * dt
    if self.y < -self.height then
        self.yv = (love.math.random(400) + 200) * -1
        self.x = love.math.random(WW - self.image:getWidth())
        self.y = WH + 30
    end
end