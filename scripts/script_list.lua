-- ======================================================
-- SCRIPT LIST - OTC
-- Todos os scripts ficam na aba "Scripts"
-- ======================================================

script_manager = script_manager or {}
script_manager.actualVersion = 1

script_manager._cache = {
  Scripts = {

    ['Single + AOE Safe'] = {
      url = 'https://raw.githubusercontent.com/diiasx/otc-scripts/main/scripts/single_aoe_safe.lua',
      author = 'Yago',
      description = 'Usa AOE ou single baseado em players e quantidade de mobs',
      enabled = true
    },

    ['Smart Lure Control'] = {
      url = 'https://raw.githubusercontent.com/diiasx/otc-scripts/main/scripts/smart_lure.lua',
      author = 'Yago',
      description = 'Controla lure pausando e retomando CaveBot automaticamente',
      enabled = true
    }

  }
}
