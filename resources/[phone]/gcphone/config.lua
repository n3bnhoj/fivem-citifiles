Config = {}

-- Script locale (only .Lua)
Config.Locale = 'en'

Config.FixePhone = {
    -- police station
  ['911'] = { 
    name =  _U('policestation'), 
    coords = { x = -561.99, y = -126.09, z = 38.44 } 
  },

  ['122'] = { 
    name =  _U('hospital'), 
    coords = { x = -433.14, y = -327.51, z = 34.91 } 
  },

  ['143'] = { 
    name =  _U('mechanic'), 
    coords = { x = -341.1, y = -155.48, z = 44.59 } 
  },

  ['123'] = { 
    name =  _U('burgershot'), 
    coords = { x = -1190.57, y = -896.49, z = 14.01 } 
  },

  ['456'] = { 
    name =  _U('tacobell'), 
    coords = { x = 11.03, y = -1605.9, z = 29.39 } 
  },

  ['789'] = { 
    name =  _U('coffeebean'), 
    coords = { x = -634.83, y = 233.35, z = 81.88 } 
  },
  
  ['008-0001'] = {
    name = _U('phone_booth'),
    coords = { x = 372.25, y = -965.75, z = 28.58 } 
  },
  
}

Config.KeyOpenClose = 288 -- F1
Config.KeyTakeCall  = 38  -- E

Config.UseMumbleVoIP = true -- Use Frazzle's Mumble-VoIP Resource (Recommended!) https://github.com/FrazzIe/mumble-voip
Config.UseTokoVoIP   = false

Config.ShowNumberNotification = false -- Show Number or Contact Name when you receive new SMS

Config.ShareRealtimeGPSDefaultTimeInMs = 1000 * 60 -- Set default realtime GPS sharing expiration time in milliseconds
Config.ShareRealtimeGPSJobTimer = 10 -- Default Job GPS Timer (Minutes)

-- Optional Features (Can all be set to true or false.)
Config.ItemRequired = true-- If true, must have the item "phone" to use it.
Config.NoPhoneWarning = false -- If true, the player is warned when trying to open the phone that they need a phone. To edit this message go to the locales for your language.

-- Optional Discord Logging
Config.UseTwitterLogging = false -- Set the Discord webhook in twitter.lua line 284