fp64 = require("fp64")

local f = fp64.new(5.259451158)

print(fp64.debug(f))

local test = {
    testNumber = function()
        local a = 1 / 3;
        local b = 1 / 3;
        local c = 1 / 3;
        local d = a + b * 2;
        print("a:",a, type(a))
        print("d:",d, type(d))
    end,

    testType = function()
        print("f:",f, type(f))
    end,

    testNumberSpread = function()
        local a = 1.0000
        local b = fp64.new(5.259451158)
        local c = b + a
        local d = (a + b) * 100 / 100
        print("c:",c, type(c), c:ceil())
        print("d:",d, type(d))
    end,

    testBasic = function()
        f= f / 5
        f = -f
        f = f * 3
        f= f:sin()
        print(f + fp64.pi)
        print(fp64.tan(6))
        print(f:tonumber())
        print(f:hex())
        local s = fp64.sqrt(fp64.e)
        print(s:log())
        print(fp64.log2(2 ^ 10))
    end,

    testNumberCeil = function()
        local a = fp64.new(5.259451158)
        local d = a:tonumber()

        -- local e = math.ceil(a)
        local e = a:ceil()
        print("e:",e, type(e))
        print("d:",d, type(d))
    end,

    -- 内存使用测试
    testMemory = function()
        print("========== 内存使用测试 ==========")
        collectgarbage("collect")
        local mem1 = collectgarbage("count")

        -- 检查是否启用了USELIGHTUSERDATA
        local status, type_name, type_id = fp64.debug(fp64.new(1))
        print("status:", status)
        print("type_name:", type_name)
        print("type_id:", type_id)

        -- 创建大量lightuserdata对象
        local objects = {}
        for i = 1, 100000 do
            objects[i] = fp64.new(i)
        end

        collectgarbage("collect")
        local mem2 = collectgarbage("count")

        -- for i = 1, 100000 do
        --     print(objects[i]:tonumber())
        -- end
        print("lightuserdata memory:", mem2 - mem1, "KB")
    end,

    -- 相同值测试
    testSameValue = function()
        local f = fp64.new(123.456)
        print("fp64:", f:tonumber())
        print("hex:", f:hex())

        -- 检查是否真的是值存储
        local same_value = fp64.new(123.456)
        print("same_value:", same_value:tonumber())
        print("hex:", same_value:hex())
    end,
}


for k,v in pairs(test) do
    print("==========run:",k)
    v()
    print("==========end ==========")
end