--[[--------------------------------------------------------------------
	PhanxConfig-Panel
	Simple background panel widget generator. Requires LibStub.
	https://github.com/Phanx/PhanxConfig-Panel

	Copyright (c) 2009-2014 Phanx <addons@phanx.net>. All rights reserved.
	Feel free to include copies of this file WITHOUT CHANGES inside World of
	Warcraft addons that make use of it as a library, and feel free to use code
	from this file in other projects as long as you DO NOT use my name or the
	original name of this library anywhere in your project outside of an optional
	credits line -- any modified versions must be renamed to avoid conflicts and
	confusion. If you wish to do something else, or have questions about whether
	you can do something, email me at the address listed above.
----------------------------------------------------------------------]]

local MINOR_VERSION = 172

local lib, oldminor = LibStub:NewLibrary("PhanxConfig-Panel", MINOR_VERSION)
if not lib then return end

local panelBackdrop = {
	bgFile = [[Interface\Tooltips\UI-Tooltip-Background]], tile = true, tileSize = 16,
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]], edgeSize = 16,
	insets = { left = 5, right = 5, top = 5, bottom = 5 }
}

local function SetPoint(f, a, to, b, x, y)
	if f.label:GetText() and strfind(a, "TOP") then
		if x and not y then
			a, to, b, x, y = a, to, a, b, x
		elseif b and not x then
			a, to, b, x, y = a, f:GetParent(), a, to, b
		end
		y = y - f.label:GetHeight()
	end
	f.__SetPoint(f, a, to, b, x, y)
end

local function SetLabel(f, labelText)
	local prev = f.label:GetText()
	f.label:SetText(labelText)
	if (not not prev) ~= (not not labelText) then
		for i = 1, f:GetNumPoints() do
			f:SetPoint(f:GetPoint(i))
		end
	end
end

function lib:New(parent, labelText, width, height)
	assert(type(parent) == "table" and type(rawget(parent, 0)) == "userdata", "PhanxConfig-Panel: Parent is not a valid frame!")
	if type(label) == "number" then
		label, width, height = nil, label, width -- backwards compat
	end

	local frame = CreateFrame("Frame", nil, parent)
	frame:SetBackdrop(panelBackdrop)
	frame:SetBackdropColor(0.06, 0.06, 0.06, 0.4)
	frame:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)

	local label = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	label:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 4, 0)
	label:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -4, 0)
	label:SetJustifyH("LEFT")
	frame.label = label

	frame.__SetPoint = frame.SetPoint
	frame.SetPoint = SetPoint

	frame.SetLabel = SetLabel

	label:SetText(labelText)
	if width and height then
		frame:SetSize(width, height)
	end

	return frame
end

function lib.CreatePanel(...) return lib:New(...) end