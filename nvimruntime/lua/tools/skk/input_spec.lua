local Context = require "tools.skk.context"

local State = {}

---@param input string
---@param expect string
local function test(input, expect)
  assert.are.equals(expect, State.context:kanaInput(input))
end

describe("Tests for input.lua", function()
  before_each(function()
    State.context = Context.new()
  end)

  it("single char", function()
    test("ka", "か")
  end)

  it("multiple chars (don't use tmpResult)", function()
    test("ohayou", "おはよう")
  end)

  it("multiple chars (use tmpResult)", function()
    test("amenbo", "あめんぼ")
  end)

  it("multiple chars (use tmpResult and its next)", function()
    test("uwwwa", "うwっわ")
  end)

  it("mistaken input", function()
    test("rkakyra", "から")
  end)
end)
