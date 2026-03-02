#include <Windows.h>

#pragma optimize("", off)

template<typename T>
void ProvideSymbol()
{
    T instance{};
}

__declspec(dllexport) void ProvideSymbolsHere()
{
    // .reload /f /v sp.dll=0x7FFFF0000000

    struct TestType
    {
        int i;
    };

    ProvideSymbol<TestType>();
}

#pragma optimize("", on)

BOOL WINAPI DllMain(HINSTANCE, DWORD, LPVOID)
{
    return TRUE;
}
