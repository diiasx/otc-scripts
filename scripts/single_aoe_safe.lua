-- Evita carregar duas vezes
if _G.singleAoeSafeLoaded then return end
_G.singleAoeSafeLoaded = true

macro(100, "SINGLE + AOE SAFE", function()
    if not g_game.isAttacking() then return end

    local cfg = storage.lureSafe
    if not cfg then return end

    local playerDetected = hasPlayerOnScreen()
    local mobCount = getMonstersInRange(cfg.range)

    if playerDetected then
        sayMultipleSpells(cfg.singleSpells)
        return
    end

    if mobCount >= cfg.quantityLure and player:getSkull() < 3 then
        sayMultipleSpells(cfg.areaSpells)
    else
        sayMultipleSpells(cfg.singleSpells)
    end
end)
