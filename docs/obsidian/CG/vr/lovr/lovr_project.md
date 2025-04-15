`main.lua`

````lua
local model

local customVertex = [[
    vec4 lovrmain()
    {
        return Projection * View * Transform * VertexPosition;
    }
]]

local defaultFragment = [[
    Constants {
        vec4 ambience;
        vec4 lightColor;
        vec3 lightPos;
    };

    vec4 lovrmain()
    {
        //diffuse
        vec3 norm = normalize(Normal);
        vec3 lightDir = normalize(lightPos - PositionWorld);
        float diff = max(dot(norm, lightDir), 0.0);
        vec4 diffuse = diff * lightColor;

        vec4 baseColor = Color * getPixel(ColorTexture, UV);
        return baseColor * (ambience + diffuse);
    }
]]

local shader = lovr.graphics.newShader(customVertex, defaultFragment, {})

function lovr.load()
  -- Load a 3D model
  model = lovr.graphics.newModel "monkey.obj"

  -- Use a dark grey background
  lovr.graphics.setBackgroundColor(0.2, 0.2, 0.2)
end

function lovr.draw(pass)
  -- Draw the model
  pass:setColor(1, 1, 1)
  pass:setShader(shader)
  pass:send("ambience", { 0.2, 0.2, 0.2, 1.0 })
  pass:send("lightColor", { 1.0, 1.0, 1.0, 1.0 })
  pass:send("lightPos", { 2.0, 5.0, 0.0 })
  pass:draw(model, -0.5, 1, -3)

  -- Draw a red cube using the "cube" primitive
  pass:setColor(1, 0, 0)
  pass:cube(0.5, 1, -3, 0.5, lovr.timer.getTime())

  return false
end
```


````

