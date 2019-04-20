function love.load()
    WW, WH = love.graphics.getDimensions()
    love.mouse.setVisible(false)
    require("Class")
    require("Shape")
    require("Player")
    require("Enemy")

    player = Player()
    enemies = {}
    for i = 1, 25 do 
        table.insert(enemies, Enemy())
    end

    bgY = 0

    bgImage = love.graphics.newImage("bg.png")
    scrollingSpeed = -500

    startingImage = love.graphics.newImage("starting.png")
    playing = false

    score = 0
    font = love.graphics.newFont(75)
    scoreText = love.graphics.newText(font, score)

    lost = true

    loop = love.audio.newSource("loop.wav", "stream")
    loop:setLooping(true)
end

function love.draw()
    if playing then
        love.graphics.draw(bgImage, 0, bgY)
        player:draw()
        for index, fish in ipairs(enemies) do
            fish:draw()
        end
        if lost then love.graphics.print("PRESS SPACE TO TRY AGAIN", 125, 50) end
    else
        love.graphics.draw(startingImage, 0, 0)
    end
    love.graphics.draw(scoreText, 15, 15)
end

function love.update(dt)
    if playing then
        player:update(dt)
        for index, fish in ipairs(enemies) do
            fish:update(dt)
        end
        bgY = bgY + scrollingSpeed * dt
        if bgY < - WH then bgY = 0 end
        if not lost then
            score = score + dt
            scoreText = love.graphics.newText(font, math.floor(score))
        end
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    if key == "space" and lost then
        playing = true
        lost = false
        player = Player()
        enemies = {}
        for i = 1, 3 do 
            table.insert(enemies, Enemy())
        end
    
        bgY = 0

        score = 0
        font = love.graphics.newFont(75)
        scoreText = love.graphics.newText(font, score)
        loop:play()
    end
end