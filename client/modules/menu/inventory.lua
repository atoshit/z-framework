mainMenuInventory = zUI.CreateSubMenu(mainMenu, "Votre inventaire", "Vos objets", Config.Menu.Banner)

mainMenuInventory:SetItems(function(Items)
    Items:AddLine({ "#ff0000", "#00ff00", "#0000ff" })
end)