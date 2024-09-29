mainMenu = zUI.CreateMenu("Menu Principale", GetPlayerName(PlayerId()) .. ' - ' .. GetPlayerServerId(PlayerId()), Config.Menu.Banner, "F1", "Ouvrir le menu principal.")

mainMenu:SetItems(function(Items)
    Items:AddButton("Inventaire", "Ouvrir votre inventaire", {RightLabel = "→→", LeftBadge = 'https://cdn.discordapp.com/attachments/1287155646860628001/1289531415855108106/Sans_titre-1.png?ex=66f9d1f7&is=66f88077&hm=fab678c3e7cf7fbf27a433e2e6398c967924212ff9d9c200ff3b84899407698e&'}, function(onSelected)
    end, mainMenuInventory)
end)

mainMenu:OnOpen(function()
    Menu:RefreshInventory()
end)