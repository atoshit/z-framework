--- Loading Hide
function Z.Functions.loadingHide()
    if IsLoadingPromptBeingDisplayed() then
        RemoveLoadingPrompt()
        ShutdownLoadingScreen()
        ShutdownLoadingScreenNui()
        Z.IO.Trace('(Z.Functions.loadingHide) Loading hidden')
        return true
    end
end