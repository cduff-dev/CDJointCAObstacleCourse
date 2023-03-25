cbuffer View
{
    row_major float4x4 View_View_SVPositionToTranslatedWorld : packoffset(c44);
    float3 View_View_ViewTilePosition : packoffset(c60);
    float3 View_View_RelativePreViewTranslation : packoffset(c72);
    float4 View_View_BufferSizeAndInvSize : packoffset(c127);
    float View_View_PreExposure : packoffset(c130.y);
    float4 View_View_DiffuseOverrideParameter : packoffset(c131);
    float4 View_View_SpecularOverrideParameter : packoffset(c132);
    float4 View_View_NormalOverrideParameter : packoffset(c133);
    float2 View_View_RoughnessOverrideParameter : packoffset(c134);
    float View_View_OutOfBoundsMask : packoffset(c135);
    float View_View_MaterialTextureMipBias : packoffset(c138);
    float View_View_UnlitViewmodeMask : packoffset(c140);
    float View_View_RenderingReflectionCaptureMask : packoffset(c178.w);
    float View_View_ShowDecalsMask : packoffset(c190.w);
    float View_View_bCheckerboardSubsurfaceProfileRendering : packoffset(c222);
    float3 View_View_VolumetricLightmapWorldToUVScale : packoffset(c226);
    float3 View_View_VolumetricLightmapWorldToUVAdd : packoffset(c227);
    float3 View_View_VolumetricLightmapIndirectionTextureSize : packoffset(c228);
    float View_View_VolumetricLightmapBrickSize : packoffset(c228.w);
    float3 View_View_VolumetricLightmapBrickTexelSize : packoffset(c229);
};

ByteAddressBuffer View_PrimitiveSceneData;
cbuffer Material
{
    float4 Material_Material_PreshaderBuffer[2] : packoffset(c0);
};

Texture3D<uint4> View_VolumetricLightmapIndirectionTexture;
Texture3D<float4> View_DirectionalLightShadowingBrickTexture;
SamplerState View_SharedBilinearClampedSampler;
Texture2D<float4> OpaqueBasePass_DBufferATexture;
Texture2D<float4> OpaqueBasePass_DBufferBTexture;
Texture2D<float4> OpaqueBasePass_DBufferCTexture;
SamplerState OpaqueBasePass_DBufferATextureSampler;
Texture2D<float4> Material_Texture2D_0;
SamplerState Material_Texture2D_0Sampler;

static float4 gl_FragCoord;
static float4 in_var_TEXCOORD10_centroid;
static float4 in_var_TEXCOORD11_centroid;
static float4 in_var_TEXCOORD0[1];
static uint in_var_PRIMITIVE_ID;
static float4 out_var_SV_Target0;
static float4 out_var_SV_Target1;
static float4 out_var_SV_Target2;
static float4 out_var_SV_Target3;
static float4 out_var_SV_Target5;

struct SPIRV_Cross_Input
{
    float4 in_var_TEXCOORD10_centroid : TEXCOORD10_centroid;
    float4 in_var_TEXCOORD11_centroid : TEXCOORD11_centroid;
    float4 in_var_TEXCOORD0[1] : TEXCOORD0;
    nointerpolation uint in_var_PRIMITIVE_ID : PRIMITIVE_ID;
    float4 gl_FragCoord : SV_Position;
};

struct SPIRV_Cross_Output
{
    float4 out_var_SV_Target0 : SV_Target0;
    float4 out_var_SV_Target1 : SV_Target1;
    float4 out_var_SV_Target2 : SV_Target2;
    float4 out_var_SV_Target3 : SV_Target3;
    float4 out_var_SV_Target5 : SV_Target5;
};

void frag_main()
{
    float4 _162 = mul(float4(gl_FragCoord.xyz, 1.0f), View_View_SVPositionToTranslatedWorld);
    float3 _167 = (_162.xyz / _162.w.xxx) - View_View_RelativePreViewTranslation;
    float3 _175 = normalize(mul(normalize((float3(0.0f, 0.0f, 1.0f) * View_View_NormalOverrideParameter.w) + View_View_NormalOverrideParameter.xyz), float3x3(in_var_TEXCOORD10_centroid.xyz, cross(in_var_TEXCOORD11_centroid.xyz, in_var_TEXCOORD10_centroid.xyz) * in_var_TEXCOORD11_centroid.w, in_var_TEXCOORD11_centroid.xyz))) * 1.0f;
    if ((((Material_Texture2D_0.SampleBias(Material_Texture2D_0Sampler, float2(in_var_TEXCOORD0[0].x, in_var_TEXCOORD0[0].y), View_View_MaterialTextureMipBias).xy * 2.0f.xx) - 1.0f.xx).x - 0.33329999446868896484375f) < 0.0f)
    {
        discard;
    }
    float _200 = (0.5f * View_View_RoughnessOverrideParameter.y) + View_View_RoughnessOverrideParameter.x;
    uint _201 = in_var_PRIMITIVE_ID * 40u;
    float _245 = 0.0f;
    float _246 = 0.0f;
    float _247 = 0.0f;
    float3 _248 = 0.0f.xxx;
    float3 _249 = 0.0f.xxx;
    [flatten]
    if (((asuint(asfloat(View_PrimitiveSceneData.Load4(_201 * 16 + 0)).x) & 8u) != 0u) && (View_View_ShowDecalsMask > 0.0f))
    {
        float2 _218 = gl_FragCoord.xy * View_View_BufferSizeAndInvSize.zw;
        float4 _225 = OpaqueBasePass_DBufferBTexture.SampleLevel(OpaqueBasePass_DBufferATextureSampler, _218, 0.0f);
        float4 _228 = OpaqueBasePass_DBufferCTexture.SampleLevel(OpaqueBasePass_DBufferATextureSampler, _218, 0.0f);
        float _237 = _228.w;
        _245 = (_200 * _237) + _228.z;
        _246 = (0.5f * _237) + _228.y;
        _247 = _228.x;
        _248 = OpaqueBasePass_DBufferATexture.SampleLevel(OpaqueBasePass_DBufferATextureSampler, _218, 0.0f).xyz;
        _249 = normalize((_175 * _225.w) + ((_225.xyz * 2.0f) - 1.00392162799835205078125f.xxx));
    }
    else
    {
        _245 = _200;
        _246 = 0.5f;
        _247 = 0.0f;
        _248 = 0.0f.xxx;
        _249 = _175;
    }
    uint _252 = asuint(asfloat(View_PrimitiveSceneData.Load4(_201 * 16 + 0)).x);
    float _312 = 0.0f;
    [branch]
    if ((asuint(asfloat(View_PrimitiveSceneData.Load4(_201 * 16 + 0)).x) & 4u) != 0u)
    {
        float3 _280 = clamp((((View_View_ViewTilePosition * 2097152.0f) + _167) * View_View_VolumetricLightmapWorldToUVScale) + View_View_VolumetricLightmapWorldToUVAdd, 0.0f.xxx, 0.9900000095367431640625f.xxx) * View_View_VolumetricLightmapIndirectionTextureSize;
        float4 _291 = float4(View_VolumetricLightmapIndirectionTexture.Load(int4(int4(int(_280.x), int(_280.y), int(_280.z), 0).xyz, 0)));
        _312 = View_DirectionalLightShadowingBrickTexture.SampleLevel(View_SharedBilinearClampedSampler, (((_291.xyz * (View_View_VolumetricLightmapBrickSize + 1.0f)) + (frac(_280 / _291.w.xxx) * View_View_VolumetricLightmapBrickSize)) + 0.5f.xxx) * View_View_VolumetricLightmapBrickTexelSize, 0.0f).x;
    }
    else
    {
        _312 = 1.0f;
    }
    float3 _325 = ((_248 - (_248 * _247)) * View_View_DiffuseOverrideParameter.w) + View_View_DiffuseOverrideParameter.xyz;
    float3 _332 = (lerp((0.07999999821186065673828125f * _246).xxx, _248, _247.xxx) * View_View_SpecularOverrideParameter.w) + View_View_SpecularOverrideParameter.xyz;
    bool _335 = View_View_RenderingReflectionCaptureMask != 0.0f;
    float3 _340 = 0.0f.xxx;
    if (_335)
    {
        _340 = _325 + (_332 * 0.449999988079071044921875f);
    }
    else
    {
        _340 = _325;
    }
    bool3 _341 = _335.xxx;
    float3 _349 = max(lerp(0.0f.xxx, Material_Material_PreshaderBuffer[1].yzw, Material_Material_PreshaderBuffer[1].x.xxx), 0.0f.xxx);
    float3 _406 = 0.0f.xxx;
    [branch]
    if (View_View_OutOfBoundsMask > 0.0f)
    {
        float3 _380 = abs(((View_View_ViewTilePosition - asfloat(View_PrimitiveSceneData.Load4((_201 + 1u) * 16 + 0)).xyz) * 2097152.0f) + (_167 - asfloat(View_PrimitiveSceneData.Load4((_201 + 19u) * 16 + 0)).xyz));
        float3 _381 = float3(asfloat(View_PrimitiveSceneData.Load4((_201 + 18u) * 16 + 0)).w, asfloat(View_PrimitiveSceneData.Load4((_201 + 25u) * 16 + 0)).w, asfloat(View_PrimitiveSceneData.Load4((_201 + 26u) * 16 + 0)).w) + 1.0f.xxx;
        float3 _405 = 0.0f.xxx;
        if (any(bool3(_380.x > _381.x, _380.y > _381.y, _380.z > _381.z)))
        {
            float3 _401 = frac(frac(((View_View_ViewTilePosition.x + View_View_ViewTilePosition.y) + View_View_ViewTilePosition.z) * 2420.113525390625f) + (((_167.x + _167.y) + _167.z) * 0.001154000055976212024688720703125f)).xxx;
            _405 = lerp(float3(1.0f, 1.0f, 0.0f), float3(0.0f, 1.0f, 1.0f), float3(bool3(_401.x > 0.5f.xxx.x, _401.y > 0.5f.xxx.y, _401.z > 0.5f.xxx.z)));
        }
        else
        {
            _405 = _349;
        }
        _406 = _405;
    }
    else
    {
        _406 = _349;
    }
    float4 _412 = float4((lerp(0.0f.xxx, _340 + (float3(_341.x ? 0.0f.xxx.x : _332.x, _341.y ? 0.0f.xxx.y : _332.y, _341.z ? 0.0f.xxx.z : _332.z) * 0.449999988079071044921875f), View_View_UnlitViewmodeMask.xxx) + _406) * 1.0f, 0.0f);
    float4 _419 = 0.0f.xxxx;
    if (View_View_bCheckerboardSubsurfaceProfileRendering == 0.0f)
    {
        float4 _418 = _412;
        _418.w = 0.0f;
        _419 = _418;
    }
    else
    {
        _419 = _412;
    }
    float2 _424 = (frac(gl_FragCoord.xy * 0.0078125f.xx) * 128.0f) + float2(-64.3406219482421875f, -72.4656219482421875f);
    float3 _433 = (_249 * 0.5f) + 0.5f.xxx;
    float4 _435 = 0.0f.xxxx;
    _435.x = _433.x;
    float4 _437 = _435;
    _437.y = _433.y;
    float4 _439 = _437;
    _439.z = _433.z;
    float4 _440 = _439;
    _440.w = ((2.0f * float((_252 & 128u) != 0u)) + float((_252 & 256u) != 0u)) * 0.3333333432674407958984375f;
    float4 _442 = 0.0f.xxxx;
    _442.x = _248.x;
    float4 _444 = _442;
    _444.y = _248.y;
    float4 _446 = _444;
    _446.z = _248.z;
    float4 _447 = _446;
    _447.w = (frac(dot(_424.xyx * _424.xyy, float3(20.390625f, 60.703125f, 2.4281208515167236328125f))) - 0.5f) * 0.0039215688593685626983642578125f;
    float4 _448 = 0.0f.xxxx;
    _448.x = _312;
    float4 _449 = _448;
    _449.y = 1.0f;
    float4 _450 = _449;
    _450.z = 1.0f;
    float4 _451 = _450;
    _451.w = 1.0f;
    out_var_SV_Target0 = _419 * View_View_PreExposure;
    out_var_SV_Target1 = _440;
    out_var_SV_Target2 = float4(_247, _246, _245, 0.507843196392059326171875f);
    out_var_SV_Target3 = _447;
    out_var_SV_Target5 = _451;
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_FragCoord = stage_input.gl_FragCoord;
    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
    in_var_TEXCOORD10_centroid = stage_input.in_var_TEXCOORD10_centroid;
    in_var_TEXCOORD11_centroid = stage_input.in_var_TEXCOORD11_centroid;
    in_var_TEXCOORD0 = stage_input.in_var_TEXCOORD0;
    in_var_PRIMITIVE_ID = stage_input.in_var_PRIMITIVE_ID;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output.out_var_SV_Target0 = out_var_SV_Target0;
    stage_output.out_var_SV_Target1 = out_var_SV_Target1;
    stage_output.out_var_SV_Target2 = out_var_SV_Target2;
    stage_output.out_var_SV_Target3 = out_var_SV_Target3;
    stage_output.out_var_SV_Target5 = out_var_SV_Target5;
    return stage_output;
}
