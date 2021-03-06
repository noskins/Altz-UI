local _, ns = ...
local F, C = unpack(ns)

-- Blizzard_CovenantPreviewUI

C.themes["Blizzard_CovenantPreviewUI"] = function()
	local CovenantPreviewFrame = CovenantPreviewFrame
	F.Reskin(CovenantPreviewFrame.SelectButton)

	local infoPanel = CovenantPreviewFrame.InfoPanel
	infoPanel.Name:SetTextColor(1, .8, 0)
	infoPanel.Location:SetTextColor(1, 1, 1)
	infoPanel.Description:SetTextColor(1, 1, 1)
	infoPanel.AbilitiesFrame.AbilitiesLabel:SetTextColor(1, .8, 0)
	infoPanel.SoulbindsFrame.SoulbindsLabel:SetTextColor(1, .8, 0)
	infoPanel.CovenantFeatureFrame.Label:SetTextColor(1, .8, 0)

	hooksecurefunc(CovenantPreviewFrame, "TryShow", function(self)
		if not self.bg then
			self.Background:SetAlpha(0)
			self.BorderFrame:SetAlpha(0)
			self.Title:DisableDrawLayer("BACKGROUND")
			self.Title.Text:SetTextColor(1, .8, 0)
			self.Title.Text:SetFontObject(SystemFont_Huge1)
			self.ModelSceneContainer.ModelSceneBorder:SetAlpha(0)
			F.CreateBDFrame(self.Title, .25)
			F.ReskinClose(self.CloseButton)
			self.CloseButton.Border:SetAlpha(0)
			self.bg = F.SetBD(self)
		end
		self.CloseButton:SetPoint("TOPRIGHT", -6, -6)
	end)
end

-- Blizzard_CovenantSanctum

local function replaceIconString(self, text)
	if not text then text = self:GetText() end
	if not text or text == "" then return end

	local newText, count = gsub(text, "|T([^:]-):[%d+:]+|t", "|T%1:14:14:0:0:64:64:5:59:5:59|t")
	if count > 0 then self:SetFormattedText("%s", newText) end
end

local function reskinTalentsList(self)
	for frame in self.talentPool:EnumerateActive() do
		if not frame.bg then
			frame.Border:SetAlpha(0)
			frame.IconBorder:SetAlpha(0)
			frame.TierBorder:SetAlpha(0)
			frame.Background:SetAlpha(0)
			frame.bg = F.CreateBDFrame(frame, .25)
			frame.bg:SetInside()
			frame.Highlight:SetColorTexture(1, 1, 1, .25)
			frame.Highlight:SetInside(frame.bg)
			F.ReskinIcon(frame.Icon)
			frame.Icon:SetPoint("TOPLEFT", 7, -7)

			replaceIconString(frame.InfoText)
			hooksecurefunc(frame.InfoText, "SetText", replaceIconString)
		end
	end
end

local function hideRenownLevelBorder(frame)
	if not frame.styled then
		frame.Divider:SetAlpha(0)
		frame.BackgroundTile:SetAlpha(0)
		F.CreateBDFrame(frame.Background, .25)

		frame.styled = true
	end

	for button in frame.milestonesPool:EnumerateActive() do
		if not button.styled then
			button.LevelBorder:SetAlpha(0)

			button.styled = true
		end
	end
end

local function replaceCurrencies(displayGroup)
	for frame in displayGroup.currencyFramePool:EnumerateActive() do
		if not frame.styled then
			replaceIconString(frame.Text)
			hooksecurefunc(frame.Text, "SetText", replaceIconString)

			frame.styled = true
		end
	end
end

C.themes["Blizzard_CovenantSanctum"] = function()
	local CovenantSanctumFrame = CovenantSanctumFrame

	if not C.isNewPatch then
		F.ReskinTab(CovenantSanctumFrameTab1)
		F.ReskinTab(CovenantSanctumFrameTab2)
		CovenantSanctumFrameTab1:SetPoint("TOPLEFT", CovenantSanctumFrame, "BOTTOMLEFT", 23, 1)
	end

	CovenantSanctumFrame:HookScript("OnShow", function(self)
		if not self.bg then
			self.bg = F.SetBD(self)
			self.NineSlice:SetAlpha(0)
			self.LevelFrame.Background:SetAlpha(0)
			F.ReskinClose(self.CloseButton)
			self.CloseButton.Border:SetAlpha(0)
		end
	end)

	local upgradesTab = CovenantSanctumFrame.UpgradesTab
	upgradesTab.Background:SetAlpha(0)
	F.CreateBDFrame(upgradesTab.Background, .25)
	F.Reskin(upgradesTab.DepositButton)
	for _, frame in ipairs(upgradesTab.Upgrades) do
		if frame.TierBorder then
			frame.TierBorder:SetAlpha(0)
		end
	end
	upgradesTab.CurrencyBackground:SetAlpha(0)
	replaceCurrencies(upgradesTab.CurrencyDisplayGroup)

	local talentsList = upgradesTab.TalentsList
	talentsList.Divider:SetAlpha(0)
	F.CreateBDFrame(talentsList, .25)
	talentsList.BackgroundTile:SetAlpha(0)
	talentsList.IntroBox.Background:Hide()
	F.Reskin(talentsList.UpgradeButton)
	hooksecurefunc(talentsList, "Refresh", reskinTalentsList)

	if not C.isNewPatch then
		hooksecurefunc(self.RenownTab, "Refresh", hideRenownLevelBorder)
	end
end

-- Covenant renown
C.themes["Blizzard_CovenantRenown"] = function()
	local CovenantRenownFrame = CovenantRenownFrame

	F.SetBD(CovenantRenownFrame)
	F.ReskinClose(CovenantRenownFrame.CloseButton)

	hooksecurefunc(CovenantRenownFrame, "SetUpTextureKits", function(self)
		F.StripTextures(self)
		self.CloseButton.Border:Hide()
	end)

	hooksecurefunc(CovenantRenownFrame.TrackFrame, "Init", function(self)
		for _, element in next, self.Elements do
			if not element.styled then
				element.LevelBorder:SetAlpha(0)
				element.styled = true
			end
		end
	end)
end