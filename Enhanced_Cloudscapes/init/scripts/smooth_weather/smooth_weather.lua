function deferred_dataref(name,type,notifier)
	--print("Deffereed dataref: "..name)
	dref=XLuaCreateDataRef(name, type,"yes",notifier)
	return wrap_dref_any(dref,type) 
end

cldDR_cloud_base_datarefs = deferred_dataref("enhanced_cloudscapes/weather/cloud_base_msl_m","array[3]");
cldDR_cloud_type_datarefs = deferred_dataref("enhanced_cloudscapes/weather/cloud_type","array[3]");
cldDR_cloud_base_datarefs = deferred_dataref("enhanced_cloudscapes/weather/cloud_tops_msl_m","array[3]");
cldDR_cloud_base_datarefs = deferred_dataref("enhanced_cloudscapes/weather/density","array[3]");
cldDR_cloud_base_datarefs = deferred_dataref("enhanced_cloudscapes/weather/coverage","array[3]");


