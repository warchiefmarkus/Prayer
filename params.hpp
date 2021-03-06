#pragma once
#include "xmrstak/misc/environment.hpp"
#include <string>
namespace xmrstak
{
struct params
{
    static inline params& inst()
    {
        auto& env = environment::inst();
        if(env.pParams == nullptr)
            env.pParams = new params;
        return *env.pParams;
    }
    std::string executablePrefix;
    std::string binaryName;
    bool useAMD;
    bool AMDCache;
    bool useNVIDIA;
    bool useCPU;
    std::string openCLVendor;
    
    bool poolUseTls = false;
    std::string poolURL;
    bool userSetPwd = false;
    std::string poolPasswd;
    bool userSetRigid = false;
    std::string poolRigid;
    std::string poolUsername;
    bool nicehashMode = false;
    
    static constexpr int32_t httpd_port_unset = -1;
    static constexpr int32_t httpd_port_disabled = 0;
    int32_t httpd_port = httpd_port_unset;
    
    std::string currency;
    
    std::string configFile;
    std::string configFilePools;
    std::string configFileAMD;
    std::string configFileNVIDIA;
    std::string configFileCPU;
    
    bool allowUAC = true;
    std::string minerArg0;
    std::string minerArgs;
    
    int benchmark_block_version = -1;
    int benchmark_wait_sec = 30;
    int benchmark_work_sec = 60;
    
    params() :
               binaryName("xmr-stak"),
               executablePrefix(""),
               useAMD(false),
               AMDCache(false),useNVIDIA(true),
               useCPU(true),
               openCLVendor("AMD"),
               configFile("aiC.txt"),
               configFilePools("pAI.txt"),
               configFileAMD("amd.txt"),
               configFileCPU("cpu.txt"),
               configFileNVIDIA("aiNParse.txt"){}
};
}
