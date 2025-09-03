fp64 = require("fp64")

old_tonumber = tonumber
tonumber = function(obj)
    if type(obj) == "userdata" and obj.tonumber then
        return obj:tonumber()
    else
        return old_tonumber(obj)
    end
end

local f = fp64.new(5.259451158)

print(fp64.debug(f))

local test = {
    testNew = function()
        local fnew = fp64.new(fp64.new(5.259451158))
        print(fnew:tonumber())
    end,

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

        f2 = f.new(f.new(2.6))
        f3 = f.new(2)
        print("f * f2:", f2 * 2, f2 * f3, type(f2 * 2), type(f2 * f3))

        f4 = f.new(f.new(2.6))
        f5 = f.new(1.3)
        print("f * f2:", f4 / 1.3, f4 / f5, type(f4 / 1.3), type(f4 / f5))
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

    testCompare = function()
        local f = fp64.new(123.456)
        local g = fp64.new(123.456)
        print("f == g:", f == g)
        print("f < g:", f < g)
        print("f > g:", f > g)

        local h = fp64.new(123)
        local i = 123

                    -- 检查元表
        local mt_h = getmetatable(h)
        if mt_h then
            print("h has metatable")
            if mt_h.__eq then
                print("h has __eq metamethod")
                print("h.__eq type:", type(mt_h.__eq))
            else
                print("h does NOT have __eq metamethod")
            end
        else
            print("h has no metatable")
        end

                -- 检查i的元表
        local mt_i = getmetatable(i)
        print("i metatable:", mt_i)

        print("h type:", type(h))
        print("i type:", type(i))
        print("h value:", h:tonumber())
        print("tonumber(h):", tonumber(h))
        print("i value:", i)
        
        print("h == i:", h == i)
        print("i == h:", i == h)
        print("h ~= i:", h ~= i)
        print("tonumber(h) == tonumber(i):", tonumber(h) == tonumber(i))
        print("h == i equals call:", h:equals(i))
        print("h < i:", h < i)
        print("h > i:", h > i)
        print("h <= i:", h <= i)
        print("h >= i:", h >= i)
    end,
}

for k,v in pairs(test) do
    print("==========run:",k)
    v()
    print("==========end ==========")
    print("")
end