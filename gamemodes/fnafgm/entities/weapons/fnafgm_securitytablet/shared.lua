SWEP.PrintName = GAMEMODE.Strings.en.monitor
SWEP.Author = "Xperidia"
SWEP.Instructions = GAMEMODE.Strings.en.monitor_inst
SWEP.Purpose = GAMEMODE.Strings.en.monitor_purp

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Weight			= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.ViewModelFOV	= 52
SWEP.Slot			= 0
SWEP.SlotPos			= 0
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= true
SWEP.BounceWeaponIcon = false

SWEP.ViewModel			= "models/weapons/c_arms.mdl"
SWEP.WorldModel			= ""

function SWEP:Initialize()
	self:SetWeaponHoldType("normal")
	if CLIENT then
		self.PrintName = tostring(GAMEMODE.TranslatedStrings.monitor or GAMEMODE.Strings.en.monitor)
		self.Instructions = tostring(GAMEMODE.TranslatedStrings.monitor_inst or GAMEMODE.Strings.en.monitor_inst)
		self.Purpose = tostring(GAMEMODE.TranslatedStrings.monitor_purp or GAMEMODE.Strings.en.monitor_purp)
	end
end

function SWEP:PrimaryAttack()
	
	if SERVER and (!poweroff or game.GetMap()=="fnaf2") then
		
		local tr = util.GetPlayerTrace( self.Owner )
		tr.filter = function(ent) if ent:GetClass()=="func_button" then return true end end
		local trace = util.TraceLine( tr )
		
		if (!trace.Hit) then return end
		
		if (!trace.HitNonWorld) then return end
		
		if (IsValid(trace.Entity) and trace.Entity:GetPos():Distance( trace.StartPos )<200) then
			
			fnafgmUse(self.Owner, trace.Entity, false, true)
			
		end
		
	end
	
end

function SWEP:SecondaryAttack()
	
	if table.Count(ents.FindByClass( "fnafgm_camera" ))==0 then return end
	
	if SERVER and !self.Owner.fnafviewactive and ( ( CheckPlayerSecurityRoom(self.Owner) and startday ) or fnafgmPlayerCanByPass(self.Owner,"tab") ) and (!poweroff or game.GetMap()=="fnaf2") and !tempostart then
		
		net.Start( "fnafgmSecurityTablet" )
		net.Send(self.Owner)
		
		fnafgmShutLights()
	
	end
	
end

function SWEP:Reload()
	
	if SERVER and !self.Owner.fnafviewactive and CheckPlayerSecurityRoom(self.Owner) and startday and !tempostart then
		fnafgmFNaFView(self.Owner)
	end
	
end

function SWEP:Think()
	
	if SERVER and !CheckPlayerSecurityRoom(self.Owner) and !fnafgmPlayerCanByPass(self.Owner,"tab") then
		net.Start( "fnafgmCloseTablet" )
		net.Send(self.Owner)
	end
	
end
