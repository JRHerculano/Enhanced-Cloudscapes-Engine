#ifdef IBM
#include <Windows.h>
#endif
#include "../XLua/XTLua/src/xluaplugin.h"
#include <GL/glew.h>

#include <XPLMDataAccess.h>
#include <XPLMDisplay.h>
#include <dataref_helpers.hpp>
#include <simulator_objects.hpp>
#include <plugin_objects.hpp>

#include <rendering_program.hpp>
#include <post_processing_program.hpp>

#include <cstring>

XPLMDataRef callback_type_dataref;

#ifdef IBM
BOOL APIENTRY DllMain(IN HINSTANCE dll_handle, IN DWORD call_reason, IN LPVOID reserved)
{
	return TRUE;
}
#endif

int draw_callback(XPLMDrawingPhase drawing_phase, int is_before, void* callback_reference)
{
	if ((simulator_objects::version >= 115000) || (XPLMGetDatai(callback_type_dataref) == 2))
	{
		simulator_objects::update();
		plugin_objects::update();

		rendering_program::call();
		post_processing_program::call();
	}

	return 1;
}

PLUGIN_API int XPluginStart(char* plugin_name, char* plugin_signature, char* plugin_description)
{
	std::strcpy(plugin_name, "Enhanced Cloudscapes");
	std::strcpy(plugin_signature, "mSparks.enhanced_cloudscapes_engine");
	std::strcpy(plugin_description, "Volumetric Clouds for X-Plane 11");
	XPLMCommandRef	reload_cmd=XPLMCreateCommand("xtlua/reloadvolScripts","Reload volumetric clouds xtlua scripts");
	XPLMRegisterCommandHandler(reload_cmd, reloadScripts, 1,  (void *)0);
	XTLuaXPluginStart(NULL);
	glewInit();

	simulator_objects::initialize();
	plugin_objects::initialize();

	rendering_program::initialize();
	post_processing_program::initialize();

	callback_type_dataref = XPLMFindDataRef("sim/graphics/view/plane_render_type");

	if (simulator_objects::version >= 115000) XPLMRegisterDrawCallback(draw_callback, xplm_Phase_Modern3D, 0, nullptr);
	else XPLMRegisterDrawCallback(draw_callback, xplm_Phase_Airplanes, 0, nullptr);

	return 1;
}

PLUGIN_API void XPluginStop(void)
{
	XTLuaXPluginStop();
}

PLUGIN_API int XPluginEnable(void)
{
	return XTLuaXPluginEnable();
}

PLUGIN_API void XPluginDisable(void)
{
	XTLuaXPluginDisable();
}

PLUGIN_API void XPluginReceiveMessage(XPLMPluginID sender_plugin, int message_type, void* callback_parameters)
{
	if (message_type == XPLM_MSG_PLANE_LOADED){
		notify_datarefs();
	}
	XTLuaXPluginReceiveMessage(sender_plugin,message_type,callback_parameters);
}