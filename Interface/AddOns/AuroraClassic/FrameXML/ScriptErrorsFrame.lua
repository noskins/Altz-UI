local _, ns = ...
local F, C = unpack(ns)

tinsert(C.defaultThemes, function()

	ScriptErrorsFrame:SetScale(UIParent:GetScale())
	F.StripTextures(ScriptErrorsFrame)
	F.SetBD(ScriptErrorsFrame)

	F.ReskinArrow(ScriptErrorsFrame.PreviousError, "left")
	F.ReskinArrow(ScriptErrorsFrame.NextError, "right")
	F.Reskin(ScriptErrorsFrame.Reload)
	F.Reskin(ScriptErrorsFrame.Close)
	F.ReskinScroll(ScriptErrorsFrameScrollBar)
	F.ReskinClose(ScriptErrorsFrameClose)
end)