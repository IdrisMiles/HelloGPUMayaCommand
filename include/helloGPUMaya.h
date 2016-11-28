#ifndef _HELLOMAYA__H_
#define _HELLOMAYA__H_


// Maya include
#include <maya/MArgList.h>
#include <maya/MObject.h>
#include <maya/MGlobal.h>
#include <maya/MPxCommand.h>


class HelloGPUMayaCommand : public MPxCommand
{
public:
    HelloGPUMayaCommand();
    virtual MStatus doIt(const MArgList&);
    static void* creator();

    static const char* s_commandName;
    static const char* s_author;
    static const char* s_pluginVersion;
    static const char* s_mayaVersion;
};

#endif //_HELLOMAYA__H_
