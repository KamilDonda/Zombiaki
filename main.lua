require "Health"
require "Sprite"
require "Zombie"

local lg = love.graphics

local player
local playerX
local playerY
local speed = 300
local maxHealth = 3
local currentHealth = maxHealth
local health

local background
local background_quad

local windowMode

local screenResW = 1280
local screenResH = 720
local playerRot

zombies = {}

function love.load()
  player = lg.newImage('Sprites/Player.png')
  background = lg.newImage('Sprites/Background.png')
  background:setWrap("repeat", "repeat")
  background_quad = lg.newQuad(0, 0, screenResW, screenResH, background:getWidth(), background:getHeight())
  playerX = love.graphics.getWidth() / 2
  playerY = love.graphics.getHeight() / 2
  playerRot = math.atan2((love.mouse.getY() - playerY), (love.mouse.getX() - playerX))

  health = Health(currentHealth)
  print("currentHealth: "..currentHealth)
  currentHealth = health.loseLife(1)
  print("currentHealth: "..currentHealth)
  -- create Zombies and add them to the table
  zombieImg = lg.newImage('Sprites/Zombie.png')
  list = {{50, 50}, {1000, 50}, {10, 400}, {1000, 800}}
  for i = 1, 4 do
    local zombieSprite = Sprite(zombieImg)
    local zombie = Zombie(zombieSprite)
    zombie.initPosition(list[i][1], list[i][2])
    table.insert(zombies, zombie)
  end

  windowMode = love.window.setMode(screenResW, screenResH)
end

function love.update(dt)
  moveZombie(dt, playerX, playerY)
  playerRot = math.atan2((love.mouse.getY() - playerY), (love.mouse.getX() - playerX))
  if love.keyboard.isDown("right", 'd')  then
    playerX = playerX+speed*dt
  elseif love.keyboard.isDown("left",'a') then
    playerX = playerX - speed * dt
  end
  if love.keyboard.isDown("down",'s') then
    playerY = playerY+speed*dt
  elseif love.keyboard.isDown("up",'w') then
    playerY = playerY - speed * dt
  end
end

function love.draw()
  lg.draw(background, background_quad, 0, 0)
  lg.draw(player, playerX, playerY, playerRot, 1, 1, player:getWidth() / 2, player:getHeight() / 2)
  health.drawHearts()

  for i = 1, #zombies do
    local zombie = zombies[i].sprite
    local rotate = zombies[i].rotate(playerX, playerY)
    lg.draw(
      zombie.image, zombie.x, zombie.y, rotate, 1, 1,
      zombie.width / 2, zombie.height / 2)
  end
end

function moveZombie(dt, pX, pY)
  for i = 1, #zombies do
    local zombie = zombies[i]
    local t = copyTable(zombies, i)
    zombie.move(dt, pX, pY, t)
  end
end

function copyTable(old, n)
  local t = {}
  for i = 1, #old do
    if i ~= n then
      table.insert(t, old[i])
    end
  end
  return t
end
