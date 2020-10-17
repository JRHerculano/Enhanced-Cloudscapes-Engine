local transitionTimeSecs=30
local cloudheightMod=2



cldDR_cloud_base_datarefs = find_dataref("enhanced_cloudscapes/weather/cloud_base_msl_m")
cldDR_cloud_type_datarefs = find_dataref("enhanced_cloudscapes/weather/cloud_type")
cldDR_cloud_tops_datarefs = find_dataref("enhanced_cloudscapes/weather/cloud_tops_msl_m")
cldDR_cloud_density_datarefs = find_dataref("enhanced_cloudscapes/weather/density")
cldDR_cloud_coverage_datarefs = find_dataref("enhanced_cloudscapes/weather/coverage")
cldDR_cloud_resolution_ratio = find_dataref("enhanced_cloudscapes/rendering_resolution_ratio")
simDR_gpu_time = find_dataref("sim/time/gpu_time_per_frame_sec_approx");

simDR_sun_pitch = find_dataref("sim/graphics/scenery/sun_pitch_degrees");

simDR_override_clouds=find_dataref("sim/operation/override/override_clouds")
cldDR_sun_gain = find_dataref("enhanced_cloudscapes/sun_gain")
simDR_cloud_base_datarefs={}
simDR_cloud_base_datarefs[0] = find_dataref("sim/weather/cloud_base_msl_m[0]")
simDR_cloud_base_datarefs[1] = find_dataref("sim/weather/cloud_base_msl_m[1]")
simDR_cloud_base_datarefs[2] = find_dataref("sim/weather/cloud_base_msl_m[2]")
simDR_cloud_tops_datarefs={}
simDR_cloud_tops_datarefs[0] = find_dataref("sim/weather/cloud_tops_msl_m[0]")
simDR_cloud_tops_datarefs[1] = find_dataref("sim/weather/cloud_tops_msl_m[1]")
simDR_cloud_tops_datarefs[2] = find_dataref("sim/weather/cloud_tops_msl_m[2]")
simDR_cloud_type_datarefs={}
simDR_cloud_type_datarefs[0] = find_dataref("sim/weather/cloud_type[0]")
simDR_cloud_type_datarefs[1] = find_dataref("sim/weather/cloud_type[1]")
simDR_cloud_type_datarefs[2] = find_dataref("sim/weather/cloud_type[2]")

simDR_cloud_coverage_datarefs={}
simDR_cloud_coverage_datarefs[0] = find_dataref("sim/weather/cloud_coverage[0]")
simDR_cloud_coverage_datarefs[1] = find_dataref("sim/weather/cloud_coverage[1]")
simDR_cloud_coverage_datarefs[2] = find_dataref("sim/weather/cloud_coverage[2]")

simDR_whiteout = find_dataref("sim/private/controls/skyc/white_out_in_clouds")
simDR_fog = find_dataref("sim/private/controls/fog/fog_be_gone")
simDR_dsf_min = find_dataref("sim/private/controls/skyc/min_dsf_vis_ever")
simDR_dsf_max = find_dataref("sim/private/controls/skyc/max_dsf_vis_ever")
simDRTime=find_dataref("sim/time/total_running_time_sec")
simDR_VR=find_dataref("sim/graphics/VR/enabled")

l_ref=find_dataref("sim/flightmodel/position/lat_ref")
r_ref=find_dataref("sim/flightmodel/position/lon_ref")

last_l=l_ref
last_r=r_ref

cldI_cloud_base_datarefs = {};
--cldI_cloud_type_datarefs = {};
cldI_cloud_tops_datarefs = {};
cldI_cloud_density_datarefs = {};
cldI_cloud_coverage_datarefs = {};
cldI_sun_gain = 3.25;
cldT_cloud_base_datarefs = {};
--cldT_cloud_type_datarefs = {};
cldT_cloud_tops_datarefs = {};
cldT_cloud_density_datarefs = {};
cldT_cloud_coverage_datarefs = {};
cldT_sun_gain = 3.25;

function deferred_command(name,desc,realFunc)
	return replace_command(name,realFunc)
end

function animate_value(current_value, target, min, max, speed)

    local fps_factor = math.min(0.001, speed * SIM_PERIOD)

    if target >= (max - 0.001) and current_value >= (max - 0.01) then
        return max
    elseif current_value <= (min - 0.01) then
       return min
    else
        return current_value + ((target - current_value) * fps_factor)
    end

end
local lastUpdate=0;

function interpolate_value(initial_value, target)
    local diff=simDRTime-lastUpdate
    local percent_complete=diff/transitionTimeSecs
    
    if percent_complete>=1.0 then return target end
   
    retVal = initial_value+(target-initial_value)*percent_complete
    --print(target .. " " .. percent_complete .. " "..retVal)
    return retVal
end


function getDensity(i)
  if simDR_cloud_type_datarefs[i]==1 then return  0.00065
  elseif simDR_cloud_type_datarefs[i]==2 then return 0.0035
  elseif simDR_cloud_type_datarefs[i]==3 then return 0.004
  elseif simDR_cloud_type_datarefs[i]==4 then return 0.004
  elseif simDR_cloud_type_datarefs[i]==5 then return 0.0045
  end
  return 0.004
end


function newWeather()
  for i = 0, 2, 1 do
    cldI_cloud_base_datarefs[i] = cldDR_cloud_base_datarefs[i];
    --cldI_cloud_type_datarefs[i] = cldDR_cloud_type_datarefs[i];
    cldI_cloud_tops_datarefs[i] = cldDR_cloud_tops_datarefs[i];
    cldI_cloud_density_datarefs[i] = cldDR_cloud_density_datarefs[i];
    cldI_cloud_coverage_datarefs[i] = cldDR_cloud_coverage_datarefs[i];
    cldI_sun_gain=cldDR_sun_gain
    
    cldT_cloud_base_datarefs[i]=simDR_cloud_base_datarefs[i]
    --if cldDR_cloud_type_datarefs[i]>1 and simDR_cloud_coverage_datarefs[i]>0 then 
    if simDR_cloud_coverage_datarefs[i]>0 then   
      cldT_cloud_tops_datarefs[i]=simDR_cloud_tops_datarefs[i]
      cldT_cloud_coverage_datarefs[i]=math.min(((simDR_cloud_coverage_datarefs[i]-1) /5),1.0)
      cldT_sun_gain=3.25
      cldT_cloud_density_datarefs[i]=getDensity(i)
    --elseif cldDR_cloud_type_datarefs[i]>0 and simDR_cloud_coverage_datarefs[i]>0  then --scattered few and cirrus
    elseif simDR_cloud_coverage_datarefs[i]>0  then --scattered few and cirrus
        cldT_cloud_tops_datarefs[i]=cldDR_cloud_tops_datarefs[i]+500
	cldT_cloud_coverage_datarefs[i]=math.min(((simDR_cloud_coverage_datarefs[i]-1) /5),1.0)
	cldT_sun_gain=3.25
	cldT_cloud_density_datarefs[i]=getDensity(i)
    else
	cldT_cloud_base_datarefs[i] = cldDR_cloud_tops_datarefs[i]
-- 	cldI_cloud_tops_datarefs[i] = cldDR_cloud_tops_datarefs[i]
-- 	cldI_cloud_density_datarefs[i] = cldDR_cloud_density_datarefs[i]
-- 	cldI_cloud_coverage_datarefs[i] = cldDR_cloud_coverage_datarefs[i]

	cldT_cloud_coverage_datarefs[i]=0
      end
      
  end
  cldI_sun_gain=cldDR_sun_gain
  lastUpdate=simDRTime
  print("New Weather")
end
function cldCMD_newWeather_CMDhandler(phase, duration)
   if phase==0 then
      newWeather()
   end
end

cldCMD_newWeather 				= deferred_command("enhanced_cloudscapes/newWeather", "EC new weather", cldCMD_newWeather_CMDhandler)
function isNewWeather()
    local retVal=false
    for i = 0, 2, 1 do
      if cldT_cloud_base_datarefs[i]~=simDR_cloud_base_datarefs[i]  and (simDR_cloud_coverage_datarefs[i]>0) then retVal=true end
      if cldDR_cloud_type_datarefs[i]>1 and cldT_cloud_tops_datarefs[i]~=simDR_cloud_tops_datarefs[i] and simDR_cloud_coverage_datarefs[i]>0 then retVal=true end
    end
    
    
    return retVal
end
dofile("presetLoader.lua")


function flight_start()
  setDrefs()
  simDR_whiteout=1
   simDR_fog=0.7
   simDR_dsf_min=100000
   --simDR_dsf_max=200000

  for i = 0, 2, 1 do
    cldT_cloud_tops_datarefs[i]=(simDR_cloud_tops_datarefs[i])
    cldT_cloud_coverage_datarefs[i]=math.min((simDR_cloud_coverage_datarefs[0]-1 /5),1.0)
    cldT_cloud_density_datarefs[i]=getDensity(i)
  end
  newWeather()
  for i = 0, 2, 1 do
    cldDR_cloud_type_datarefs[i]=simDR_cloud_type_datarefs[i]
    cldI_cloud_base_datarefs[i] = cldT_cloud_base_datarefs[i]
    cldI_cloud_tops_datarefs[i] = cldT_cloud_tops_datarefs[i]
    cldI_cloud_density_datarefs[i] = cldT_cloud_density_datarefs[i]
    cldI_cloud_coverage_datarefs[i] = cldT_cloud_coverage_datarefs[i]
   
  end
  lastUpdate=simDRTime+transitionTimeSecs-5
  cldDR_sun_gain=cldT_sun_gain
  cldI_sun_gain=cldDR_sun_gain
  after_physics()
  newWeather()
end


function refreshSIMDRs()
  
end

function after_physics()

  if last_l~=l_ref or last_r~=r_ref then
    print("teleport " .. " " .. last_l .. " " .. last_r.. " " .. l_ref .. " " .. r_ref)
    last_l=l_ref
    last_r=r_ref
    
  end


  
  local diff=simDRTime-lastUpdate
  if diff>transitionTimeSecs or isNewWeather()==true then newWeather() end
  
  if simDR_gpu_time>0.025 then
    cldDR_cloud_resolution_ratio=animate_value(cldDR_cloud_resolution_ratio,0.5,0.5,1.0,1)
  elseif simDR_gpu_time<0.010 and cldDR_cloud_resolution_ratio<1.0 then
    cldDR_cloud_resolution_ratio=animate_value(cldDR_cloud_resolution_ratio,1.0,0.95,1.0,1)
  elseif simDR_gpu_time<0.020 and cldDR_cloud_resolution_ratio<1.0 then
    cldDR_cloud_resolution_ratio=animate_value(cldDR_cloud_resolution_ratio,1.0,0.5,1.0,1)
  end
  
  local targetSungain=2.25


    local refreshVal
    for i = 0, 2, 1 do
      --print(i .. " " ..cldDR_cloud_base_datarefs[i])
      cldDR_cloud_base_datarefs[i]=interpolate_value(cldI_cloud_base_datarefs[i],cldT_cloud_base_datarefs[i])
      cldDR_cloud_tops_datarefs[i]=interpolate_value(cldI_cloud_tops_datarefs[i],cldT_cloud_tops_datarefs[i])
      refreshVal=simDR_cloud_coverage_datarefs[i]
      cldDR_cloud_coverage_datarefs[i]=interpolate_value(cldI_cloud_coverage_datarefs[i],cldT_cloud_coverage_datarefs[i])
      cldDR_cloud_density_datarefs[i]=interpolate_value(cldI_cloud_density_datarefs[i],cldT_cloud_density_datarefs[i])  
      --print(i .. " b=" .. cldDR_cloud_base_datarefs[i] .." h=" ..cldDR_cloud_tops_datarefs[i] .. " d="..diff)
      if simDR_cloud_type_datarefs[i] >0 then
	cldDR_cloud_type_datarefs[i]=simDR_cloud_type_datarefs[i]
      elseif cldDR_cloud_coverage_datarefs[i]==0.0 then
	cldDR_cloud_type_datarefs[i]=0
      end
    end
  
  
    --cldDR_sun_gain=animate_value(cldDR_sun_gain,targetSungain,1,2.25,1)
    cldDR_sun_gain=interpolate_value(cldI_sun_gain,cldT_sun_gain)
end

