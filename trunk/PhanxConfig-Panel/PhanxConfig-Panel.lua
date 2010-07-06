--[[--------------------------------------------------------------------
	PhanxConfig-Panel
	Simple background panel widget generator. Requires LibStub.

	This library is not intended for use by other authors. Absolutely no
	support of any kind will be provided for other authors using it, and
	its internals may change at any time without notice.
----------------------------------------------------------------------]]

local MINOR_VERSION = tonumber(("$Revision$"):match("%d+"))

local lib, oldminor = LibStub:NewLibrary("PhanxConfig-Panel", MINOR_VERSION)
if not lib then return end

local panelBackdrop = GameTooltip:GetBackdrop()

function lib.CreatePanel(parent, width, height)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetFrameStrata(parent:GetFrameStrata())
	frame:SetFrameLevel(parent:GetFrameLevel() + 1)

	frame:SetBackdrop(panelBackdrop)
	frame:SetBackdropColor(0.1, 0.1, 0.1, 0.5)
	frame:SetBackdropBorderColor(0.8, 0.8, 0.8, 0.5)

	frame:SetWidth(width or 1)
	frame:SetHeight(height or 1)

	return frame
end