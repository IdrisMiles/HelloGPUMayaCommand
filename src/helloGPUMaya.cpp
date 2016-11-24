#include "include/helloGPUMaya.h"

const char* HelloGPUMayaCommand::s_commandName = "helloGPUMaya";
const char* HelloGPUMayaCommand::s_author = "Idris Miles";
const char* HelloGPUMayaCommand::s_pluginVersion = "1.0";
const char* HelloGPUMayaCommand::s_mayaVersion = "Any";

HelloGPUMayaCommand::HelloGPUMayaCommand()
{

}

MStatus HelloGPUMayaCommand::doIt(const MArgList&)
{
    MGlobal::displayInfo("Hello GPU Maya!");
    return MS::kSuccess;
}

void* HelloGPUMayaCommand::creator()
{
    return new HelloGPUMayaCommand();
}
