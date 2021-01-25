function Zombie(_sprite)
  local self = {
    sprite = _sprite,
    speed = 100
  }

  -- init position
  function self.initPosition(x, y)
    self.sprite.x = x
    self.sprite.y = y
  end

  -- movement
  function self.move(dt, pX, pY, zombies)
    local newX = 0
    local newY = 0
    -- horizontal movement
    if self.sprite.x <= pX then
      newX = self.sprite.x + (self.speed * dt)
    else
      newX = self.sprite.x - (self.speed * dt)
    end
    -- vertical movement
    if self.sprite.y <= pY then
      newY = self.sprite.y + (self.speed * dt)
    else
      newY = self.sprite.y - (self.speed * dt)
    end

      self.sprite.x = newX
      self.sprite.y = newY
  end

  -- init position
  function self.rotate(pX, pY)
    return math.atan2((pY - self.sprite.y), (pX - self.sprite.x))
  end

  return self
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
