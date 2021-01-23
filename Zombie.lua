function Zombie(_sprite)
  local self = {
    sprite = _sprite,
    speed = 10
  }

  -- movement
  function self.move(dt, pX, pY)
    local nexX = 0
    local newY = 0
    -- horizontal movement
    if self.sprite.x <= pX then
      newX = self.sprite.x + (self.speed * dt)
    else
      newX = self.sprite.x - (self.speed * dt)
    end
    -- vertical movement
    if self.sprite.y <= pY then
      newX = self.sprite.y + (self.speed * dt)
    else
      newX = self.sprite.y - (self.speed * dt)
    end

    self.sprite.x = newX
    self.sprite.y = newY
  end

  -- init position
  function self.initPosition(x, y)
    self.sprite.x = x
    self.sprite.y = y
  end
  return self
end
