local ECC_PresetFile = "Resources/plugins/Enhanced_Cloudscapes_Engine/preset/EC_Preset.cfg"
local ECC_Cld_DRefs = {
	{"enhanced_cloudscapes/cloud_map_scale",1,{},"Cloud Map Scale",{},{0,0.00001},{},1,1,1},          -- #1 ,Default 0.000005
	{"enhanced_cloudscapes/base_noise_scale",1,{},"Base Noise Scale",{},{0,0.0001},{},1,1,1},         -- #2 ,Default 0.000025
	{"enhanced_cloudscapes/detail_noise_scale",1,{},"Detail Noise Scale",{},{0,0.001},{},1,1,1},      -- #3 ,Default 0.0002
	{"enhanced_cloudscapes/blue_noise_scale",1,{},"Blue Noise Scale",{},{0,0.1},{},1,1,1},            -- #4 ,Default 0.01
	{"enhanced_cloudscapes/cirrus/coverage",1,{},"Cirrus Layer Coverage",{},{0,1.0},{},1,1,3},        -- #10,Default 0.375
	{"enhanced_cloudscapes/scattered/coverage",1,{},"Scattered Layer Coverage",{},{0,1.0},{},1,1,3},  -- #11,Default 0.75
	{"enhanced_cloudscapes/broken/coverage",1,{},"Broken Layer Coverage",{},{0,1.0},{},1,1,3},        -- #12,Default 0.85
	{"enhanced_cloudscapes/overcast/coverage",1,{},"Overcast Layer Coverage",{},{0,1.0},{},1,1,3},    -- #13,Default 0.95
	{"enhanced_cloudscapes/stratus/coverage",1,{},"Stratus Layer Coverage",{},{0,1.0},{},1,1,3},      -- #14,Default 1.0
	{"enhanced_cloudscapes/cirrus/base_noise_ratios",3,{},"Cirrus Base Noise Ratios",{},{0,1.0},{},0,4,4},         -- #15,Defaults 0.625, 0.25, 0.125
	{"enhanced_cloudscapes/scattered/base_noise_ratios",3,{},"Scattered Base Noise Ratios",{},{0,1.0},{},0,4,4},   -- #16,Defaults 0.625, 0.25, 0.125
	{"enhanced_cloudscapes/broken/base_noise_ratios",3,{},"Broken Base Noise Ratios",{},{0,1.0},{},0,4,4},         -- #17,Defaults 0.625, 0.25, 0.125
	{"enhanced_cloudscapes/overcast/base_noise_ratios",3,{},"Overcast Base Noise Ratios",{},{0,1.0},{},0,4,4},     -- #18,Defaults 0.625, 0.25, 0.125
	{"enhanced_cloudscapes/stratus/base_noise_ratios",3,{},"Stratus Base Noise Ratios",{},{0,1.0},{},0,4,4},       -- #19,Defaults 0.625, 0.25, 0.125
	{"enhanced_cloudscapes/cirrus/detail_noise_ratios",3,{},"Cirrus Detail Noise Ratios",{},{0,1.0},{},0,4,5},        -- #20,Defaults 0.25, 0.125, 0.0625
	{"enhanced_cloudscapes/scattered/detail_noise_ratios",3,{},"Scattered Detail Noise Ratios",{},{0,1.0},{},0,4,5},  -- #21,Defaults 0.625, 0.25, 0.125
	{"enhanced_cloudscapes/broken/detail_noise_ratios",3,{},"Broken Detail Noise Ratios",{},{0,1.0},{},0,4,5},        -- #22,Defaults 0.625, 0.25, 0.125
	{"enhanced_cloudscapes/overcast/detail_noise_ratios",3,{},"Overcast Detail Noise Ratios",{},{0,1.0},{},0,4,5},    -- #23,Defaults 0.625, 0.25, 0.125
	{"enhanced_cloudscapes/stratus/detail_noise_ratios",3,{},"Stratus Detail Noise Ratios",{},{0,1.0},{},0,4,5},      -- #24,Defaults 0.625, 0.25, 0.125
	{"enhanced_cloudscapes/cirrus/density_multiplier",1,{},"Cirrus Density Multiplier",{},{0,0.01},{},0,4,6},             -- #25,Default 0.0015
	{"enhanced_cloudscapes/scattered/density_multiplier",1,{},"Scattered Density Multiplier",{},{0,0.01},{},0,4,6},       -- #26,Default 0.0035
	{"enhanced_cloudscapes/broken/density_multiplier",1,{},"Broken Density Multiplier",{},{0,0.01},{},0,4,6},             -- #27,Default 0.004
	{"enhanced_cloudscapes/overcast/density_multiplier",1,{},"Overcast Density Multiplier",{},{0,0.01},{},0,4,6},         -- #28,Default 0.004
	{"enhanced_cloudscapes/stratus/density_multiplier",1,{},"Stratus Density Multiplier",{},{0,0.01},{},0,4,6},           -- #29,Default 0.0045
	{"enhanced_cloudscapes/sun_gain",1,{},"Sun Gain",{},{0,10.0},{},1,2,7},                                  -- #30,Default 3.25
	{"enhanced_cloudscapes/ambient_tint",3,{},"Ambient Tint",{},{0,10.0},{},1,1,7},                          -- #31,Defaults 1.0, 1.0, 1.0
	{"enhanced_cloudscapes/ambient_gain",1,{},"Ambient Gain",{},{0,10.0},{},1,1,7},                          -- #32,Default 1.5
	{"enhanced_cloudscapes/forward_mie_scattering",1,{},"Forward Mie Scattering",{},{0,1.0},{},1,2,7},       -- #33,Default 0.85
	{"enhanced_cloudscapes/backward_mie_scattering",1,{},"Backward Mie Scattering",{},{0,1.0},{},1,2,7},     -- #34,Default 0.25
	{"enhanced_cloudscapes/atmosphere_bottom_tint",3,{},"Atmosphere Bottom Tint",{},{0,1.0},{},1,2,7},       -- #35,Defaults 0.55, 0.775, 1.0
	{"enhanced_cloudscapes/atmosphere_top_tint",3,{},"Atmosphere Top Tint",{},{0,1.0},{},1,2,7},             -- #36,Defaults 0.45, 0.675, 1.0
	{"enhanced_cloudscapes/atmospheric_blending",1,{},"Atmospheric Blending",{},{0,1.0},{},1,3,7},           -- #37,Default 0.675    
	{"enhanced_cloudscapes/rendering_resolution_ratio",1,{},"Rendering Resolution Ratio",{},{0,1.0},{},1,1,8},    -- #38,Default 0.7    
	{"enhanced_cloudscapes/skip_fragments",1,{},"Skip Fragments",{},{0,10.0},{},1,1,8},                           -- #39,Default 1.0    
  }
function ECC_Log_Write(string)
	print(string)
end

function ECC_Notification(messagestring,messagetype,writelog)
    print(messagestring .." = ".. messagetype)
end

function ECC_Clouds_LineSplit(input,delim)
	ECC_Clouds_LineSplitResult = {}
	--print(input)
	for i in string.gmatch(input,delim) do table.insert(ECC_Clouds_LineSplitResult,i) end
	--print("ECC_Clouds_LineSplitResult: "..table.concat(ECC_Clouds_LineSplitResult,",",1,#ECC_Clouds_LineSplitResult))
	return ECC_Clouds_LineSplitResult
end

function ECC_PresetFileRead()
    local file = io.open(ECC_PresetFile, "r")
    if file then
        ECC_Log_Write("FILE INIT READ: "..ECC_PresetFile)
        local i = 0
        local temptable = { }
        for line in file:lines() do
            if string.match(line,"^enhanced") then
                ECC_Clouds_LineSplit(line,"([^;]+)")
                temptable[#temptable+1] = ECC_Clouds_LineSplitResult
                -- Dataref to look for
                temptable[#temptable][1] = tostring(temptable[#temptable][1])
                ECC_Clouds_LineSplit(temptable[#temptable][2],"([^,]+)")
                -- Current values
                temptable[#temptable][2] = {}
                for j=1,#ECC_Clouds_LineSplitResult do
                    temptable[#temptable][2][j-1] = tonumber(ECC_Clouds_LineSplitResult[j])
                end
                -- Caption
                -- Value rangle limits
                ECC_Clouds_LineSplit(temptable[#temptable][4],"([^,]+)")
                temptable[#temptable][4] = {}
                for j=1,#ECC_Clouds_LineSplitResult do
                    temptable[#temptable][4][j] = tonumber(ECC_Clouds_LineSplitResult[j])
                end
                -- Display in percent true/false
                temptable[#temptable][5] = tonumber(temptable[#temptable][5])
                -- Display precision
                temptable[#temptable][6] = tonumber(temptable[#temptable][6])
                -- Group
                temptable[#temptable][7] = tonumber(temptable[#temptable][7])
            end
            i = i+1
        end
        for j=1,#temptable do
           for k=1,#ECC_Cld_DRefs do
                if temptable[j][1] == ECC_Cld_DRefs[k][1] then 
                    -- print("Match temptable "..temptable[j][1].." with Dref table "..ECC_Cld_DRefs[k][1].." at "..k)
                    ECC_Cld_DRefs[k][3] = temptable[j][2] -- Current value(s)
                    ECC_Cld_DRefs[k][4] = temptable[j][3] -- Caption
                    ECC_Cld_DRefs[k][6] = temptable[j][4] -- Value range limits
                    ECC_Cld_DRefs[k][8] = temptable[j][5] -- Display in percent
                    ECC_Cld_DRefs[k][9] = temptable[j][6] -- Display precision
                    ECC_Cld_DRefs[k][10] = temptable[j][7] -- Group
                    
                end
           end
        end
        --[[for j=1,#temptable do
            print(type(temptable[j][1])..": "..temptable[j][1].." ; "..type(temptable[j][2])..": "..table.concat(temptable[j][2],",",0).." ; "..type(temptable[j][3])..": "..temptable[j][3].." ; "..type(temptable[j][4])..": "..table.concat(temptable[j][4],",").." ; "..type(temptable[j][5])..": "..temptable[j][5].." ; "..type(temptable[j][6])..": "..temptable[j][6].." ; "..type(temptable[j][7])..": "..temptable[j][7])
        end]]
        file:close()
		if i ~= nil and i > 0 then ECC_Notification("FILE READ SUCCESS: "..ECC_PresetFile,"Success","log") else ECC_Notification("FILE READ ERROR: "..ECC_PresetFile,"Error","log") end
    else
        ECC_Notification("FILE NOT FOUND: "..ECC_PresetFile,"Error","log")
		--ECC_Check_AutoLoad = false
	end   
end

EC_drefs={}
for i=1,#ECC_Cld_DRefs do
    EC_drefs[ECC_Cld_DRefs[i][1]]=find_dataref(ECC_Cld_DRefs[i][1])
end

function ECC_AccessDref(intable,mode)
    print("ECC_AccessDref")
    for i=1,#intable do
        print(ECC_Cld_DRefs[i][1])
       
        if EC_drefs[ECC_Cld_DRefs[i][1]]~= nil then
            if intable[i][2] == 1 then
                    --print(XPLMGetDataRefTypes(dref))
                --print(i.." : "..intable[i][3][0]) 
                if mode == "write" then 
                    print(intable[i][1])
                    print("=" .. " to " .. intable[i][3][0])
                    EC_drefs[ECC_Cld_DRefs[i][1]] = intable[i][3][0]
                    
                end
            else

                --print(i.." : "..table.concat(intable[i][3],", ",0))
                if mode == "write" then 
                    print(intable[i][1] .. ":")
                    if type(EC_drefs[ECC_Cld_DRefs[i][1]])~="number" then
                        for n=0,intable[i][2]-1 do
                            print(n.."="..EC_drefs[ECC_Cld_DRefs[i][1]][n] .. " to " .. intable[i][3][n])
                            EC_drefs[ECC_Cld_DRefs[i][1]][n] = intable[i][3][n]
                        end
                    end
                end
            end
        end
    end
end
ECC_Log_Write("ECC PRESET: Started loading values from file")
ECC_PresetFileRead()                        -- Read preset file

function setDrefs()
    print("setting drefs now")
    ECC_AccessDref(ECC_Cld_DRefs,"write")       -- Write values to datarefs
end

