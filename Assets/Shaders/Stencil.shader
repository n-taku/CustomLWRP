Shader "Unlit/Stencil"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "Queue" = "Transparent"}
        Pass
        {
            Tags { "LightMode" = "LightweightForward"}
            LOD 100
            Cull Front
            ZWrite Off
            ColorMask 0
            ZTest Always
            Blend SrcAlpha OneMinusSrcAlpha 
            Stencil{
                Ref 1
                Comp always
                Pass replace
            }
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                v.vertex += float4(v.normal * 0.1f, 0);   
                o.vertex = UnityObjectToClipPos(v.vertex); 
                return o;
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                return fixed4(0, 1, 0, 1);
            }
            ENDCG
        }

        Pass
        {
            Tags { "LightMode" = "LightweightForward2" }
            LOD 100
            Cull Back
            ZWrite Off
            ZTest Always
            Blend SrcAlpha OneMinusSrcAlpha 
            Stencil{
                Ref 2
                Comp always
                Pass replace
            }
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 normal : NORMAL;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                return o;
            }
            
            fixed4 frag (v2f i) : SV_Target
            {                
                fixed4 col = fixed4(1, 1, 0, 1);
                return col;
            }
            ENDCG
        }
        
        Pass
        {
            Tags { "LightMode" = "LightweightForward3"}
            LOD 100
            Cull Front
            ZWrite Off 
            ZTest Always
            Blend SrcAlpha OneMinusSrcAlpha 
            Stencil{
                Ref 1
                Comp Equal
            }
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                v.vertex += float4(v.normal * 0.1f, 0);   
                o.vertex = UnityObjectToClipPos(v.vertex); 
                return o;
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = fixed4(0, 0, 1, 1);
                return col;
            }
            ENDCG
        }
    }
}
