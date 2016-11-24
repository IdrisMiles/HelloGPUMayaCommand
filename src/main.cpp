#include <maya/MFnPlugin.h>

#include "include/helloGPUMaya.h"


MStatus initializePlugin(MObject obj)
{
    MFnPlugin plugin(obj, HelloGPUMayaCommand::s_author, HelloGPUMayaCommand::s_pluginVersion, HelloGPUMayaCommand::s_mayaVersion);
    MStatus status = plugin.registerCommand(HelloGPUMayaCommand::s_commandName, HelloGPUMayaCommand::creator);

    CHECK_MSTATUS_AND_RETURN_IT(status);
    return status;
}


MStatus uninitializePlugin(MObject obj)
{
    MFnPlugin plugin(obj);
    MStatus status = plugin.deregisterCommand(HelloGPUMayaCommand::s_commandName);

    CHECK_MSTATUS_AND_RETURN_IT(status);
    return status;
}
