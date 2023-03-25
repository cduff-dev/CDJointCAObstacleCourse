cbuffer View
{
    row_major float4x4 View_View_TranslatedWorldToClip : packoffset(c0);
    float3 View_View_ViewTilePosition : packoffset(c60);
    float3 View_View_RelativePreViewTranslation : packoffset(c72);
    uint View_View_InstanceSceneDataSOAStride : packoffset(c277);
};

ByteAddressBuffer View_PrimitiveSceneData;
ByteAddressBuffer View_InstanceSceneData;
ByteAddressBuffer InstanceCulling_InstanceIdsBuffer;
cbuffer LocalVF
{
    int4 LocalVF_LocalVF_VertexFetch_Parameters : packoffset(c0);
};

Buffer<float4> LocalVF_VertexFetch_TexCoordBuffer;
Buffer<float4> LocalVF_VertexFetch_PackedTangentsBuffer;

static float4 gl_Position;
static int gl_VertexIndex;
static int gl_InstanceIndex;
static float4 in_var_ATTRIBUTE0;
static uint in_var_ATTRIBUTE13;
static float4 out_var_TEXCOORD10_centroid;
static float4 out_var_TEXCOORD11_centroid;
static float4 out_var_TEXCOORD0[1];
static uint out_var_PRIMITIVE_ID;
static float4 out_var_TEXCOORD6;

struct SPIRV_Cross_Input
{
    float4 in_var_ATTRIBUTE0 : ATTRIBUTE0;
    uint in_var_ATTRIBUTE13 : ATTRIBUTE13;
    uint gl_VertexIndex : SV_VertexID;
    uint gl_InstanceIndex : SV_InstanceID;
};

struct SPIRV_Cross_Output
{
    float4 out_var_TEXCOORD10_centroid : TEXCOORD10_centroid;
    float4 out_var_TEXCOORD11_centroid : TEXCOORD11_centroid;
    float4 out_var_TEXCOORD0[1] : TEXCOORD0;
    nointerpolation uint out_var_PRIMITIVE_ID : PRIMITIVE_ID;
    float4 out_var_TEXCOORD6 : TEXCOORD6;
    precise float4 gl_Position : SV_Position;
};

static float3x3 _98 = float3x3(0.0f.xxx, 0.0f.xxx, 0.0f.xxx);

void vert_main()
{
    float3 _108 = -View_View_ViewTilePosition;
    uint _127 = 0u;
    if ((in_var_ATTRIBUTE13 & 2147483648u) != 0u)
    {
        _127 = uint(int(asuint(asfloat(View_PrimitiveSceneData.Load4(((in_var_ATTRIBUTE13 & 2147483647u) * 40u) * 16 + 0)).y))) + uint(gl_InstanceIndex);
    }
    else
    {
        _127 = InstanceCulling_InstanceIdsBuffer.Load((in_var_ATTRIBUTE13 + uint(gl_InstanceIndex)) * 4 + 0) & 268435455u;
    }
    uint _133 = asuint(asfloat(View_InstanceSceneData.Load4(_127 * 16 + 0)).x);
    uint _135 = (_133 << 12u) >> 12u;
    float3 _249 = 0.0f.xxx;
    float4x4 _250 = float4x4(0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx);
    float3 _251 = 0.0f.xxx;
    float _252 = 0.0f;
    [branch]
    if (false || (_135 != 1048575u))
    {
        uint4 _149 = asuint(asfloat(View_InstanceSceneData.Load4((View_View_InstanceSceneDataSOAStride + _127) * 16 + 0)));
        uint _151 = (2u * View_View_InstanceSceneDataSOAStride) + _127;
        float4x4 _155 = float4x4(0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx);
        _155[3] = float4(asfloat(View_InstanceSceneData.Load4(_151 * 16 + 0)).x, asfloat(View_InstanceSceneData.Load4(_151 * 16 + 0)).y, asfloat(View_InstanceSceneData.Load4(_151 * 16 + 0)).z, 0.0f.xxxx.w);
        float4x4 _156 = _155;
        _156[3].w = 1.0f;
        uint _157 = _149.x;
        uint _164 = _149.y;
        float _167 = float((_164 >> 0u) & 32767u);
        float2 _171 = (float3(float((_157 >> 0u) & 65535u), float((_157 >> 16u) & 65535u), _167).xy - 32768.0f.xx) * 3.0518509447574615478515625e-05f;
        float _173 = (_167 - 16384.0f) * 4.3161006033187732100486755371094e-05f;
        bool _175 = (_164 & 32768u) != 0u;
        float _176 = _171.x;
        float _177 = _171.y;
        float _178 = _176 + _177;
        float _179 = _176 - _177;
        float3 _185 = normalize(float3(_178, _179, 2.0f - dot(1.0f.xx, abs(float2(_178, _179)))));
        float4 _186 = float4(_185.x, _185.y, _185.z, 0.0f.xxxx.w);
        float4x4 _187 = _156;
        _187[2] = _186;
        float _190 = 1.0f / (1.0f + _185.z);
        float _191 = _185.x;
        float _192 = -_191;
        float _193 = _185.y;
        float _195 = (_192 * _193) * _190;
        float _207 = sqrt(1.0f - (_173 * _173));
        float3 _212 = (float3(1.0f - ((_191 * _191) * _190), _195, _192) * (_175 ? _173 : _207)) + (float3(_195, 1.0f - ((_193 * _193) * _190), -_193) * (_175 ? _207 : _173));
        float4 _213 = float4(_212.x, _212.y, _212.z, 0.0f.xxxx.w);
        float4x4 _214 = _187;
        _214[0] = _213;
        float3 _217 = cross(_185.xyz, _212.xyz);
        float4 _218 = float4(_217.x, _217.y, _217.z, 0.0f.xxxx.w);
        float4x4 _219 = _214;
        _219[1] = _218;
        uint _220 = _149.w;
        uint _225 = _149.z;
        float3 _233 = (float3(uint3(_225 >> 0u, _225 >> 16u, _220 >> 0u) & uint3(65535u, 65535u, 65535u)) - 32768.0f.xxx) * asfloat(((_220 >> 16u) - 15u) << 23u);
        float4x4 _236 = _219;
        _236[0] = _213 * _233.x;
        float4x4 _239 = _236;
        _239[1] = _218 * _233.y;
        float4x4 _242 = _239;
        _242[2] = _186 * _233.z;
        _249 = 1.0f.xxx / abs(_233).xyz;
        _250 = _242;
        _251 = asfloat(View_PrimitiveSceneData.Load4(((_135 * 40u) + 1u) * 16 + 0)).xyz;
        _252 = (((_133 >> 20u) & 1u) != 0u) ? (-1.0f) : 1.0f;
    }
    else
    {
        _249 = 0.0f.xxx;
        _250 = float4x4(0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx, 0.0f.xxxx);
        _251 = 0.0f.xxx;
        _252 = 0.0f;
    }
    uint _256 = uint(LocalVF_LocalVF_VertexFetch_Parameters.w) + uint(gl_VertexIndex);
    uint _257 = 2u * _256;
    float4 _262 = LocalVF_VertexFetch_PackedTangentsBuffer.Load(_257 + 1u);
    float _263 = _262.w;
    float3 _264 = _262.xyz;
    float3 _266 = cross(_264, LocalVF_VertexFetch_PackedTangentsBuffer.Load(_257).xyz) * _263;
    float3x3 _269 = _98;
    _269[0] = cross(_266, _264) * _263;
    float3x3 _270 = _269;
    _270[1] = _266;
    float3x3 _271 = _270;
    _271[2] = _264;
    float3x3 _281 = float3x3(_250[0].xyz, _250[1].xyz, _250[2].xyz);
    _281[0] = _250[0].xyz * _249.x;
    float3x3 _284 = _281;
    _284[1] = _250[1].xyz * _249.y;
    float3x3 _287 = _284;
    _287[2] = _250[2].xyz * _249.z;
    float3x3 _288 = mul(_271, _287);
    float3 _291 = in_var_ATTRIBUTE0.xxx * _250[0].xyz;
    float3 _293 = in_var_ATTRIBUTE0.yyy * _250[1].xyz;
    float3 _294 = _291 + _293;
    float3 _296 = in_var_ATTRIBUTE0.zzz * _250[2].xyz;
    float3 _297 = _294 + _296;
    float3 _300 = _297 + _250[3].xyz;
    float3 _301 = _251 + _108;
    float3 _302 = _300 + View_View_RelativePreViewTranslation;
    float3 _303 = _301 * 2097152.0f;
    float3 _304 = _303 + _302;
    float _305 = _304.x;
    float _306 = _304.y;
    float _307 = _304.z;
    float4 _308 = float4(_305, _306, _307, 1.0f);
    uint _311 = uint(LocalVF_LocalVF_VertexFetch_Parameters.y);
    float4 _317 = LocalVF_VertexFetch_TexCoordBuffer.Load((_311 * _256) + min(0u, (_311 - 1u)));
    float4 _318 = float4(_308.x, _308.y, _308.z, _308.w);
    float4 _321 = mul(_318, View_View_TranslatedWorldToClip);
    float4 _333[1] = { float4(_317.x, _317.y, 0.0f.xxxx.z, 0.0f.xxxx.w) };
    out_var_TEXCOORD10_centroid = float4(_288[0], 0.0f);
    out_var_TEXCOORD11_centroid = float4(_288[2], _263 * _252);
    out_var_TEXCOORD0 = _333;
    out_var_PRIMITIVE_ID = _135;
    out_var_TEXCOORD6 = _318;
    gl_Position = _321;
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_VertexIndex = int(stage_input.gl_VertexIndex);
    gl_InstanceIndex = int(stage_input.gl_InstanceIndex);
    in_var_ATTRIBUTE0 = stage_input.in_var_ATTRIBUTE0;
    in_var_ATTRIBUTE13 = stage_input.in_var_ATTRIBUTE13;
    vert_main();
    SPIRV_Cross_Output stage_output;
    stage_output.gl_Position = gl_Position;
    stage_output.out_var_TEXCOORD10_centroid = out_var_TEXCOORD10_centroid;
    stage_output.out_var_TEXCOORD11_centroid = out_var_TEXCOORD11_centroid;
    stage_output.out_var_TEXCOORD0 = out_var_TEXCOORD0;
    stage_output.out_var_PRIMITIVE_ID = out_var_PRIMITIVE_ID;
    stage_output.out_var_TEXCOORD6 = out_var_TEXCOORD6;
    return stage_output;
}
