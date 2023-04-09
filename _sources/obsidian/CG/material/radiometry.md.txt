radiometry
#pbr

Radiometry is the measurement of electromagnetic radiation

	放射束(Radiant flux) =>  Φ Watt
波長が異なる光線の集まり(390nm to 700nm)
[https://learnopengl.com/img/pbr/daylight_spectral_distribution.png]

	Solid angle => ω

	Radiant intensity => I
		the amount of radiant flux per solid angle
		I=dΦ/dω

	放射輝度(Radiance) => L
		L=d2ΦdAdωcosθ

	irradiance

code:.cpp
 
 int steps = 100;
 float sum = 0.0f;
 vec3 P    = ...;
 vec3 Wo   = ...;
 vec3 N    = ...;
 float dW  = 1.0f / steps;
 for(int i = 0; i < steps; ++i) 
 {
     vec3 Wi = getNextIncomingLightDir(i);
     sum += Fr(P, Wi, Wo) * L(P, Wi) * dot(N, Wi) * dW;
 }

BRDF
Trowbridge-Reitz GGX
