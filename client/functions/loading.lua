--- Loading Hide
function Z.Function.loadingHide()
    if IsLoadingPromptBeingDisplayed() then
        RemoveLoadingPrompt()
        ShutdownLoadingScreen()
        ShutdownLoadingScreenNui()
        Z.IO.Trace('(Z.Functions.loadingHide) Loading hidden')
        return true
    end
end