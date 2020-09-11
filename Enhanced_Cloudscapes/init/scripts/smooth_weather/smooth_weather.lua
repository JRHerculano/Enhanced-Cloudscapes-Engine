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
cldDR_cloud_base_datarefs = deferred_dataref("enhanced_cloudscapes/rendering_resolution_ratio","number")
cldDR_cloud_base_datarefs =1.0
cldDR_cloud_base_datarefs2 = deferred_dataref("enhanced_cloudscapes/skip_fragments","number")
cldDR_cloud_base_datarefs2 =0.0
