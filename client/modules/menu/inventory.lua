mainMenuInventory = zUI.CreateSubMenu(mainMenu, "Votre inventaire", "Vos objets", Config.Menu.Banner)

mainMenuInventory:SetItems(function(Items)
    for item, data in pairs(Menu.items) do
        Items:AddList()
    end
end)

