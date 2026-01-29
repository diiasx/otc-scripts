-- ======================================================
-- SMART LURE CONTROL
-- Autor: Diiasx
-- ======================================================

-- 🔒 Proteção contra carregamento duplicado
if _G.smartLureLoaded then return end
_G.smartLureLoaded = true

-- ================= STORAGE =================
storage.smartLure = storage.smartLure or {
  maxMobs   = 2,
  distance = 2,
  fighting = false
}

local CHECK_DELAY = 200

-- ================= SUMMONS / MONSTROS IGNORADOS =================
local IGNORE_SUMMONS = {
  ["raiton hearth"] = true,
  ["fuuton hearth"] = true,
  ["suiton hearth"] = true,
  ["katon hearth"] = true,
  ["kugutsu"] = true
}

-- ================= BOT UI =================
UI.Separator()
UI.Label("SMART LURE")

UI.Label("Máximo de mobs:")
UI.TextEdit(tostring(storage.smartLure.maxMobs), function(_, text)
  local v = tonumber(text)
  if v then storage.smartLure.maxMobs = v end
end)

UI.Label("Distância:")
UI.TextEdit(tostring(storage.smartLure.distance), function(_, text)
  local v = tonumber(text)
  if v then storage.smartLure.distance = v end
end)

UI.Separator()

-- ================= HUD =================
local lureHud = setupUI([[
UIWidget
  background-color: black
  opacity: 0.8
  padding: 3 8
  focusable: false
  phantom: false
  draggable: true
]], g_ui.getRootWidget())

local lureLabel = g_ui.createWidget("Label", lureHud)
lureLabel:setText("Lure: 0/0")
lureLabel:setColor("green")

lureHud:setPosition({ x = 50, y = 50 })

-- ================= MACRO =================
macro(CHECK_DELAY, "Smart Lure Control", function()
  local mobs = 0
  local p = player:getPosition()
  local cfg = storage.smartLure

  for _, creature in ipairs(getSpectators()) do
    if creature:isMonster() then
      local name = creature:getName():lower()

      -- ignora summons
      if not IGNORE_SUMMONS[name] then
        local c = creature:getPosition()

        if c.z == p.z
        and math.abs(c.x - p.x) <= cfg.distance
        and math.abs(c.y - p.y) <= cfg.distance then
          mobs = mobs + 1
        end
      end
    end
  end

  -- Atualiza HUD
  lureLabel:setText("Lure: " .. mobs .. "/" .. cfg.maxMobs)

  if mobs >= cfg.maxMobs then
    lureLabel:setColor("red")
  elseif mobs > 0 then
    lureLabel:setColor("yellow")
  else
    lureLabel:setColor("green")
  end

  -- Pausa CaveBot
  if mobs >= cfg.maxMobs and not cfg.fighting then
    cfg.fighting = true
    CaveBot.setOff()
  end

  -- Retorna CaveBot só quando zerar
  if cfg.fighting and mobs == 0 then
    cfg.fighting = false
    CaveBot.setOn()
  end
end)
