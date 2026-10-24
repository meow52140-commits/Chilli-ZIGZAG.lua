--========================================================
-- CHILLI + VENYX THAI - ZIGZAG V1.8.7 AUTO STEAL SELL MUTATION VENYX POPUP TELEPORT SAFE FULL MERGED
-- DIRECT SOURCE / ONE BLOCK / ANTI-FLICKER / LOW-LAG
-- V1.6 BASE / DR. SCRAMBLE SCROLL GUARD / DYNAMIC PURPLE BORDERS (2026-10-09)
-- Original translator/source preserved; visual theme never changes .Text
-- Halloween mappings / verified V1.7.9 sidebar styling retained
--========================================================

local ENV = (type(getgenv) == "function" and getgenv()) or _G
local ZIGZAG_RELEASE = "CHILLI_VENYX_ZIGZAG_V1.8.7_POPUP_AUTO_SELL"
local ZIGZAG_JOB = tostring(game.JobId or "")
local OLD = ENV.__ZIGZAG_CHILLI_STATE
-- If executor Auto Execute and a teleport queue both fire, keep the already
-- running version instead of tearing down/repainting the GUI (no flicker).
if OLD and OLD.Release == ZIGZAG_RELEASE
    and OLD.JobId == ZIGZAG_JOB and OLD.Live then
    -- If teleport's translator-only continuation happened before this full
    -- Auto Execute entry, we must start the original Chilli gameplay once.
    -- Do NOT replace the existing translator/theme state (avoids flicker).
    if OLD.Mode=="translator_only" and not OLD.GameplayAttempted then
        OLD.GameplayAttempted=true
        task.spawn(function()
            task.wait(1.2) -- Let an independently autoloaded Chilli UI appear.
            local function existingChilli()
                local roots={game:GetService("CoreGui")}
                local players=game:GetService("Players")
                if players.LocalPlayer then
                    table.insert(roots,players.LocalPlayer:WaitForChild("PlayerGui"))
                end
                if type(gethui)=="function" then
                    local ok,hui=pcall(gethui)
                    if ok and hui then table.insert(roots,hui) end
                end
                for _,root in ipairs(roots) do
                    local ok,items=pcall(function() return root:GetDescendants() end)
                    if ok then
                        for _,obj in ipairs(items) do
                            if obj:IsA("TextLabel") or obj:IsA("TextButton") then
                                local good,label=pcall(function() return obj.Text end)
                                if good and type(label)=="string" and
                                    string.lower(label):find("chilli hub",1,true) then
                                    return true
                                end
                            end
                        end
                    end
                end
                return false
            end
            if existingChilli() then return end
            local ok,err=pcall(function()
                local u="https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"
                local source=game:HttpGet(u)
                local f,syntaxError=loadstring(source)
                if type(f)~="function" then error(syntaxError or "Chilli compile failed") end
                f()
            end)
            if not ok then
                OLD.GameplayAttempted=false
                warn("[ZIGZAG HYBRID] Chilli after teleport:",err)
            else
                print("✅ [ZIGZAG HYBRID] Queued translator + Auto Execute order recovered")
            end
        end)
    end
    return
end
if OLD and type(OLD.Disconnect) == "function" then pcall(OLD.Disconnect) end
local STATE = {Connections={},Release=ZIGZAG_RELEASE,JobId=ZIGZAG_JOB,Live=true,Mode="main"}
local function Bind(connection)
    if connection then table.insert(STATE.Connections, connection) end
    return connection
end
function STATE.Disconnect()
    STATE.Live = false
    for _,connection in ipairs(STATE.Connections) do
        pcall(function() connection:Disconnect() end)
    end
    table.clear(STATE.Connections)
end
ENV.__ZIGZAG_CHILLI_STATE = STATE

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local SOURCE_URL = "https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"

-- Full translations from ZIGZAG V1.3; preserved without removing keys
local TRANSLATIONS = {
    ["Chilli Hub"] = "Chilli Hub 🇹🇭 • ZIGZAG",
    ["Farm"] = "ฟาร์ม",
    ["Player"] = "ตัวละคร",
    ["Character"] = "ตัวละคร",
    ["Predictor"] = "คาดการณ์",
    ["Progress"] = "ความคืบหน้า",
    ["Egg Finder"] = "ค้นหาไข่",
    ["Server"] = "เซิร์ฟเวอร์",
    ["Misc"] = "อื่นๆ",
    ["Webhook"] = "เว็บฮุก",
    ["Discord"] = "ดิสคอร์ด",
    ["Quick & Keys"] = "คีย์ลัด",
    ["Settings"] = "การตั้งค่า",
    ["Config"] = "คอนฟิก",
    ["WARNING"] = "คำเตือน",
    ["Credits"] = "เครดิต",
    ["Version"] = "เวอร์ชัน",
    ["Games Supported"] = "เกมที่รองรับ",
    ["Game"] = "ข้อมูลเกม",
    ["System"] = "ระบบ",
    ["Automation"] = "ระบบอัตโนมัติ",
    ["Inventory"] = "คลังของ",
    ["Theme"] = "ธีม",
    ["Filters"] = "ตัวกรอง",
    ["Filter"] = "ตัวกรอง",
    ["Actions"] = "คำสั่ง",
    ["Visuals"] = "การแสดงผล",
    ["Visual"] = "การแสดงผล",
    ["Intel"] = "ข้อมูลเซิร์ฟเวอร์",
    ["Toggle"] = "เปิด/ปิด",
    ["Lock"] = "ล็อก",
    ["Off"] = "ปิด",
    ["On"] = "เปิด",
    ["None"] = "ไม่มี",
    ["All"] = "ทั้งหมด",
    ["Any"] = "ทุกระดับ",
    ["Any Size"] = "ทุกขนาด",
    ["Select..."] = "เลือก...",
    ["Search"] = "ค้นหา",
    ["Search..."] = "ค้นหา...",
    ["Filter features..."] = "ค้นหาฟีเจอร์...",
    ["Idle"] = "ว่าง",
    ["Default"] = "ค่าเริ่มต้น",
    ["Status"] = "สถานะ",
    ["Priority"] = "ลำดับความสำคัญ",
    ["Value"] = "มูลค่า",
    ["Size"] = "ขนาด",
    ["Rarity"] = "ความหายาก",
    ["Mutation"] = "การกลายพันธุ์",
    ["Area"] = "พื้นที่",
    ["Areas"] = "พื้นที่",
    ["Sell"] = "ขาย",
    ["Favorite"] = "ถูกใจ",
    ["Unfavorite"] = "เลิกถูกใจ",
    ["Hop"] = "ย้าย",
    ["Join"] = "เข้า",
    ["Copy"] = "คัดลอก",
    ["Rejoin"] = "เข้าใหม่",
    ["Add"] = "เพิ่ม",
    ["Reset"] = "รีเซ็ต",
    ["Turn Off"] = "ปิดทั้งหมด",
    ["Save"] = "บันทึก",
    ["Import"] = "นำเข้า",
    ["Steal"] = "ขโมย",
    ["Steal Panel"] = "แผงขโมย",
    ["Basic"] = "พื้นฐาน",
    ["Common"] = "ธรรมดา",
    ["Uncommon"] = "ไม่ธรรมดา",
    ["Rare"] = "แรร์",
    ["SuperRare"] = "ซูเปอร์แรร์",
    ["Epic"] = "อีพิก",
    ["Legendary"] = "เลเจนดารี",
    ["Mythic"] = "มิธิค",
    ["Mythical"] = "มิธิค",
    ["Cosmic"] = "คอสมิก",
    ["Celestial"] = "เซเลสเชียล",
    ["Divine"] = "ดีไวน์",
    ["Superior"] = "ซูพีเรียร์",
    ["Eternal"] = "อีเทอร์นัล",
    ["Secret"] = "ซีเคร็ต",
    ["Limited"] = "ลิมิเต็ด",
    ["Exclusive"] = "เอ็กซ์คลูซีฟ",
    ["Exotic"] = "เอ็กโซติก",
    ["Titan"] = "ไททัน",
    ["Rainbow"] = "เรนโบว์",
    ["Movement"] = "การเคลื่อนที่",
    ["Speed Boost"] = "เพิ่มความเร็ว",
    ["Boost Speed"] = "ระดับความเร็ว",
    ["Anti AFK"] = "กันหลุด (Anti AFK)",
    ["Anti-AFK"] = "กันหลุด (Anti AFK)",
    ["Anti Guard"] = "ป้องกันยาม",
    ["Anti Guard Panel"] = "แผงป้องกันยาม",
    ["Anti Die"] = "ป้องกันตาย",
    ["Anti Ragdoll"] = "กันล้ม / กันกระเด็น",
    ["Anti Trap"] = "หลบกับดัก",
    ["Anti Hit"] = "ป้องกันการโจมตี",
    ["Anti Knockback"] = "กันกระเด็น",
    ["God Mode"] = "โหมดป้องกัน",
    ["GodMode"] = "โหมดป้องกัน",
    ["Invisibility"] = "ล่องหน",
    ["Makes you invisible to other players"] = "ทำให้ผู้เล่นอื่นมองไม่เห็นคุณ",
    ["No Animations"] = "ปิดแอนิเมชัน",
    ["NoClip"] = "เดินทะลุสิ่งกีดขวาง",
    ["Infinite Jump"] = "กระโดดไม่จำกัด",
    ["Fly"] = "บิน",
    ["Fly Up"] = "บินขึ้น",
    ["Fly Down"] = "บินลง",
    ["Fly Up (hold)"] = "บินขึ้น (กดค้าง)",
    ["Fly Down (hold)"] = "บินลง (กดค้าง)",
    ["Fly Speed"] = "ความเร็วบิน",
    ["Walk Speed"] = "ความเร็วเดิน",
    ["Jump Power"] = "พลังการกระโดด",
    ["Traps from other players cannot catch you"] = "กับดักของผู้เล่นอื่นจะจับคุณไม่ได้",
    ["Instant Prompts"] = "โต้ตอบทันที",
    ["Combat"] = "การต่อสู้",
    ["Auto Hit Nearest Player"] = "ออโต้ตีผู้เล่นที่ใกล้สุด",
    ["Auto Hit Egg Holders"] = "ออโต้ตีผู้เล่นที่ถือไข่",
    ["Auto Hit Specific Player"] = "ออโต้ตีผู้เล่นที่เลือก",
    ["Hit Player"] = "เลือกผู้เล่นที่จะตี",
    ["Hit Aura"] = "ตีรอบตัว",
    ["Hit Tween Speed"] = "ความเร็ววาร์ปตอนตี",
    ["Hit Max Speed"] = "ความเร็วสูงสุดตอนตี",
    ["Chase Settings"] = "ตั้งค่าการไล่ตาม",
    ["Hit Lead"] = "ระยะนำเป้าหมาย",
    ["Stand further ahead of the target (+) or closer to them (-)"] = "ยืนล้ำหน้าเป้าหมาย (+) หรือเข้าใกล้เป้าหมาย (-)",
    ["Hit Sweep"] = "ระยะกวาดตอนตี",
    ["How far you move back and forth in front of the target"] = "ระยะที่เคลื่อนที่ไป-กลับด้านหน้าเป้าหมาย",
    ["Add/Remove Hits On Quick Bar 2"] = "เพิ่ม/ลบเมนูตีในแถบด่วน 2",
    ["Pin or unpin the hit toggles on Quick Bar 2"] = "เพิ่มหรือลบสวิตช์ตีออกจากแถบด่วน 2",
    ["Performance"] = "ประสิทธิภาพ",
    ["FPS Boost"] = "เพิ่ม FPS",
    ["Ultra FPS Boost"] = "เพิ่ม FPS สูงสุด",
    ["Disable 3D Render"] = "ปิดการเรนเดอร์ 3D",
    ["Disable 3D Rendering"] = "ปิดการเรนเดอร์ 3D",
    ["Farm HUD"] = "แผง HUD ฟาร์ม",
    ["Drag any panel to place it where you like"] = "ลากแผงไปวางตรงตำแหน่งที่ต้องการได้",
    ["Hide Game UI"] = "ซ่อน UI ของเกม",
    ["Showcase Cards"] = "แสดงการ์ดข้อมูล",
    ["HUD Size"] = "ขนาด HUD",
    ["Black Screen"] = "จอดำ",
    ["Low Graphics"] = "กราฟิกต่ำ",
    ["Limit FPS"] = "จำกัด FPS",
    ["FPS Cap"] = "จำกัด FPS",
    ["Show FPS and Ping"] = "แสดง FPS และ Ping",
    ["FPS and Ping"] = "แสดง FPS และ Ping",
    ["FPS and Ping Size"] = "ขนาด FPS และ Ping",
    ["Optimizer"] = "ตัวปรับประสิทธิภาพ",
    ["Server Hop"] = "ย้ายเซิร์ฟเวอร์",
    ["Auto Server Hop"] = "ย้ายเซิร์ฟเวอร์อัตโนมัติ",
    ["Auto Hop"] = "ออโต้ย้ายเซิร์ฟเวอร์",
    ["Hop Mode"] = "โหมดย้ายเซิร์ฟเวอร์",
    ["Server Hop Mode"] = "โหมดย้ายเซิร์ฟเวอร์",
    ["Most Players"] = "คนเยอะสุด",
    ["Least Players"] = "คนน้อยสุด",
    ["Random"] = "สุ่ม",
    ["Rejoin Server"] = "เข้าเซิร์ฟเวอร์เดิมอีกครั้ง",
    ["Boss Server Hop"] = "ย้ายเซิร์ฟเวอร์หาบอส",
    ["Keep Hopping For"] = "ย้ายเซิร์ฟต่อเพื่อค้นหา",
    ["Joins new servers to find eggs that match the filters below"] = "เข้าเซิร์ฟเวอร์ใหม่เพื่อหาไข่ที่ตรงกับตัวกรองด้านล่าง",
    ["Turn on Auto Hop to start hunting"] = "เปิดออโต้ย้ายเซิร์ฟเวอร์เพื่อเริ่มค้นหาไข่",
    ["When to move on to the next server"] = "กำหนดว่าจะย้ายไปเซิร์ฟเวอร์ถัดไปเมื่อใด",
    ["Until An Egg Matches"] = "จนกว่าจะเจอไข่ตรงเงื่อนไข",
    ["Steal Then Hop"] = "ขโมยแล้วค่อยย้ายเซิร์ฟ",
    ["After A Rare Spawns"] = "เมื่อไข่แรร์เกิดแล้ว",
    ["Rarity To Wait For"] = "ระดับความหายากที่ต้องรอ",
    ["For After A Rare Spawns: this rarity or higher"] = "สำหรับโหมดรอไข่แรร์: รอระดับนี้หรือสูงกว่า",
    ["Sync With Auto Steal Filters"] = "ใช้ตัวกรองเดียวกับออโต้ขโมย",
    ["Changing a filter here also changes it in Auto Steal, and back"] = "เปลี่ยนตัวกรองตรงนี้จะเปลี่ยนในออโต้ขโมยด้วย",
    ["Find eggs of the chosen rarity and every rarity above it"] = "ค้นหาไข่ระดับที่เลือกและทุกระดับที่สูงกว่า",
    ["Only look for these eggs (empty = all)"] = "ค้นหาเฉพาะไข่เหล่านี้ (เว้นว่าง = ทั้งหมด)",
    ["Min Value To Find"] = "มูลค่าขั้นต่ำที่จะค้นหา",
    ["Skip eggs worth less than this. Drag or type 250k, 50m, 1.5b"] = "ข้ามไข่ที่มูลค่าต่ำกว่านี้ เช่น 250k, 50m, 1.5b",
    ["First Hop Delay"] = "หน่วงเวลาก่อนย้ายเซิร์ฟครั้งแรก",
    ["Wait after the script loads before the first hop"] = "รอหลังสคริปต์โหลดก่อนย้ายเซิร์ฟครั้งแรก",
    ["Auto Load Script"] = "โหลดสคริปต์อัตโนมัติ",
    ["Job ID"] = "Job ID",
    ["Paste a server Job ID..."] = "วาง Job ID ของเซิร์ฟเวอร์...",
    ["Join Job ID"] = "เข้าเซิร์ฟเวอร์ตาม Job ID",
    ["Copy Current Job ID"] = "คัดลอก Job ID ปัจจุบัน",
    ["Auto Rejoin When Disconnect"] = "เข้าเซิร์ฟเวอร์ใหม่อัตโนมัติเมื่อหลุด",
    ["Auto Steal"] = "ออโต้ขโมย",
    ["Auto Steal Egg"] = "ขโมยไข่อัตโนมัติ",
    ["Auto Steal Eggs"] = "ขโมยไข่อัตโนมัติ",
    ["Instant Steal"] = "ขโมยทันที",
    ["Instant Steal Steps"] = "จำนวนขั้นตอนขโมยทันที",
    ["Target Areas"] = "พื้นที่เป้าหมาย",
    ["Min Rarity"] = "ความหายากขั้นต่ำ",
    ["Min Steal Value"] = "มูลค่าขั้นต่ำที่จะขโมย",
    ["Min Value To Steal"] = "มูลค่าขั้นต่ำที่จะขโมย",
    ["Target Specific Eggs"] = "ขโมยเฉพาะไข่ที่เลือก",
    ["Steal Missing Lab Eggs"] = "ขโมยไข่แล็บที่ยังไม่มี",
    ["Steal Missing Index Eggs"] = "ขโมยไข่ในสมุดที่ยังไม่มี",
    ["Skip Owned Lab Eggs"] = "ข้ามไข่แล็บที่มีอยู่แล้ว",
    ["Steal Priority"] = "ลำดับความสำคัญขโมย",
    ["Stock Per Egg"] = "จำนวนสำรองต่อไข่",
    ["Carry Speed"] = "ความเร็วขณะถือไข่",
    ["Tween Speed"] = "ความเร็วการวาร์ป (Tween)",
    ["Steal Glide Speed"] = "ความเร็ว Glide ตอนขโมย",
    ["Auto Return to Base"] = "กลับฐานอัตโนมัติ",
    ["Avoid Rifts"] = "หลีกเลี่ยง Rift",
    ["Auto Place Egg"] = "ออโต้วางไข่",
    ["Auto Place Eggs"] = "ออโต้วางไข่",
    ["Auto Place Selected"] = "ออโต้วางไข่ที่เลือก",
    ["Auto Place Carried Egg"] = "ออโต้วางไข่ที่ถืออยู่",
    ["Min Place Value"] = "มูลค่าขั้นต่ำที่จะวาง",
    ["Place Egg Rule"] = "กฎการวางไข่",
    ["Place Rule"] = "กฎการวางไข่",
    ["Placement Rule"] = "กฎการวางไข่",
    ["Place Egg Order"] = "ลำดับการวางไข่",
    ["Place Egg Priority"] = "ลำดับความสำคัญการวางไข่",
    ["Place Rarities"] = "ระดับที่จะวางไข่",
    ["Place Specific Eggs"] = "วางเฉพาะไข่ที่กำหนด",
    ["Always"] = "ตลอดเวลา",
    ["Steal Idle"] = "ช่วงไม่ได้ขโมย",
    ["After Steal"] = "หลังขโมย",
    ["Night Only"] = "เฉพาะกลางคืน",
    ["Auto Hatch"] = "ออโต้ฟักไข่",
    ["Auto Hatch Egg"] = "ออโต้ฟักไข่",
    ["Auto Hatch Eggs"] = "ออโต้ฟักไข่",
    ["Auto Hatch & Equip"] = "ออโต้ฟักไข่และสวมใส่",
    ["Hatch Min Rarity"] = "ความหายากขั้นต่ำที่จะฟัก",
    ["Hatch eggs of the chosen rarity and every rarity above it"] = "ฟักไข่ระดับที่เลือก และทุกระดับที่สูงกว่า",
    ["Hatch Min Value"] = "มูลค่าขั้นต่ำที่จะฟัก",
    ["Minimum Hatch Value"] = "มูลค่าขั้นต่ำที่จะฟัก",
    ["Hatch Specific Egg"] = "ฟักเฉพาะไข่ที่เลือก",
    ["Hatch Specific Eggs"] = "ฟักเฉพาะไข่ที่เลือก",
    ["Only hatch these eggs (empty = all)"] = "ฟักเฉพาะไข่เหล่านี้ (เว้นว่าง = ทั้งหมด)",
    ["Auto Equip Best"] = "ออโต้ใส่ตัวที่ดีที่สุด",
    ["Auto Equip Best Pets"] = "ออโต้ใส่สัตว์เลี้ยงที่ดีที่สุด",
    ["Auto Equip Best Gear"] = "ออโต้ใส่อุปกรณ์ดีที่สุด",
    ["Auto Equip Best Trail"] = "ออโต้ใส่ Trail ที่ดีที่สุด",
    ["Equip Best"] = "ใส่ตัวที่ดีที่สุด",
    ["Switch to a better pet immediately when available"] = "เปลี่ยนไปใช้สัตว์เลี้ยงที่ดีกว่าทันทีเมื่อมี",
    ["Auto Treadmill"] = "ออโต้ลู่วิ่ง",
    ["Auto Treadmill Upgrade"] = "อัปเกรดลู่วิ่งอัตโนมัติ",
    ["Auto Upgrade Treadmill"] = "อัปเกรดลู่วิ่งอัตโนมัติ",
    ["AFK Treadmill"] = "ใช้ลู่วิ่งขณะ AFK",
    ["Treadmill Between Steals"] = "ใช้ลู่วิ่งระหว่างรอขโมย",
    ["Stay On Treadmill"] = "อยู่บนลู่วิ่งตลอดเวลา",
    ["Automatically upgrade treadmill when money is available"] = "อัปเกรดลู่วิ่งอัตโนมัติเมื่อมีเงินพอ",
    ["Auto Sell"] = "ออโต้ขาย",
    ["Auto Sell Egg"] = "ออโต้ขายไข่",
    ["Auto Sell Eggs"] = "ขายไข่อัตโนมัติ",
    ["Auto Sell Pet"] = "ออโต้ขายสัตว์เลี้ยง",
    ["Auto Sell Pets"] = "ขายสัตว์เลี้ยงอัตโนมัติ",
    ["Sell Eggs Now"] = "ขายไข่ตอนนี้",
    ["Sell Pets Now"] = "ขายสัตว์เลี้ยงตอนนี้",
    ["Pet Sell Value"] = "มูลค่าสัตว์เลี้ยงที่จะขาย",
    ["Egg Sell Value"] = "มูลค่าไข่ที่จะขาย",
    ["Never Sell Mutated"] = "ห้ามขายตัวที่กลายพันธุ์",
    ["Never Sell Equipped"] = "ห้ามขายตัวที่กำลังใช้งาน",
    ["Sell Pet Rule"] = "กฎการขายสัตว์เลี้ยง",
    ["Which checks must pass to sell"] = "เลือกเงื่อนไขที่ต้องผ่านก่อนขาย",
    ["Rarity Only"] = "เฉพาะความหายาก",
    ["Value Only"] = "เฉพาะมูลค่า",
    ["Rarity Or Value"] = "ความหายากหรือมูลค่า",
    ["Pet Max Rarity"] = "ความหายากสูงสุดของสัตว์เลี้ยง",
    ["Sell pets at or below this rarity"] = "ขายสัตว์เลี้ยงระดับนี้หรือต่ำกว่า",
    ["Sell pets worth less than this (0 = off)"] = "ขายสัตว์เลี้ยงที่มูลค่าต่ำกว่านี้ (0 = ปิด)",
    ["Keep Mutated Pets"] = "เก็บสัตว์เลี้ยงกลายพันธุ์ไว้",
    ["Never sell mutated pets"] = "ห้ามขายสัตว์เลี้ยงที่กลายพันธุ์",
    ["Blacklist Sell Pets"] = "สัตว์เลี้ยงห้ามขาย",
    ["These pets are never sold"] = "สัตว์เลี้ยงเหล่านี้จะไม่ถูกขาย",
    ["Auto Sell Lab Egg"] = "ออโต้ขายไข่แล็บ",
    ["Sell eggs traded from Dr Scramble that match the filters below"] = "ขายไข่ที่ได้จาก Dr. Scramble ตามเงื่อนไขด้านล่าง",
    ["Sell Lab Eggs Now"] = "ขายไข่แล็บตอนนี้",
    ["Sell matching Lab eggs once"] = "ขายไข่แล็บที่ตรงเงื่อนไข 1 ครั้ง",
    ["Lab Egg Rule"] = "กฎการขายไข่แล็บ",
    ["Rarity And Value"] = "ความแรร์และมูลค่า",
    ["Lab Egg Max Rarity"] = "ความแรร์สูงสุดของไข่แล็บที่จะขาย",
    ["Sell Lab eggs at or below this rarity (Off = none by rarity)"] = "ขายไข่แล็บระดับนี้หรือต่ำกว่า (ปิด = ไม่กรองความแรร์)",
    ["Lab Egg Sell Value"] = "มูลค่าไข่แล็บที่จะขาย",
    ["Sell Lab eggs worth less than this (0 = off)"] = "ขายไข่แล็บที่มูลค่าต่ำกว่านี้ (0 = ปิด)",
    ["Keep Mutated Lab Eggs"] = "เก็บไข่แล็บที่กลายพันธุ์ไว้",
    ["Never sell mutated Lab eggs"] = "ห้ามขายไข่แล็บที่กลายพันธุ์",
    ["Keep Lab Pets"] = "เก็บสัตว์เลี้ยงแล็บเหล่านี้ไว้",
    ["Lab eggs of these pets are never sold"] = "ไข่แล็บของสัตว์เหล่านี้จะไม่ถูกขาย",
    ["Auto Place Lab Reward Eggs"] = "ออโต้วางไข่รางวัลจากแล็บ",
    ["Dr. Scramble"] = "Dr. Scramble",
    ["Dr Scramble"] = "Dr. Scramble",
    ["Dr Scramble Event"] = "กิจกรรม Dr. Scramble",
    ["Dr Scramble Lab & Mech"] = "ห้องแล็บ Dr. Scramble & หุ่นรบ",
    ["Dr. Scramble Lab & Mech"] = "ห้องแล็บ Dr. Scramble & หุ่นรบ",
    ["Auto Mech Boss"] = "ออโต้ตีบอสหุ่นรบ",
    ["Mech Tween Speed"] = "ความเร็วบินไปตีหุ่นรบ",
    ["Main Weapon Hold"] = "เวลากดอาวุธหลัก",
    ["Scrambler Hold"] = "เวลากด Scrambler",
    ["Swap Two Weapons"] = "สลับอาวุธ 2 ชิ้น",
    ["Auto Claim Mastery"] = "ออโต้รับรางวัล Mastery",
    ["Auto Use Scrambled"] = "ออโต้ใช้ Scrambled",
    ["Auto Use Scrambled Mutation"] = "ออโต้ใช้ Scrambled",
    ["Auto Buy Scrambled"] = "ออโต้ซื้อ Scrambled",
    ["Auto Buy Scramble Shop"] = "ออโต้ซื้อของร้าน Scramble",
    ["Auto Buy Offers"] = "ซื้อของร้าน Scramble อัตโนมัติ",
    ["Auto Collect Drops"] = "เก็บของดรอปอัตโนมัติ",
    ["Teleport To Drops"] = "วาร์ปไปหาของดรอป",
    ["Auto Farm Drones"] = "ฟาร์มโดรนอัตโนมัติ",
    ["Drone Priority"] = "ลำดับเป้าหมายโดรน",
    ["Movement Speed"] = "ความเร็วการเคลื่อนที่",
    ["Auto Laboratory Trade-In"] = "แลกของในห้องทดลองอัตโนมัติ",
    ["Auto Lab Trade-In"] = "ออโต้แลกของในแล็บ",
    ["Collect Laboratory Rewards"] = "รับรางวัลห้องทดลอง",
    ["Auto Claim Lab Rewards"] = "ออโต้รับรางวัลจากแล็บ",
    ["Auto Reroll Lab Recipe"] = "ออโต้สุ่มสูตรแล็บใหม่",
    ["Maximum Trade Rarity"] = "ความแรร์สูงสุดที่ยอมแลก",
    ["Wanted Offers"] = "ของที่ต้องการซื้อ",
    ["Attack Boss"] = "โจมตีบอส",
    ["Dodge Attacks"] = "หลบการโจมตี",
    ["Enter Arena When Live"] = "เข้าสนามเมื่อบอสเริ่ม",
    ["Biohazard Pets"] = "สัตว์ Biohazard",
    ["Experimental Pets"] = "สัตว์ทดลอง",
    ["Unstable DNA"] = "DNA ไม่เสถียร",
    ["Lab Banner"] = "ป้ายแบนเนอร์แล็บ",
    ["Lab Banners"] = "ป้ายแบนเนอร์แล็บ",
    ["Scramble Shop"] = "ร้าน Scramble",
    ["Scramble Shop Items"] = "ไอเทมในร้าน Scramble",
    ["Items to Buy"] = "ไอเทมที่จะซื้อในร้าน",
    ["Items To Buy"] = "ไอเทมที่จะซื้อในร้าน",
    ["Keep Samples"] = "สำรอง Samples ไว้",
    ["Reserve Samples"] = "สำรอง Samples ไว้",
    ["Samples Reserve"] = "จำนวน Samples สำรอง",
    ["Minimum Mutation Rarity"] = "ระดับไข่กลายพันธุ์ขั้นต่ำ",
    ["Mutation Egg Min Rarity"] = "ระดับไข่กลายพันธุ์ขั้นต่ำ",
    ["Mutation Min Rarity"] = "ระดับไข่กลายพันธุ์ขั้นต่ำ",
    ["Min Mutation Value"] = "มูลค่าขั้นต่ำการกลายพันธุ์",
    ["Mutation Min Value"] = "มูลค่าขั้นต่ำการกลายพันธุ์",
    ["Mutation Priority"] = "ลำดับความสำคัญกลายพันธุ์",
    ["Mutation Target Eggs"] = "เป้าหมายไข่กลายพันธุ์",
    ["2x Cash Booster"] = "บูสต์เงิน x2",
    ["1.25x Speed"] = "ความเร็ว x1.25",
    ["2x Treadmill Booster"] = "บูสต์ลู่วิ่ง x2",
    ["Auto Fuse Machine"] = "ออโต้เครื่องผสมสัตว์",
    ["Fuse 3 same pets into an egg, nonstop"] = "ผสมสัตว์เลี้ยงชนิดเดียวกัน 3 ตัวเป็นไข่แบบต่อเนื่อง",
    ["Fuse Priority Mode"] = "โหมดลำดับการผสม",
    ["Lowest Rarity First"] = "ความหายากต่ำสุดก่อน",
    ["Highest Rarity First"] = "ความหายากสูงสุดก่อน",
    ["Most Copies First"] = "จำนวนตัวซ้ำมากสุดก่อน",
    ["Lowest Value First"] = "มูลค่าต่ำสุดก่อน",
    ["Pets To Use"] = "สัตว์เลี้ยงที่จะใช้",
    ["Lowest To Highest"] = "ต่ำไปสูง",
    ["Highest To Lowest"] = "สูงไปต่ำ",
    ["Max Rarity to Fuse"] = "ความหายากสูงสุดที่จะผสม",
    ["Specific Species to Fuse"] = "ระบุสายพันธุ์ที่จะผสม",
    ["Only fuse these species (empty = all)"] = "ผสมเฉพาะสายพันธุ์เหล่านี้ (เว้นว่าง = ทั้งหมด)",
    ["Skip Mutated Pets"] = "ข้ามสัตว์เลี้ยงกลายพันธุ์",
    ["Eject Incomplete Slots"] = "เอาสัตว์ที่จัดชุดไม่ได้ออก",
    ["Take out pets that can't make a set"] = "นำสัตว์เลี้ยงที่จัดเป็นชุดไม่ได้ออก",
    ["Butterfly Bloom"] = "ผีเสื้อผลิบาน",
    ["Auto Butterfly Bloom"] = "ออโต้ Butterfly Bloom",
    ["Catch Mode"] = "โหมดจับผีเสื้อ",
    ["Stand"] = "ยืนรอ",
    ["Chase"] = "ไล่จับ",
    ["Circle"] = "วนเป็นวง",
    ["Patrol"] = "ลาดตระเวน",
    ["Catch Priority"] = "ลำดับการจับ",
    ["Only for Chase mode"] = "ใช้เฉพาะโหมดไล่จับ",
    ["Rarest"] = "หายากสุดก่อน",
    ["Closest"] = "ใกล้สุดก่อน",
    ["Nearest"] = "ใกล้สุดก่อน",
    ["Catch Butterflies"] = "จับผีเสื้อ",
    ["Radiant Butterfly"] = "ผีเสื้อ Radiant",
    ["Amethyst Butterfly"] = "ผีเสื้อ Amethyst",
    ["Sapphire Butterfly"] = "ผีเสื้อ Sapphire",
    ["Emerald Butterfly"] = "ผีเสื้อ Emerald",
    ["Wisp"] = "ภูตแสง (Wisp)",
    ["Wisp Companion"] = "คู่หู Wisp",
    ["Auto Wisp"] = "ออโต้ Wisp",
    ["Auto Wisp Quests"] = "ออโต้ภารกิจ Wisp",
    ["Steal Wisp Quest Eggs"] = "ขโมยไข่ภารกิจ Wisp",
    ["Butterflies"] = "ผีเสื้อ",
    ["Auto Claim Net"] = "ออโต้รับตาข่าย",
    ["Auto Catch Butterflies"] = "ออโต้จับผีเสื้อ",
    ["Auto Banjo Cricket"] = "ออโต้ Banjo Cricket",
    ["Banjo Cricket"] = "Banjo Cricket",
    ["Auto Trade Up"] = "ออโต้เลื่อนระดับ",
    ["Trade Up"] = "เลื่อนระดับ",
    ["Trade Up Tiers"] = "ระดับการเลื่อนขั้น",
    ["Trades"] = "การแลก",
    ["Emerald To Sapphire"] = "Emerald → Sapphire",
    ["Sapphire To Amethyst"] = "Sapphire → Amethyst",
    ["Amethyst To Radiant"] = "Amethyst → Radiant",
    ["Emerald -> Sapphire"] = "Emerald → Sapphire",
    ["Sapphire -> Amethyst"] = "Sapphire → Amethyst",
    ["Amethyst -> Radiant"] = "Amethyst → Radiant",
    ["Smart Trade For Essence"] = "แลกอัจฉริยะเพื่อ Essence",
    ["Auto Craft Essence"] = "ออโต้สร้าง Essence",
    ["Auto Essence"] = "ออโต้ Essence",
    ["Essence"] = "Essence",
    ["Auto Use Enchanted Essence"] = "ออโต้ใช้ Enchanted Essence",
    ["Essence Min Rarity"] = "ความหายากขั้นต่ำสำหรับ Essence",
    ["Only eggs of this rarity and above get the essence"] = "ใช้ Essence เฉพาะไข่ระดับนี้ขึ้นไป",
    ["Essence Min Value"] = "มูลค่าขั้นต่ำสำหรับ Essence",
    ["Essence Target Eggs"] = "ไข่เป้าหมายสำหรับ Essence",
    ["Only use the essence on these eggs (empty = all)"] = "ใช้ Essence กับไข่เหล่านี้เท่านั้น (เว้นว่าง = ทั้งหมด)",
    ["Essence Priority"] = "ลำดับความสำคัญของ Essence",
    ["Which egg gets the essence first"] = "กำหนดว่าไข่ใบไหนจะได้รับ Essence ก่อน",
    ["Essence Skip Enchanted Eggs"] = "ข้ามไข่ Enchanted สำหรับ Essence",
    ["Skip eggs that already got Enchanted, other mutations still get the essence"] = "ข้ามไข่ที่มี Enchanted แล้ว การกลายพันธุ์อื่นยังได้รับ Essence",
    ["Highest Value"] = "มูลค่าสูงสุด",
    ["Lowest Value"] = "มูลค่าต่ำสุด",
    ["Best Rarity"] = "ความหายากสูงสุด",
    ["Biggest Size"] = "ขนาดใหญ่สุด",
    ["Smallest Size"] = "ขนาดเล็กสุด",
    ["Biggest Weight"] = "น้ำหนักมากสุด",
    ["Best Mutation"] = "การกลายพันธุ์ดีที่สุด",
    ["Backpack Order"] = "ลำดับในกระเป๋า",
    ["Auto Favorite"] = "ออโต้กดถูกใจ",
    ["Auto Favorite Pet"] = "ออโต้กดถูกใจสัตว์เลี้ยง",
    ["Auto Favorite Pets"] = "ออโต้กดถูกใจสัตว์เลี้ยง",
    ["Favorite Pets Now"] = "กดถูกใจสัตว์เลี้ยงตอนนี้",
    ["Favorite pets matching the rules below"] = "กดถูกใจสัตว์เลี้ยงที่ตรงตามกฎด้านล่าง",
    ["Favorite matching pets once"] = "กดถูกใจสัตว์เลี้ยงที่ตรงเงื่อนไข 1 ครั้ง",
    ["Favorite Rule"] = "กฎการกดถูกใจ",
    ["Pass any check or all checks"] = "กำหนดให้ผ่านบางเงื่อนไขหรือทุกเงื่อนไข",
    ["Match Any"] = "ตรงอย่างใดอย่างหนึ่ง",
    ["Match All"] = "ตรงทุกเงื่อนไข",
    ["Favorite Min Rarity"] = "ความหายากขั้นต่ำที่จะกดถูกใจ",
    ["Favorite pets of the chosen rarity and every rarity above it (Off = skip)"] = "กดถูกใจสัตว์เลี้ยงระดับที่เลือกและสูงกว่า (ปิด = ข้าม)",
    ["Favorite Mutations"] = "การกลายพันธุ์ที่จะกดถูกใจ",
    ["Mutation check (empty = skip)"] = "ตรวจการกลายพันธุ์ (เว้นว่าง = ข้าม)",
    ["Min Favorite Value"] = "มูลค่าขั้นต่ำที่จะกดถูกใจ",
    ["Value check (0 = skip)"] = "ตรวจมูลค่า (0 = ข้าม)",
    ["Always Favorite Species"] = "กดถูกใจสายพันธุ์เหล่านี้เสมอ",
    ["Always favorite these species"] = "กดถูกใจสายพันธุ์เหล่านี้เสมอ",
    ["Auto Favorite Equipped"] = "ออโต้กดถูกใจตัวที่สวมใส่",
    ["Keep equipped pets favorited"] = "คงสถานะถูกใจให้สัตว์เลี้ยงที่สวมใส่",
    ["Auto Unfavorite Equipped"] = "ออโต้ปลดถูกใจตัวที่สวมใส่",
    ["Unfavorite equipped pets not in the rules"] = "ปลดถูกใจสัตว์เลี้ยงที่สวมใส่ซึ่งไม่ตรงกฎ",
    ["Favorite Equipped Now"] = "กดถูกใจตัวที่สวมใส่ตอนนี้",
    ["Favorite all equipped pets once"] = "กดถูกใจสัตว์เลี้ยงที่สวมใส่ทั้งหมด 1 ครั้ง",
    ["Unfavorite Equipped Now"] = "ยกเลิกถูกใจตัวที่สวมใส่อยู่ตอนนี้",
    ["Unfavorite all equipped pets once"] = "ปลดถูกใจสัตว์เลี้ยงที่สวมใส่ทั้งหมด 1 ครั้ง",
    ["Auto Progression"] = "พัฒนาอัตโนมัติ",
    ["Auto Buy Trail"] = "ออโต้ซื้อ Trail",
    ["Automatically buy available trails when affordable"] = "ซื้อ Trail ที่ซื้อได้อัตโนมัติเมื่อเงินพอ",
    ["Auto Upgrade Base"] = "ออโต้อัปเกรดฐาน",
    ["Automatically upgrade base when money is available"] = "อัปเกรดฐานอัตโนมัติเมื่อมีเงินพอ",
    ["Auto Claim"] = "ออโต้รับรางวัล",
    ["Claim offline money & index rewards"] = "รับเงินออฟไลน์และรางวัล Index อัตโนมัติ",
    ["Auto Claim Index"] = "ออโต้รับรางวัล Index",
    ["Claim index rewards as soon as they unlock"] = "รับรางวัล Index ทันทีเมื่อปลดล็อก",
    ["ESP"] = "ESP",
    ["ESP Eggs"] = "ESP ไข่",
    ["ESP Fixed Size"] = "ใช้ขนาด ESP คงที่",
    ["ESP Own Base"] = "ESP ไข่ในฐานตัวเอง",
    ["ESP Own Base Eggs"] = "ESP ไข่ในฐานตัวเอง",
    ["Also show the eggs placed in your own base"] = "แสดงไข่ที่วางอยู่ในฐานของตัวเองด้วย",
    ["ESP Min Rarity"] = "ความหายากขั้นต่ำของ ESP",
    ["Show eggs of the chosen rarity and every rarity above it"] = "แสดงไข่ระดับที่เลือกและทุกระดับที่สูงกว่า",
    ["ESP Show Info"] = "ข้อมูลที่แสดงใน ESP",
    ["Min ESP Value"] = "มูลค่าขั้นต่ำของ ESP",
    ["ESP Egg Size"] = "ขนาด ESP ไข่",
    ["ESP Guards"] = "ESP ยาม",
    ["ESP Guard Size"] = "ขนาด ESP ยาม",
    ["ESP Lost Parts"] = "ESP ชิ้นส่วนที่หาย",
    ["ESP Missing Parts"] = "ESP ชิ้นส่วนที่หาย",
    ["ESP Players"] = "ESP ผู้เล่น",
    ["ESP Player Info"] = "ข้อมูล ESP ผู้เล่น",
    ["ESP Player Size"] = "ขนาด ESP ผู้เล่น",
    ["Guards"] = "ยาม",
    ["Icon"] = "ไอคอน",
    ["Name"] = "ชื่อ",
    ["Weight"] = "น้ำหนัก",
    ["Sell Price"] = "ราคาขาย",
    ["Distance"] = "ระยะทาง",
    ["State"] = "สถานะ",
    ["Username"] = "ชื่อผู้ใช้",
    ["Avatar"] = "อวตาร",
    ["Tool"] = "อุปกรณ์",
    ["Discord Webhook"] = "เว็บฮุก Discord",
    ["Discord Webhook URL"] = "URL Webhook ของ Discord",
    ["Webhook URL"] = "URL ของ Webhook",
    ["Ping @everyone"] = "แท็ก @everyone",
    ["Notify Stolen Eggs"] = "แจ้งเตือนไข่ที่ขโมยได้",
    ["Egg Predictor"] = "คาดการณ์ไข่",
    ["Fuse Predictor"] = "คาดการณ์ผลการผสม",
    ["Lab Predictor"] = "คาดการณ์ห้องแล็บ",
    ["Machine is empty"] = "เครื่องยังว่าง",
    ["Predictor Tab > Discord Webhook"] = "แท็บคาดการณ์ > Discord Webhook",
    ["Predictor Tab > Egg Predictor"] = "แท็บคาดการณ์ > คาดการณ์ไข่",
    ["Progress Tab > Auto Progression"] = "แท็บความคืบหน้า > พัฒนาอัตโนมัติ",
    ["Sort By"] = "เรียงตาม",
    ["Time Left"] = "เวลาที่เหลือ",
    ["Preview Card"] = "แสดงตัวอย่างการ์ด",
    ["Search eggs..."] = "ค้นหาไข่...",
    ["HOLD EGG"] = "ถือไข่",
    ["IN BAG"] = "ในกระเป๋า",
    ["EGGS"] = "ไข่",
    ["READY"] = "พร้อม",
    ["GROWING"] = "กำลังโต",
    ["TOTAL /S"] = "รวม /วินาที",
    ["Interface"] = "หน้าตา",
    ["UI Size"] = "ขนาด UI",
    ["Scales the main window; the corner grip does the same by hand"] = "ปรับขนาดหน้าต่างหลัก หรือลากมุมเพื่อปรับเอง",
    ["Notifications"] = "การแจ้งเตือน",
    ["Show notification cards; turning this off hides every notify"] = "แสดงการแจ้งเตือน ปิดแล้วจะซ่อนการแจ้งเตือนทั้งหมด",
    ["Open On Launch"] = "เปิด UI ตอนเริ่ม",
    ["Open the UI automatically when the script starts"] = "เปิดหน้าต่าง UI อัตโนมัติเมื่อสคริปต์เริ่ม",
    ["Defaults"] = "ค่าเริ่มต้น",
    ["Reset to Defaults"] = "รีเซ็ตเป็นค่าเริ่มต้น",
    ["Reset every feature to its built-in default"] = "คืนค่าทุกฟีเจอร์กลับเป็นค่าเริ่มต้น",
    ["Turn Off All Toggles"] = "ปิดสวิตช์ทั้งหมด",
    ["Switch off every enabled toggle in the feature tabs"] = "ปิดทุกสวิตช์ที่เปิดอยู่ในแท็บฟีเจอร์",
    ["Quick Access"] = "เมนูลัด",
    ["Show Quick Bars"] = "แสดงแถบลัด",
    ["Floating quick bars; drag a header to move one"] = "แสดงแถบลัดแบบลอย ลากหัวแถบเพื่อย้ายตำแหน่ง",
    ["Visible Quick Bars"] = "แถบลัดที่แสดง",
    ["Quick Bar Size"] = "ขนาดแถบลัด",
    ["Quick Bar & Keybinds"] = "แถบลัดและปุ่มคีย์ลัด",
    ["Reset Quick Access"] = "รีเซ็ตเมนูลัด",
    ["Restore default items, bars and positions"] = "คืนค่าไอเท็ม แถบ และตำแหน่งเริ่มต้น",
    ["Reset Keybinds"] = "รีเซ็ตปุ่มคีย์ลัด",
    ["Restore the defaults set in code"] = "คืนค่าปุ่มตามค่าเริ่มต้นของสคริปต์",
    ["Quick Bar 1"] = "แถบลัด 1",
    ["Profiles"] = "โปรไฟล์",
    ["Startup Config"] = "คอนฟิกเริ่มต้น",
    ["Auto Save Config"] = "บันทึกคอนฟิกอัตโนมัติ",
    ["Auto Load Config"] = "โหลดคอนฟิกอัตโนมัติ",
    ["Delete Config"] = "ลบคอนฟิก",
    ["Set Startup Config"] = "ตั้งคอนฟิกเริ่มต้น",
    ["Load Config"] = "โหลดคอนฟิก",
    ["Save Config"] = "บันทึกคอนฟิก",
    ["Import / Export"] = "นำเข้า / ส่งออก",
    ["Import / export"] = "นำเข้า / ส่งออก",
    ["Export Config"] = "ส่งออกคอนฟิก",
    ["Import Config"] = "นำเข้าคอนฟิก",
    ["Import Config Text"] = "ข้อความนำเข้าคอนฟิก",
    ["Paste exported config JSON..."] = "วาง JSON คอนฟิกที่ส่งออกไว้ที่นี่...",
    ["Creates a config only; use Load Config or Set Startup after"] = "สร้างคอนฟิกเท่านั้น จากนั้นใช้ โหลดคอนฟิก หรือ ตั้งคอนฟิกเริ่มต้น",
    ["Config name"] = "ชื่อคอนฟิก",
    ["New Config Name"] = "ชื่อคอนฟิกใหม่",
    ["New config name..."] = "ชื่อคอนฟิกใหม่...",
    ["Create config"] = "สร้างคอนฟิก",
    ["Create New Config"] = "สร้างคอนฟิกใหม่",
    ["Create New"] = "สร้างใหม่",
    ["New config copies current settings"] = "คอนฟิกใหม่จะคัดลอกการตั้งค่าปัจจุบัน",
    ["Delete config"] = "ลบคอนฟิก",
    ["Load config"] = "โหลดคอนฟิก",
    ["Refresh list"] = "รีเฟรชรายการ",
    ["Set autoload"] = "ตั้งโหลดอัตโนมัติ",
    ["Reset autoload"] = "ยกเลิกโหลดอัตโนมัติ",
    ["Farm Tab > Auto Sell Lab Egg"] = "แท็บฟาร์ม > ออโต้ขายไข่แล็บ",
    ["Farm Tab > Auto Place Egg"] = "แท็บฟาร์ม > ออโต้วางไข่",
    ["Farm Tab > Auto Treadmill"] = "แท็บฟาร์ม > ออโต้ลู่วิ่ง",
    ["Farm Tab > Auto Hatch & Equip"] = "แท็บฟาร์ม > ออโต้ฟักไข่และสวมใส่",
    ["Farm Tab > Auto Sell"] = "แท็บฟาร์ม > ออโต้ขาย",
    ["Farm Tab > Auto Steal"] = "แท็บฟาร์ม > ออโต้ขโมย",
    ["Farm Tab > Dr Scramble Lab & Mech"] = "แท็บฟาร์ม > ห้องแล็บ Dr. Scramble & หุ่นรบ",
    ["Misc Tab > Utility"] = "แท็บอื่นๆ > เครื่องมือ",
    ["Auto Hop Tab > Egg Finder"] = "แท็บย้ายเซิร์ฟอัตโนมัติ > ค้นหาไข่",
    ["Discord Tab > Community"] = "แท็บดิสคอร์ด > ชุมชน",
    ["Copy Discord Link"] = "คัดลอกลิงก์ดิสคอร์ด",
    ["Settings Tab > Defaults"] = "แท็บตั้งค่า > ค่าเริ่มต้น",
    ["Delivers the egg to the safe zone in a few seconds, needs enough Speed"] = "ส่งไข่กลับเขตปลอดภัยภายในไม่กี่วินาที ต้องมีความเร็วเพียงพอ",
    ["Higher is safer but takes longer"] = "ค่ายิ่งสูงยิ่งปลอดภัย แต่ใช้เวลานานขึ้น",
    ["Fast Delivery"] = "ส่งไข่กลับฐานแบบเร็ว",
    ["Delivers the same way as Instant Steal V2 instead of using steps"] = "ส่งไข่กลับฐานด้วยวิธีเดียวกับขโมยทันที V2 แทนการใช้ขั้นตอน",
    ["Instant Steal V2"] = "ขโมยทันที V2",
    ["Steal eggs of the chosen rarity and every rarity above it"] = "ขโมยไข่ระดับที่เลือกและทุกระดับที่สูงกว่า",
    ["Enchanted Forest"] = "ป่ามนตรา",
    ["Over 100% may glitch"] = "เกิน 100% อาจทำให้การเคลื่อนที่ผิดปกติ",
    ["Drop Eggs At Safe Zone"] = "วางไข่ในเขตปลอดภัย",
    ["Auto Steal: OFF"] = "ออโต้ขโมย: ปิด",
    ["Auto Steal: ON"] = "ออโต้ขโมย: เปิด",
    ["Instant Steal: OFF"] = "ขโมยทันที: ปิด",
    ["Instant Steal: ON"] = "ขโมยทันที: เปิด",

    -- V1.7.8: floating animal-steal panel (screenshot 2026-10-18)
    ["Halloween: OFF"] = "ฮาโลวีน: ปิด",
    ["Halloween: ON"] = "ฮาโลวีน: เปิด",
    ["Eggs: All"] = "ไข่: ทั้งหมด",
    ["Eggs: ALL"] = "ไข่: ทั้งหมด",
    ["Auto Steal: Off"] = "ออโต้ขโมย: ปิด",
    ["Auto Steal: On"] = "ออโต้ขโมย: เปิด",
    ["Halloween: Off"] = "ฮาโลวีน: ปิด",
    ["Halloween: On"] = "ฮาโลวีน: เปิด",
    ["Eggs"] = "ไข่",
    ["Halloween"] = "ฮาโลวีน",

    -- V1.3: New Chilli Farm > Instant Steal Zones (2026-10-09)
    ["Teleport To Egg"] = "วาร์ปไปหาไข่",
    ["Teleport to Egg"] = "วาร์ปไปหาไข่",
    ["Teleport To Eggs"] = "วาร์ปไปหาไข่",
    ["Instant Steal Zones"] = "โซนขโมยทันที",
    ["Instant Steal Zone"] = "โซนขโมยทันที",
    ["Zones where Instant Steal V2 is used"] = "โซนที่ใช้ระบบขโมยทันที V2",
    ["Prehistoric"] = "ยุคดึกดำบรรพ์",
    ["Cherry Blossom"] = "ซากุระ",
    ["Light Dark"] = "แสงและความมืด",
    ["Titan Temple"] = "วิหารไททัน",
}

--========================================================
-- V1.7 ADD-ONLY TRANSLATIONS: CHILLI RACE / SHOOTING STAR
-- / AUTO MUTATION / QUICK-BAR LABELS (2026-10-11)
-- Preserves all existing V1.6 DR-FIX 3 mappings.
-- No hooks, layout changes or additional scanning.
--========================================================

local ZIGZAG_V17_TRANSLATIONS = {
    ["Racing Event"] = "กิจกรรมแข่งวิ่ง",
    ["Auto Race"] = "ออโต้แข่งวิ่ง",
    ["Race Speed"] = "ความเร็วในการแข่งขัน",
    ["Auto Use Power-Ups"] = "ออโต้ใช้ไอเทมเพิ่มพลัง",
    ["Auto Claim Race Rewards"] = "ออโต้รับรางวัลการแข่งขัน",
    ["Auto Equip Racer"] = "ออโต้เลือกพาหนะแข่ง",
    ["Racer"] = "พาหนะแข่ง",
    ["Best Owned"] = "ตัวที่ดีที่สุดที่มี",
    ["Ostrich"] = "นกกระจอกเทศ",
    ["Auto Buy Race Shop"] = "ออโต้ซื้อของจากร้านการแข่งขัน",
    ["Race Shop Items"] = "ไอเทมในร้านการแข่งขัน",
    ["Nitro Mutation"] = "การกลายพันธุ์ไนโตร",
    ["Cash Booster"] = "ตัวเพิ่มรายได้",
    ["Treadmill Boost"] = "บูสต์ลู่วิ่ง",
    ["Racing Bat"] = "ไม้ตีการแข่งขัน",
    ["Shooting Star"] = "ดาวตก",
    ["Shooting Stars"] = "ดาวตก",
    ["Waiting for a shooting star"] = "กำลังรอดาวตก",
    ["Waiting for a shooting star."] = "กำลังรอดาวตก",
    ["Waiting for a shooting star..."] = "กำลังรอดาวตก",
    ["Auto Catch Shooting Star"] = "ออโต้เก็บดาวตก",
    ["Auto Catch Shooting Stars"] = "ออโต้เก็บดาวตก",
    ["Auto Mutation"] = "ออโต้กลายพันธุ์",
    ["Auto Mutate"] = "ออโต้กลายพันธุ์",
    ["Mutations To Use"] = "การกลายพันธุ์ที่ต้องการใช้",
    ["Fractured"] = "แตกสลาย",
    ["Scrambled"] = "สแครมเบิล",
    ["Enchanted"] = "มนตรา",
    ["Nitro"] = "ไนโตร",
    ["Auto Buy Nitro"] = "ออโต้ซื้อไนโตร",
    ["Buy Nitro from the Racing Event shop as soon as you run out"] = "ซื้อไนโตรจากร้านกิจกรรมแข่งวิ่งทันทีเมื่อไนโตรหมด",
    ["Mutate Min Rarity"] = "ความหายากขั้นต่ำสำหรับการกลายพันธุ์",
    ["Only eggs of this rarity and above get mutated"] = "กลายพันธุ์เฉพาะไข่ระดับนี้ขึ้นไป",
    ["Mutate Min Value"] = "มูลค่าขั้นต่ำสำหรับการกลายพันธุ์",
    ["Skip eggs worth less than this (0 = off)"] = "ข้ามไข่ที่มูลค่าต่ำกว่าที่กำหนด (0 = ปิด)",
    ["Mutate Target Eggs"] = "ไข่เป้าหมายสำหรับการกลายพันธุ์",
    ["Only mutate these eggs (empty = all)"] = "กลายพันธุ์เฉพาะไข่ที่เลือก (เว้นว่าง = ทั้งหมด)",
    ["Mutate Priority"] = "ลำดับความสำคัญการกลายพันธุ์",
    ["Which egg gets mutated first"] = "เลือกไข่ที่จะกลายพันธุ์ก่อน",
    ["Keep Mutated Eggs"] = "เก็บไข่ที่กลายพันธุ์ไว้",
    ["Min Hatch Value"] = "มูลค่าขั้นต่ำในการฟักไข่",
    ["Farm Tab > Racing Event"] = "แท็บฟาร์ม > กิจกรรมแข่งวิ่ง",
    ["Farm Tab > Shooting Star"] = "แท็บฟาร์ม > ดาวตก",
    ["Farm Tab > Butterfly Bloom"] = "แท็บฟาร์ม > ผีเสื้อผลิบาน",
    ["Farm Tab > Auto Mutation"] = "แท็บฟาร์ม > ออโต้กลายพันธุ์",
    ["Farm Tab > Auto Fuse Machine"] = "แท็บฟาร์ม > ออโต้เครื่องผสมสัตว์",
    ["Farm Tab > Auto Sell Pet"] = "แท็บฟาร์ม > ออโต้ขายสัตว์เลี้ยง",
    ["Farm Tab > Auto Sell Egg"] = "แท็บฟาร์ม > ออโต้ขายไข่",
    ["Farm Tab > Auto Buy Race Shop"] = "แท็บฟาร์ม > ออโต้ซื้อของร้านการแข่งขัน",
    ["Next Racing Event in"] = "กิจกรรมแข่งวิ่งครั้งถัดไปใน",
    ["Race Rewards"] = "รางวัลการแข่งขัน",
    ["Race Shop"] = "ร้านการแข่งขัน",
}

for english,thai in pairs(ZIGZAG_V17_TRANSLATIONS) do
    if TRANSLATIONS[english] == nil then
        TRANSLATIONS[english] = thai
    end
end

--========================================================
-- V1.7.1: ADMIN ABUSE TRANSLATIONS (ADD-ONLY)
-- Uses original cache/translator; zero new watchers or scans.
--========================================================
local ZIGZAG_V171_ADMIN_TRANSLATIONS = {
    ["Admin Abuse"] = "กิจกรรมแอดมิน",
    ["Admin Abuse Tab"] = "แท็บกิจกรรมแอดมิน",
    ["Capture The Egg"] = "จับไข่กิจกรรม",
    ["Capture the Egg"] = "จับไข่กิจกรรม",
    ["Auto Capture Event Egg"] = "ออโต้จับไข่กิจกรรม",
    ["Take It From The Holder"] = "แย่งไข่จากผู้ที่กำลังถือ",
    ["Hold Height"] = "ความสูงขณะถือไข่",
    ["Keep Away Distance"] = "ระยะเว้นห่างจากผู้อื่น",
    ["Admin Treadmill"] = "ลู่วิ่งแอดมิน",
    ["Auto Use Admin Treadmill"] = "ออโต้ใช้ลู่วิ่งแอดมิน",
    ["Instant Steal V3"] = "ขโมยทันที V3",
    ["Minigame Eggs"] = "ไข่มินิเกม",
    ["Minigame Egg"] = "ไข่มินิเกม",
    ["Auto Steal Minigame Egg"] = "ออโต้ขโมยไข่มินิเกม",
    ["Admin Abuse Tab > Capture The Egg"] = "แท็บกิจกรรมแอดมิน > จับไข่กิจกรรม",
    ["Admin Abuse Tab > Admin Treadmill"] = "แท็บกิจกรรมแอดมิน > ลู่วิ่งแอดมิน",
    ["Admin Abuse Tab > Instant Steal V3"] = "แท็บกิจกรรมแอดมิน > ขโมยทันที V3",
    ["Admin Abuse Tab > Minigame Eggs"] = "แท็บกิจกรรมแอดมิน > ไข่มินิเกม",
}
for en,th in pairs(ZIGZAG_V171_ADMIN_TRANSLATIONS) do
    if TRANSLATIONS[en] == nil then
        TRANSLATIONS[en] = th
    end
end


--========================================================
-- V1.7.1 VERIFIED BASE + V1.7.4 ADD-ONLY TRANSLATIONS
-- New English -> Thai dictionary entries only; NO engine/loader/UI changes.
-- This section MUST run before LOWER_TRANSLATIONS cache creation.
--========================================================
local ZIGZAG_V174_ADDED_TRANSLATIONS = {
    ["Toggle is off"] = "สวิตช์ปิดอยู่",
    ["Needs Admin Treadmill"] = "ต้องมีลู่วิ่งแอดมิน",
    ["Needs Admin Treadmill to work"] = "ต้องมีลู่วิ่งแอดมินจึงจะใช้งานได้",
    ["INACTIVE"] = "ยังไม่ทำงาน",
    ["WAITING"] = "กำลังรอ",
    ["Waiting for Capture The Egg"] = "กำลังรอกิจกรรมจับไข่",
    ["Turn on Capture The Egg below to join the event"] = "เปิดระบบจับไข่ด้านล่างเพื่อเข้าร่วมกิจกรรม",
    ["Waiting for Red Light Green Light or T-Rex Run"] = "กำลังรอกิจกรรมไฟแดงไฟเขียวหรือวิ่งหนีทีเร็กซ์",
    ["Turn on Auto Steal Minigame Egg below"] = "เปิดระบบขโมยไข่มินิเกมอัตโนมัติด้านล่าง",
    ["Red Light Green Light, T-Rex Run"] = "ไฟแดงไฟเขียว, วิ่งหนีทีเร็กซ์",
    ["Red Light Green Light"] = "ไฟแดงไฟเขียว",
    ["T-Rex Run"] = "วิ่งหนีทีเร็กซ์",
    ["Swap Weapons"] = "สลับอาวุธ",
    ["Pick up to 2 weapons you own to switch between while hitting (empty = best bat only)"] = "เลือกอาวุธที่คุณมีได้สูงสุด 2 ชิ้นเพื่อสลับใช้ระหว่างตี (ถ้าเว้นว่าง = ใช้ไม้ที่ดีที่สุดเท่านั้น)",
    ["Weapon 1 Hold"] = "เวลาถืออาวุธ 1",
    ["Weapon 2 Hold"] = "เวลาถืออาวุธ 2",
    ["The Scrambler"] = "เดอะ สแครมเบลอร์",
    ["EnchantedHammer"] = "ค้อนมนตรา",
    ["Light Dark Staff"] = "คทาแสงและความมืด",
    ["Titan Axe"] = "ขวานไททัน",
    ["Katana"] = "คาตานะ",
    ["Scramble Sword"] = "ดาบสแครมเบิล",
    ["Cosmic Bat"] = "ไม้คอสมิก",
    ["Prehistoric Bat"] = "ไม้ยุคดึกดำบรรพ์",
    ["Abyss Ocean Bat"] = "ไม้ห้วงสมุทรลึก",
    ["Volcano Bat"] = "ไม้ภูเขาไฟ",
    ["Snow Bat"] = "ไม้หิมะ",
    ["Jungle Bat"] = "ไม้ป่า",
    ["Desert Bat"] = "ไม้ทะเลทราย",
    ["Lake Bat"] = "ไม้ทะเลสาบ",
    ["Forest Bat"] = "ไม้ป่า",
    ["Aura ready, nobody in reach"] = "ออร่าพร้อมแล้ว แต่ยังไม่มีใครอยู่ในระยะ",
    ["Turn on Auto Use Admin Treadmill below"] = "เปิดใช้งานออโต้ใช้ลู่วิ่งแอดมินด้านล่าง",
    ["Waiting for the Admin Treadmill"] = "กำลังรอลู่วิ่งแอดมิน",
    ["Strip shadows, textures and effects for the highest FPS"] = "ปิดเงา พื้นผิว และเอฟเฟกต์ เพื่อให้ได้ FPS สูงสุด",
    ["Utility"] = "ยูทิลิตี้",
    ["HUD Items"] = "รายการ HUD",
    ["Egg Card Image"] = "รูปการ์ดไข่",
    ["Picture used for Top Eggs and Steal History"] = "รูปภาพที่ใช้สำหรับไข่เด่นและประวัติการขโมย",
    ["Egg Image"] = "รูปไข่",
    ["Sort: Best Rarity"] = "เรียงตาม: ระดับความหายากสูงสุด",
    ["Sacred Moth"] = "ผีเสื้อกลางคืนศักดิ์สิทธิ์",
    ["Astral Jackalope"] = "แจ็กคาโลปแห่งดวงดาว",
    ["Holy Peacock"] = "นกยูงศักดิ์สิทธิ์",
    ["Imp"] = "อิมพ์",
    ["Pick up to two weapons you own to switch between while hitting (empty = best bat only)"] = "เลือกอาวุธที่มีได้สูงสุด 2 ชิ้นเพื่อสลับใช้ขณะตี (เว้นว่าง = ใช้ไม้ตีที่ดีที่สุดเท่านั้น)",
}
for english,thai in pairs(ZIGZAG_V174_ADDED_TRANSLATIONS) do
    if TRANSLATIONS[english] == nil then
        TRANSLATIONS[english] = thai
    end
end

--========================================================
-- V1.7.1 VERIFIED BASE + V1.7.4 + 2026-10-14 LABELS
-- ONLY missing English -> Thai dictionary entries from three screenshots.
-- NO loader, translator, UI, theme, scan, or gameplay logic changes.
-- Must run BEFORE cache/lookup construction; old translations win.
--========================================================
local ZIGZAG_NEW_STEAL_METHOD_LABELS = {
    ["Move To Egg"] = "วิธีเคลื่อนที่ไปหาไข่",
    ["Delivery Method"] = "วิธีส่งไข่กลับฐาน",
    ["Teleport"] = "วาร์ป",
    ["Step"] = "ทีละขั้น",
    ["Tween"] = "เคลื่อนที่ลื่นไหล",
}
for english,thai in pairs(ZIGZAG_NEW_STEAL_METHOD_LABELS) do
    if TRANSLATIONS[english] == nil then
        TRANSLATIONS[english] = thai
    end
end

--========================================================
-- ZIGZAG 2026-10-18 HALLOWEEN UPDATE (ADDITIVE TRANSLATIONS ONLY)
-- UI labels captured from CHILLI Hub screenshots; game logic unchanged.
-- Stays before lookup/cache construction, so every new label is reactive.
-- No new task loops, GUIs, re-loads, teleport hooks, or .Text overrides.
--========================================================
local ZIGZAG_HALLOWEEN_TRANSLATIONS = {
    ["Halloween Dimension"] = "มิติฮาโลวีน",
    ["Halloween Monsters"] = "มอนสเตอร์ฮาโลวีน",
    ["Ghost Dog & Fishing"] = "เควสต์สุนัขผีและตกปลา",
    ["Ghost Dog and Fishing"] = "เควสต์สุนัขผีและตกปลา",
    ["Phantom Express"] = "รถไฟภูตพราย",
    ["Auto Steal Halloween Eggs"] = "ออโต้ขโมยไข่ฮาโลวีน",
    ["Instant Steal Halloween Eggs"] = "ขโมยไข่ฮาโลวีนทันที",
    ["Steal Missing Halloween Index"] = "ขโมยไข่ฮาโลวีนที่ยังไม่มีในสารบัญ",
    ["Steal Speed"] = "ความเร็วขโมยไข่",
    ["Halloween Eggs To Steal"] = "ไข่ฮาโลวีนที่จะขโมย",
    ["Halloween Egg Rarities"] = "ระดับความหายากไข่ฮาโลวีน",
    ["Min Value"] = "มูลค่าขั้นต่ำ",
    ["Min Value ($/s)"] = "มูลค่าขั้นต่ำ ($/วินาที)",
    ["Auto Pumpkin Moon"] = "ออโต้กิจกรรมพระจันทร์ฟักทอง",
    ["Auto Buy Halloween Dimension Egg"] = "ออโต้ซื้อไข่จากมิติฮาโลวีน",
    ["Auto Farm Monsters"] = "ออโต้ฟาร์มมอนสเตอร์",
    ["Auto Kill Monsters"] = "ออโต้กำจัดมอนสเตอร์",
    ["Monsters To Kill"] = "มอนสเตอร์ที่จะกำจัด",
    ["Monsters"] = "มอนสเตอร์",
    ["Monster Order"] = "ลำดับการเลือกมอนสเตอร์",
    ["Closest First"] = "ใกล้ที่สุดก่อน",
    ["Most Tokens"] = "ได้โทเคนมากที่สุดก่อน",
    ["Use Weapons"] = "ใช้อาวุธ",
    ["Auto Ghost Dog Quest"] = "ออโต้ทำเควสต์สุนัขผี",
    ["Auto Fishing"] = "ออโต้ตกปลา",
    ["Cast Luck"] = "ตัวคูณโชคในการเหวี่ยงเบ็ด",
    ["x1.5 Perfect"] = "x1.5 สมบูรณ์แบบ",
    ["x1.2"] = "x1.2",
    ["x1.1"] = "x1.1",
    ["x1.0 Fastest"] = "x1.0 เร็วที่สุด",
    ["Quest"] = "เควสต์",
    ["Fish Caught"] = "จำนวนปลาที่จับได้",
    ["Auto Phantom Express"] = "ออโต้รถไฟภูตพราย",
    ["Auto Vacuum Ghouler Boss"] = "ออโต้ดูดบอส Ghouler",
    ["Ghost Target"] = "เป้าหมายผี",
    ["Rarest First"] = "หายากที่สุดก่อน",
    ["Auto Trade Souls"] = "ออโต้แลกวิญญาณ",
    ["Train"] = "รถไฟ",
    ["Souls"] = "วิญญาณ",
    ["Not Here"] = "ยังไม่มา",
    ["Halloween Eggs"] = "ไข่ฮาโลวีน",
    ["Halloween Rarities"] = "ระดับความหายากไข่ฮาโลวีน",
    ["Auto Buy Halloween Egg"] = "ออโต้ซื้อไข่ฮาโลวีน",
    ["Ghost Dog Quest"] = "เควสต์สุนัขผี",
    ["Pumpkin Moon"] = "พระจันทร์ฟักทอง",
    ["Ghost Dog"] = "สุนัขผี",
    ["Fishing"] = "ตกปลา",
}
for english,thai in pairs(ZIGZAG_HALLOWEEN_TRANSLATIONS) do
    if TRANSLATIONS[english] == nil then
        TRANSLATIONS[english] = thai
    end
end

--========================================================
-- ZIGZAG V1.8.5: 2026-10-20 NEW CHILLI / VENYX LABELS
-- From screenshots: Phantom Express wait, fishing spot, Blood Moon.
-- Additive dictionary entries ONLY; do not change UI behavior.
--========================================================
local ZIGZAG_V184_CHILLI_LABELS = {
    ["Halloween & Star"] = "ฮาโลวีนและดาวตก",
    ["Place and hatch missing index eggs"] = "วางและฟักไข่ที่ยังไม่มีในสารบัญ",
    ["Fishing Spot"] = "จุดตกปลา",
    ["Save Spot Here"] = "บันทึกจุดตกปลาที่นี่",
    ["Spot 1"] = "จุด 1",
    ["Spot 2"] = "จุด 2",
    ["Spot 3"] = "จุด 3",
    ["Waiting for the Phantom Express"] = "กำลังรอรถไฟภูตพราย",
    ["Only During Blood Moon"] = "เฉพาะช่วงพระจันทร์สีเลือด",
    ["Fighting Large monster"] = "กำลังต่อสู้กับมอนสเตอร์ขนาดใหญ่",
}
--========================================================
-- ZIGZAG V1.8.5 • NEW CHILLI + VENYX UPDATE (2026-10-21)
-- Translation entries only, from seven screenshots. No gameplay/UI changes.
-- Also embedded in the teleport translator-only copy.
--========================================================
local ZIGZAG_V185_CHILLI_LABELS = {
    ["Waiting: nothing to do"] = "กำลังรอ: ไม่มีงานให้ทำ",
    ["Take Halloween Eggs From Holders"] = "แย่งไข่ฮาโลวีนจากผู้ที่กำลังถือ",
    ["Teleport To Pumpkins"] = "วาร์ปไปหาฟักทอง",
    ["Teleport To Monsters"] = "วาร์ปไปหามอนสเตอร์",
    ["Teleport To Ghosts"] = "วาร์ปไปหาผี",
    ["Farm All Monsters In Blood Moon"] = "ฟาร์มมอนสเตอร์ทั้งหมดช่วงพระจันทร์สีเลือด",
    ["Farm Monsters While Fishing"] = "ฟาร์มมอนสเตอร์ระหว่างตกปลา",
    ["Fishing History"] = "ประวัติการตกปลา",
    ["Catches"] = "จำนวนที่จับได้",
}
for english,thai in pairs(ZIGZAG_V185_CHILLI_LABELS) do
    if TRANSLATIONS[english] == nil then
        TRANSLATIONS[english] = thai
    end
end

--========================================================
-- ZIGZAG V1.8.6 • CHILLI/VENYX V1.2.8 PRIORITY + THE HOLLOW
-- Additive display-only translations, including screenshots 1-7.
-- Present both in main translator and teleport-only continuation.
--========================================================
local ZIGZAG_V186_CHILLI_LABELS = {
    ["Priority Rotation"] = "สลับงานตามลำดับความสำคัญ",
    ["Rotate Fishing And Treadmill"] = "สลับตกปลากับลู่วิ่ง",
    ["Rotation Switch"] = "เงื่อนไขการสลับงาน",
    ["Fishing Minutes"] = "เวลาตกปลา (นาที)",
    ["Treadmill Minutes"] = "เวลาวิ่งลู่ (นาที)",
    ["Timer"] = "ตั้งเวลา",
    ["Every day"] = "ทุกวัน",
    ["Switch"] = "สลับงาน",
    ["The Hollow"] = "เดอะฮอลโลว์",
    ["The Hollow Race"] = "การแข่งขันเดอะฮอลโลว์",
    ["Auto Race The Hollow"] = "แข่งเดอะฮอลโลว์อัตโนมัติ",
    ["Hollow Race Speed"] = "ความเร็วแข่งเดอะฮอลโลว์",
    ["Use Race Power-Ups"] = "ใช้ไอเทมเพิ่มพลังระหว่างแข่ง",
    ["Wins"] = "ชัยชนะ",
    ["NOW"] = "ตอนนี้",
    ["DOING NOW"] = "กำลังทำ",
    ["SWITCH IN"] = "สลับในอีก",
    ["Farm monsters"] = "ฟาร์มมอนสเตอร์",
    ["Farm monsters in Blood Moon"] = "ฟาร์มมอนสเตอร์ช่วงพระจันทร์สีเลือด",
    ["Place eggs"] = "วางไข่",
    ["Mutate eggs"] = "ทำให้ไข่กลายพันธุ์",
    ["Wisp quest"] = "ภารกิจ Wisp",
    ["Riding the Phantom Express"] = "กำลังขึ้นรถไฟภูตพราย",
    ["Fighting Small monster"] = "กำลังต่อสู้กับมอนสเตอร์ขนาดเล็ก",
    ["Top goes first. A task never stops halfway: the next one waits until it finishes. A carried egg is always delivered first."] = "งานลำดับบนสุดทำก่อน งานที่เริ่มแล้วจะทำให้เสร็จก่อนจึงสลับงานถัดไป และจะนำไข่ที่ถืออยู่ไปส่งก่อนเสมอ",
    ["Lower it if laps do not count"] = "ลดความเร็วลงหากระบบไม่นับรอบการแข่งขัน",
}
for english,thai in pairs(ZIGZAG_V186_CHILLI_LABELS) do
    if TRANSLATIONS[english] == nil then
        TRANSLATIONS[english] = thai
    end
end

--========================================================
-- ZIGZAG V1.8.7 • CHILLI AUTO STEAL / SELL / MUTATION / EVENT / VENYX PROMO
-- Display translations from 7 screenshots (2026-10-25).
-- No source gameplay, UI hierarchy, callbacks, or movement edits.
-- Applied in BOTH main and teleport translator-only copies.
--========================================================
local ZIGZAG_V187_CHILLI_LABELS = {
    ["Move To Egg Speed"] = "ความเร็วในการไปหาไข่",
    ["Move to Egg Speed"] = "ความเร็วในการไปหาไข่",
    ["Delivery"] = "วิธีส่งไข่กลับฐาน",
    ["Fast Tween"] = "เคลื่อนที่เร็วแบบ Tween",
    ["Fast Tween Speed"] = "ความเร็วส่งไข่แบบ Tween",
    ["Instant Steps"] = "เคลื่อนที่ทันทีแบบเป็นขั้น",
    ["Leap"] = "กระโดดพุ่ง",
    ["Auto Claim Money"] = "รับเงินอัตโนมัติ",
    ["Auto Claim Cash"] = "รับเงินอัตโนมัติ",
    ["Sell matching eggs once"] = "ขายไข่ที่ตรงเงื่อนไขหนึ่งครั้ง",
    ["Sell matching eggs once."] = "ขายไข่ที่ตรงเงื่อนไขหนึ่งครั้ง",
    ["Sell Egg Rule"] = "กฎการขายไข่",
    ["Egg Max Rarity"] = "ความหายากสูงสุดของไข่ที่จะขาย",
    ["Sell eggs at or below this rarity"] = "ขายไข่ระดับนี้หรือต่ำกว่า",
    ["Sell eggs at or below this rarity."] = "ขายไข่ระดับนี้หรือต่ำกว่า",
    ["Egg Sell Value"] = "มูลค่าไข่ที่จะขาย",
    ["Sell eggs worth less than this (0 = off)"] = "ขายไข่ที่มูลค่าต่ำกว่าที่กำหนด (0 = ปิด)",
    ["Keep Mutated Eggs"] = "เก็บไข่ที่กลายพันธุ์ไว้",
    ["Never sell mutated eggs"] = "ห้ามขายไข่ที่กลายพันธุ์",
    ["Never sell mutated eggs."] = "ห้ามขายไข่ที่กลายพันธุ์",
    ["Blacklist Sell Eggs"] = "รายการไข่ห้ามขาย",
    ["These eggs are never sold"] = "ไข่เหล่านี้จะไม่ถูกขาย",
    ["These eggs are never sold."] = "ไข่เหล่านี้จะไม่ถูกขาย",
    ["Cursed Island Wars"] = "สงครามเกาะต้องสาป",
    ["Waiting for Cursed Island Wars"] = "กำลังรอสงครามเกาะต้องสาป",
    ["Auto Play Cursed Island Wars"] = "เล่นสงครามเกาะต้องสาปอัตโนมัติ",
    ["Island Wars Target"] = "เป้าหมายสงครามเกาะต้องสาป",
    ["Enemies And Base"] = "ศัตรูและฐาน",
    ["Walls And Crystal"] = "กำแพงและคริสตัล",
    ["Smoother, faster and more ways to steal."] = "ลื่นไหลขึ้น เร็วขึ้น พร้อมวิธีขโมยที่หลากหลายกว่าเดิม",
    ["Smoother, faster and more ways to steal"] = "ลื่นไหลขึ้น เร็วขึ้น พร้อมวิธีขโมยที่หลากหลายกว่าเดิม",
    ["Try now"] = "ลองใช้งานเลย",
    ["Try Now"] = "ลองใช้งานเลย",
    ["Smoother & faster"] = "ลื่นไหลและเร็วขึ้น",
    ["Smoother and faster"] = "ลื่นไหลและเร็วขึ้น",
    ["Less lag, quick to load."] = "แลคน้อยลง โหลดเร็วขึ้น",
    ["Less lag, quick to load"] = "แลคน้อยลง โหลดเร็วขึ้น",
    ["More steal methods"] = "มีวิธีขโมยไข่มากขึ้น",
    ["Teleport, Fast tween and more."] = "วาร์ป เคลื่อนที่เร็วแบบ Tween และอีกมากมาย",
    ["Teleport, Fast tween and more"] = "วาร์ป เคลื่อนที่เร็วแบบ Tween และอีกมากมาย",
    ["Teleport, Fast Tween and more."] = "วาร์ป เคลื่อนที่เร็วแบบ Tween และอีกมากมาย",
    ["Steal from players"] = "ขโมยไข่จากผู้เล่น",
    ["Hits whoever takes your egg."] = "โจมตีผู้ที่แย่งไข่ของคุณไป",
    ["Hits whoever takes your egg"] = "โจมตีผู้ที่แย่งไข่ของคุณไป",
    ["Easy setup"] = "ตั้งค่าง่าย",
    ["Bring your Chilli config over."] = "นำคอนฟิกจาก Chilli มาใช้ได้",
    ["Bring your Chilli config over"] = "นำคอนฟิกจาก Chilli มาใช้ได้",
}
for english,thai in pairs(ZIGZAG_V187_CHILLI_LABELS) do
    TRANSLATIONS[english] = thai
end

for english,thai in pairs(ZIGZAG_V184_CHILLI_LABELS) do
    if TRANSLATIONS[english] == nil then
        TRANSLATIONS[english] = thai
    end
end

--========================================================
-- 4. LOOKUP / CACHE  (V1.1 engine preserved)
--========================================================

local LOWER_TRANSLATIONS = {}
local TRANSLATED_OUTPUTS = {}
for english,thai in pairs(TRANSLATIONS) do
    LOWER_TRANSLATIONS[string.lower(english)] = thai
    TRANSLATED_OUTPUTS[thai] = true
end
local STRING_CACHE = {}

--========================================================
-- 5. HELPERS
--========================================================

local function CleanText(text)
    if type(text) ~= "string" then return "" end
    local clean = text:gsub("<[^>]+>", "")
    return clean:match("^%s*(.-)%s*$") or clean
end

local function TranslateState(value)
    local lower = string.lower(value or "")
    if lower == "off" then return "ปิด"
    elseif lower == "on" then return "เปิด"
    elseif lower == "idle" then return "ว่าง"
    elseif lower == "none" then return "ไม่มี"
    elseif lower == "default" then return "ค่าเริ่มต้น" end
    return value
end

--========================================================
-- 6. TRANSLATE
--========================================================

local function TranslateText(text)
    if type(text) ~= "string" or text == "" then return text end
    local cached = STRING_CACHE[text]
    if cached ~= nil then return cached end
    local clean = CleanText(text)
    if clean == "" then
        STRING_CACHE[text] = text
        return text
    end

    if TRANSLATED_OUTPUTS[clean] then
        STRING_CACHE[text] = clean
        return clean
    end

    local exact = LOWER_TRANSLATIONS[string.lower(clean)]
    if exact then
        STRING_CACHE[text] = exact
        return exact
    end

    -- V1.8.7 • Mutation capacity (e.g. "20 egg(s) can be mutated")
    local mutatableCount = string.lower(clean):match("^(%d+)%s+egg%(s%)%s+can%s+be%s+mutated%.?$")
        or string.lower(clean):match("^(%d+)%s+eggs?%s+can%s+be%s+mutated%.?$")
    if mutatableCount then
        local result = "มีไข่ที่กลายพันธุ์ได้ " .. mutatableCount .. " ฟอง"
        STRING_CACHE[text] = result
        return result
    end

    -- V1.8.6 • numeric/dynamic event status, no extra UI watchers.
    local hollowState,hollowWins,hollowTotal =
        clean:match("^(%a+)%s*|%s*Wins:%s*(%d+)%s*/%s*(%d+)$")
    if hollowState and (string.lower(hollowState)=="off" or string.lower(hollowState)=="on") then
        local result = TranslateState(hollowState) .. " | ชัยชนะ: " .. hollowWins .. "/" .. hollowTotal
        STRING_CACHE[text] = result
        return result
    end
    local hollowWinsOnly,hollowTotalOnly = clean:match("^Wins:%s*(%d+)%s*/%s*(%d+)$")
    if hollowWinsOnly then
        local result = "ชัยชนะ: " .. hollowWinsOnly .. "/" .. hollowTotalOnly
        STRING_CACHE[text] = result
        return result
    end
    local minutes = clean:match("^(%d+)%s+min$")
    if minutes then
        local result = minutes .. " นาที"
        STRING_CACHE[text] = result
        return result
    end
    local nextTask = clean:match("^NEXT%s+(%d+)$")
    if nextTask then
        local result = "ถัดไป " .. nextTask
        STRING_CACHE[text] = result
        return result
    end


    -- V1.7: Dynamic race countdown (example: Off | Next Racing Event in 17:12)
    -- Exact race labels are mapped above; the rest of the translator is untouched.
    local raceState,raceCountdown =
        clean:match("^(%a+)%s*|%s*Next Racing Event in%s*(.+)$")
    if raceState and raceCountdown then
        local stateLower = string.lower(raceState)
        if stateLower == "off" or stateLower == "on" then
            local result = TranslateState(stateLower)
                .. " | กิจกรรมแข่งวิ่งครั้งถัดไปใน " .. raceCountdown
            STRING_CACHE[text] = result
            return result
        end
    end

    local rarityNumber,rarityName = clean:match("^(%d+)%s*%-%s*(.-)%s*$")
    if rarityNumber and rarityName then
        local rarityThai = LOWER_TRANSLATIONS[string.lower(rarityName)]
        if rarityThai then
            local result = rarityNumber .. " - " .. rarityThai
            STRING_CACHE[text] = result
            return result
        end
    end

    local sortMode = clean:match("^Sort:?%s*(.+)$")
    if sortMode then
        local sortThai = LOWER_TRANSLATIONS[string.lower(CleanText(sortMode))] or sortMode
        local result = "เรียงตาม: " .. sortThai
        STRING_CACHE[text] = result
        return result
    end

    -- V1.2 FIX: Lua patterns do not use (ON|OFF) alternation.
    -- Exact mappings above handle all four ON/OFF UI labels.
    -- This branch remains for dynamic variants of the same statuses.
    local autoStealState = clean:match("^Auto Steal:%s*(%u+)$")
    if autoStealState == "ON" or autoStealState == "OFF" then
        local result = "ออโต้ขโมย: " .. TranslateState(string.lower(autoStealState))
        STRING_CACHE[text] = result
        return result
    end

    local instantStealState = clean:match("^Instant Steal:%s*(%u+)$")
    if instantStealState == "ON" or instantStealState == "OFF" then
        local result = "ขโมยทันที: " .. TranslateState(string.lower(instantStealState))
        STRING_CACHE[text] = result
        return result
    end

    local startupConfig = clean:match("^Startup Config:%s*(.+)$")
    if startupConfig then
        local result = "คอนฟิกเริ่มต้น: " .. TranslateState(startupConfig)
        STRING_CACHE[text] = result
        return result
    end
    local autoSaveConfig = clean:match("^Auto save:%s*(.+)$")
    if autoSaveConfig then
        local result = "บันทึกอัตโนมัติ: " .. TranslateState(autoSaveConfig)
        STRING_CACHE[text] = result
        return result
    end
    local autoLoadConfig = clean:match("^Auto load:%s*(.+)$")
    if autoLoadConfig then
        local result = "โหลดอัตโนมัติ: " .. TranslateState(autoLoadConfig)
        STRING_CACHE[text] = result
        return result
    end
    local saveConfig = clean:match("^Save:%s*(.+)$")
    if saveConfig then
        local result = "บันทึก: " .. TranslateState(saveConfig)
        STRING_CACHE[text] = result
        return result
    end

    local allCount = clean:match("^ALL%s+(%d+)$")
    if allCount then
        local result = "ทั้งหมด " .. allCount
        STRING_CACHE[text] = result
        return result
    end
    local readyCount = clean:match("^READY%s+(%d+)$")
    if readyCount then
        local result = "พร้อม " .. readyCount
        STRING_CACHE[text] = result
        return result
    end
    local growingCount = clean:match("^GROWING%s+(%d+)$")
    if growingCount then
        local result = "กำลังโต " .. growingCount
        STRING_CACHE[text] = result
        return result
    end
    local inBagCount = clean:match("^IN BAG%s+(%d+)$")
    if inBagCount then
        local result = "ในกระเป๋า " .. inBagCount
        STRING_CACHE[text] = result
        return result
    end
    local currentEgg,totalEggsByValue = clean:match("^#(%d+)%s+of%s+(%d+)%s+eggs%s+by%s+value$")
    if currentEgg then
        local result = "#" .. currentEgg .. " จาก " .. totalEggsByValue .. " ไข่ เรียงตามมูลค่า"
        STRING_CACHE[text] = result
        return result
    end
    local a,b = clean:match("^Players%s+(%d+)%/(%d+)$")
    if a then
        local result = "ผู้เล่น " .. a .. "/" .. b
        STRING_CACHE[text] = result
        return result
    end
    local selected = clean:match("^(%d+)%s+selected$")
    if selected then
        local result = "เลือกแล้ว " .. selected .. " รายการ"
        STRING_CACHE[text] = result
        return result
    end
    local quick = clean:match("^Quick Bar%s*(%d+)$")
    if quick then
        local result = "แถบลัด " .. quick
        STRING_CACHE[text] = result
        return result
    end
    local mechPortalTime = clean:match("^Next Mech portal in%s+(.+)$")
    if mechPortalTime then
        local result = "ประตู Mech ครั้งถัดไปใน " .. mechPortalTime
        STRING_CACHE[text] = result
        return result
    end
    local petMatches,petValue = clean:match("^Pet matches%s*%-%s*(%d+)%s+pets?%s+for%s+%$(.+)$")
    if petMatches then
        local result = "สัตว์เลี้ยงที่ตรงเงื่อนไข - " .. petMatches .. " ตัว มูลค่า $" .. petValue
        STRING_CACHE[text] = result
        return result
    end
    local eggMatches,eggMatchValue = clean:match("^Egg matches%s*%-%s*(%d+)%s+eggs?%s+for%s+%$(.+)$")
    if eggMatches then
        local result = "ไข่ที่ตรงเงื่อนไข - " .. eggMatches .. " ฟอง มูลค่า $" .. eggMatchValue
        STRING_CACHE[text] = result
        return result
    end
    local fuseAmount,fuseSpecies,fuseValue = clean:match("^Next fuse%s*%-%s*(%d+)%s+(.+)%s+for%s+%$(.+)$")
    if fuseAmount then
        local result = "การผสมถัดไป - " .. fuseAmount .. " " .. fuseSpecies .. " มูลค่า $" .. fuseValue
        STRING_CACHE[text] = result
        return result
    end
    local favMatches,favToMark,favDone = clean:match("^Favorite matches%s*%-%s*(%d+)%s+pets?,%s*(%d+)%s+to mark%s*|%s*(%d+)%s+favorited$")
    if favMatches then
        local result = "ตรงเงื่อนไข " .. favMatches .. " ตัว | ต้องกด " .. favToMark .. " ตัว | กดถูกใจแล้ว " .. favDone .. " ตัว"
        STRING_CACHE[text] = result
        return result
    end
    local bloomState,bloomLeft = clean:match("^(%a+)%s*|%s*Butterfly Bloom live,%s*(.-)%s+left$")
    if bloomState and (string.lower(bloomState) == "on" or string.lower(bloomState) == "off") then
        local result = TranslateState(bloomState) .. " | กิจกรรมผีเสื้อผลิบานกำลังทำงาน เหลือ " .. bloomLeft
        STRING_CACHE[text] = result
        return result
    end
    local bloomOnly = clean:match("^Butterfly Bloom live,%s*(.-)%s+left$")
    if bloomOnly then
        local result = "กิจกรรมผีเสื้อผลิบานกำลังทำงาน เหลือ " .. bloomOnly
        STRING_CACHE[text] = result
        return result
    end
    local charges,eggsNow,eggsMax,tries,applied = clean:match("^Charges%s+(%d+)%s+Eggs%s+(%d+)%/(%d+)%s+Tries%s+(%d+)%s+Applied%s+(%d+)$")
    if charges then
        local result = "ชาร์จ " .. charges .. " | ไข่ " .. eggsNow .. "/" .. eggsMax .. " | ลอง " .. tries .. " | ใช้แล้ว " .. applied
        STRING_CACHE[text] = result
        return result
    end
    local banner,needed,pity,rerolls,rotateTime = clean:match("^(.-)%s*%-%s*needs%s*(.-)%s*%-%s*pity%s*(.-)%s*%-%s*free rerolls%s*(.-)%s*%-%s*rotates in%s*(.-)$")
    if banner then
        local bannerClean = banner:match("^%s*(.-)%s*$")
        local bannerThai = LOWER_TRANSLATIONS[string.lower(bannerClean)] or bannerClean
        local result = bannerThai .. " - ต้องการ " .. needed .. " - การันตี " .. pity .. " - สุ่มฟรี " .. rerolls .. " - เปลี่ยนใน " .. rotateTime
        STRING_CACHE[text] = result
        return result
    end
    local eggCount,value = clean:match("^Lab egg matches%s*%-%s*(%d+)%s*eggs%s*for%s*%$(.*)$")
    if eggCount then
        local result = "เจอไข่แล็บเข้าเงื่อนไข " .. eggCount .. " ฟอง มูลค่า $" .. value
        STRING_CACHE[text] = result
        return result
    end
    local lastSteal = clean:match("^Last Steal:%s*(.+)$")
    if lastSteal then
        local result = "การขโมยล่าสุด: " .. TranslateState(lastSteal)
        STRING_CACHE[text] = result
        return result
    end
    local lastIssue = clean:match("^Last issue:%s*(.+)$")
    if lastIssue then
        local result = "ปัญหาล่าสุด: " .. TranslateState(lastIssue)
        STRING_CACHE[text] = result
        return result
    end
    local lastSell = clean:match("^Last Sell:%s*(.+)$")
    if lastSell then
        local result = "การขายล่าสุด: " .. TranslateState(lastSell)
        STRING_CACHE[text] = result
        return result
    end
    local lastFuse = clean:match("^Last Fuse:%s*(.+)$")
    if lastFuse then
        local result = "การผสมล่าสุด: " .. TranslateState(lastFuse)
        STRING_CACHE[text] = result
        return result
    end

    -- Safe partial replacements from original engine only.
    local result = clean
    result = result:gsub("UPDATED%s*&%s*WORKING", "อัปเดตแล้วและใช้งานได้")
    result = result:gsub("EXPERIMENTAL%s*/%s*NO UPDATES", "ทดลอง / ไม่มีอัปเดต")
    result = result:gsub("Only for Chase mode", "ใช้เฉพาะโหมดไล่จับ")
    if result ~= clean then
        STRING_CACHE[text] = result
        return result
    end
    STRING_CACHE[text] = text
    return text
end

--========================================================
-- 7-9. TEXT OBJECT / APPLY / DYNAMIC WATCHING
--========================================================

local function IsTextObject(object)
    return object:IsA("TextLabel") or object:IsA("TextButton") or object:IsA("TextBox")
end
local Busy = setmetatable({}, {__mode="k"})
local Watched = setmetatable({}, {__mode="k"})

local function ApplyTranslation(object,shouldWatch)
    if not IsTextObject(object) or Busy[object] then return false end
    Busy[object] = true
    local changed = false
    pcall(function()
        local oldText = object.Text
        local newText = TranslateText(oldText)
        if newText ~= oldText then
            object.Text = newText
            changed = true
        end
    end)
    if object:IsA("TextBox") then
        pcall(function()
            local oldText = object.PlaceholderText
            local newText = TranslateText(oldText)
            if newText ~= oldText then
                object.PlaceholderText = newText
                changed = true
            end
        end)
    end
    Busy[object] = nil
    if shouldWatch and not Watched[object] then
        Watched[object] = true
        Bind(object:GetPropertyChangedSignal("Text"):Connect(function()
            if Busy[object] or not object.Parent then return end
            ApplyTranslation(object,false)
        end))
        if object:IsA("TextBox") then
            Bind(object:GetPropertyChangedSignal("PlaceholderText"):Connect(function()
                if Busy[object] or not object.Parent then return end
                ApplyTranslation(object,false)
            end))
        end
    end
    return changed
end

--========================================================
-- 10-14. ROOTS / DETECTION / CHILLI TRACKER
--========================================================

local UI_ROOTS = {}
local function AddRoot(root)
    if not root then return false end
    for _,existing in ipairs(UI_ROOTS) do
        if existing == root then return false end
    end
    table.insert(UI_ROOTS,root)
    return true
end
AddRoot(PlayerGui)
AddRoot(CoreGui)
if type(gethui) == "function" then
    local ok,hui = pcall(gethui)
    if ok and hui then AddRoot(hui) end
end
local function IsKnownRoot(object)
    for _,root in ipairs(UI_ROOTS) do
        if object == root then return true end
    end
    return false
end
local function IsChilliTitle(object)
    if not IsTextObject(object) then return false end
    local ok,text = pcall(function() return object.Text end)
    if not ok or type(text) ~= "string" then return false end
    return string.lower(text):find("chilli hub",1,true) ~= nil
end
local function FindChilliContainer(object)
    if not object then return nil end
    local current = object
    local fallback = nil
    while current do
        if current:IsA("ScreenGui") then return current end
        if current:IsA("Frame") or current:IsA("CanvasGroup") or current:IsA("ScrollingFrame") then
            fallback = current
        end
        local parent = current.Parent
        if parent and IsKnownRoot(parent) then return current end
        current = parent
    end
    return fallback
end
--========================================================
-- ZIGZAG V1.6 DR-FIX PURPLE / BLACK THEME (THAI ENGINE ISOLATED)
-- Logo asset from ZIGZAG BF: rbxassetid://104570286698558
-- Theme touches visual properties only; new watermark is very translucent.
-- It NEVER modifies .Text / .PlaceholderText / translation caches.
--========================================================

local ZIGZAG_LOGO = "rbxassetid://104570286698558"
local THEME_ORIGINAL = setmetatable({}, {__mode="k"})
local THEME_WATCHED = setmetatable({}, {__mode="k"})
local THEME_WRITING = setmetatable({}, {__mode="k"})
local THEME_PENDING = setmetatable({}, {__mode="k"})
local THEME_LOGOS = {}  -- header icon only; no floating watermark / no ZIndex changes

-- DR-FIX 2: after clicking Chilli recreates/recolors the same UI objects.
-- Prior DR-FIX remembered THEME_STYLED and refused to repaint an object
-- once it had been purple; later source updates could turn its lower border
-- red again. This version re-applies only when a relevant visual property
-- actually changes, instead of repeatedly rescanning the whole UI.
local function IsRedAccent(color)
    if typeof(color) ~= "Color3" then return false end
    local r,g,b = color.R,color.G,color.B
    return r >= 0.43 and r > g * 1.37 and r > b * 1.28
        and (r - math.max(g,b)) > 0.19
end

local function PurpleFromRed(color)
    local _,s,v = Color3.toHSV(color)
    return Color3.fromHSV(0.765, math.clamp(s*0.93,0.48,0.94),
        math.clamp(v*0.96,0.30,1))
end

local function SaveStyle(object,property,newValue)
    local orig = THEME_ORIGINAL[object]
    if not orig then
        orig = {}
        THEME_ORIGINAL[object] = orig
    end
    if orig[property] == nil then
        local ok,value = pcall(function() return object[property] end)
        if not ok then return end
        orig[property] = value
    end
    if THEME_WRITING[object] then return end
    THEME_WRITING[object] = true
    pcall(function() object[property] = newValue end)
    THEME_WRITING[object] = nil
end

local function IsLargeThemeSurface(object)
    if not object or not object:IsA("GuiObject") then return false end
    local ok,w,h = pcall(function()
        local size = object.AbsoluteSize
        return size.X,size.Y
    end)
    if not ok then return false end
    if w < 85 and h < 28 then
        local sx = object.Size
        if sx.X.Offset < 85 and sx.X.Scale < 0.18 then return false end
    end
    return w >= 85 or object.Size.X.Offset >= 85
        or (object.Size.X.Scale >= 0.18 and h >= 27)
end

local function ParentVisualSurface(object)
    if not object then return nil end
    local parent = object.Parent
    if parent and parent:IsA("UIStroke") then parent = parent.Parent end
    return parent
end

local function IsThemeVisual(object)
    if not object then return false end
    if object.Name == "ZIGZAG_ThemeLogo_V14"
        or object.Name == "ZIGZAG_BackgroundWatermark_V15"
        or object.Name == "ZIGZAG_THEME_WALLPAPER" then return false end
    if object:IsA("UIStroke") or object:IsA("UIGradient") then
        return IsLargeThemeSurface(ParentVisualSurface(object))
    end
    return object:IsA("GuiObject") and IsLargeThemeSurface(object)
        and (object:IsA("Frame") or object:IsA("TextButton")
          or object:IsA("ImageButton") or object:IsA("ScrollingFrame")
          or object:IsA("TextLabel") or object:IsA("ImageLabel"))
end

local function RepaintRedProperty(object,property)
    local ok,color=pcall(function() return object[property] end)
    if ok and IsRedAccent(color) then
        SaveStyle(object,property,PurpleFromRed(color))
    end
end

local function RepaintGradient(object)
    local ok,gradient=pcall(function() return object.Color end)
    if not ok or not gradient then return end
    local points,changed={},false
    for _,pt in ipairs(gradient.Keypoints) do
        local color=pt.Value
        if IsRedAccent(color) then
            color=PurpleFromRed(color)
            changed=true
        end
        table.insert(points,ColorSequenceKeypoint.new(pt.Time,color))
    end
    if changed then SaveStyle(object,"Color",ColorSequence.new(points)) end
end

-- One listener per eligible property, no while loop / no RenderStepped.
-- task.defer coalesces successive changes in the same UI update.
local function WatchThemeProperty(object,property)
    local seen=THEME_WATCHED[object]
    if not seen then
        seen={}
        THEME_WATCHED[object]=seen
    end
    if seen[property] then return end
    seen[property]=true
    local ok,conn=pcall(function()
        return object:GetPropertyChangedSignal(property):Connect(function()
            if THEME_WRITING[object] or not object.Parent then return end
            local pending=THEME_PENDING[object]
            if not pending then
                pending={}
                THEME_PENDING[object]=pending
            end
            if pending[property] then return end
            pending[property]=true
            task.defer(function()
                pending[property]=nil
                if not object.Parent or not IsThemeVisual(object) then return end
                if object:IsA("UIGradient") then
                    RepaintGradient(object)
                else
                    RepaintRedProperty(object,property)
                end
            end)
        end)
    end)
    if ok and conn then
        Bind(conn)
    else
        seen[property]=nil
    end
end

local function ThemeObject(object)
    if not object or not object.Parent or not IsThemeVisual(object) then return end
    if object:IsA("UIGradient") then
        RepaintGradient(object)
        WatchThemeProperty(object,"Color")
        return
    end
    if object:IsA("UIStroke") then
        RepaintRedProperty(object,"Color")
        WatchThemeProperty(object,"Color")
        return
    end

    -- Handles Chilli's bottom red strip (Frame.BackgroundColor3),
    -- border outlines and tab-button colors without changing text.
    RepaintRedProperty(object,"BackgroundColor3")
    RepaintRedProperty(object,"BorderColor3")
    WatchThemeProperty(object,"BackgroundColor3")
    WatchThemeProperty(object,"BorderColor3")

    -- Only recolor explicitly red-tinted GUI art, not colored icons.
    if object:IsA("ImageLabel") or object:IsA("ImageButton") then
        RepaintRedProperty(object,"ImageColor3")
        WatchThemeProperty(object,"ImageColor3")
    end

    -- Preserve dark-purple surfaces, but don't force transparency or ZIndex.
    if object:IsA("Frame") or object:IsA("ScrollingFrame") then
        pcall(function()
            if object.BackgroundTransparency >= 0.65 then return end
            local bg=object.BackgroundColor3
            local r,g,b=bg.R,bg.G,bg.B
            local w,h=object.AbsoluteSize.X,object.AbsoluteSize.Y
            if math.abs(r-g)<0.07 and math.abs(r-b)<0.07
                and r<0.19 and w>=180 and h>=65 then
                SaveStyle(object,"BackgroundColor3",Color3.fromRGB(20,12,31))
            end
        end)
    end
end

local function PlaceZigzagLogo(title)
    if not title or not title.Parent then return end
    if not IsChilliTitle(title) then return end
    local host = title.Parent
    if not host:IsA("GuiObject") or host.AbsoluteSize.Y > 145 then
        host = title
    end
    if not host:IsA("GuiObject") then return end
    local existing = host:FindFirstChild("ZIGZAG_ThemeLogo_V14")
    if existing then return end
    local icon = Instance.new("ImageLabel")
    icon.Name = "ZIGZAG_ThemeLogo_V14"
    icon.BackgroundTransparency = 1
    icon.Active = false
    icon.Selectable = false
    icon.ScaleType = Enum.ScaleType.Fit
    icon.Image = ZIGZAG_LOGO
    icon.ImageTransparency = 0.02
    icon.AnchorPoint = Vector2.new(0,0.5)
    icon.Position = UDim2.new(0,12,0.5,0)
    icon.Size = UDim2.new(0,54,0,54)
    icon.ZIndex = title.ZIndex + 1
    icon.Parent = host
    table.insert(THEME_LOGOS,icon)
end

--========================================================
-- V1.5: ONE VERY FAINT ZIGZAG LOGO BEHIND MAIN CONTENT.
-- Adds no translation listeners and NEVER sets Text / PlaceholderText.
-- Does not change green switches or the game's background.
--========================================================
local function PlaceZigzagWatermark(gui)
    -- DR-FIX 1 SAFETY: disabled pending a verified non-interfering parent.
    -- V1.6 previously raised the ZIndex of every descendant of a guessed
    -- content frame. That could alter draw/hit-test order and obscure rows.
    -- Keep header ZIGZAG icon and purple color theme; never mutate layout.
    return
end

local function RestoreZigzagTheme()
    for object,props in pairs(THEME_ORIGINAL) do
        for property,original in pairs(props) do
            pcall(function() object[property] = original end)
        end
    end
    for _,icon in ipairs(THEME_LOGOS) do
        pcall(function() icon:Destroy() end)
    end
    table.clear(THEME_LOGOS)
end

-- Theme and watermark clean up automatically when rerun in the same session.
STATE.RestoreTheme = RestoreZigzagTheme
local DisconnectTranslations = STATE.Disconnect
function STATE.Disconnect()
    DisconnectTranslations()  -- stop theme property signals before restoring
    RestoreZigzagTheme()
end

local MainChilliGui = nil
local ChilliConnections = {}
local function DisconnectChilli()
    for _,connection in ipairs(ChilliConnections) do
        pcall(function() connection:Disconnect() end)
    end
    table.clear(ChilliConnections)
    MainChilliGui = nil
end
local function BindChilli(connection)
    if connection then
        table.insert(ChilliConnections,connection)
        Bind(connection)
    end
    return connection
end
--========================================================
-- DR. SCRAMBLE EMPTY AREA GUARD (iPad / low-lag)
-- Operates only on the Chilli content ScrollingFrame, if one is found.
-- No UI reconstruction, no feature toggles, no Text edits.
--========================================================
local UserInputService = game:GetService("UserInputService")
local DR_TITLES = setmetatable({}, {__mode="k"})
local DR_SCROLLS = setmetatable({}, {__mode="k"})
local DR_PENDING = setmetatable({}, {__mode="k"})
local DR_CLICK_GUARD_BOUND = false
local DR_LAST_TAP = 0

local function IsDrTitle(object)
    if not IsTextObject(object) then return false end
    local ok,label = pcall(function() return object.Text end)
    if not ok or type(label) ~= "string" then return false end
    label = string.lower(CleanText(label))
    return (string.find(label,"scramble",1,true) ~= nil
        and (string.find(label,"dr.",1,true) ~= nil
           or string.find(label,"dr ",1,true) ~= nil))
        and (string.find(label,"ห้องแล็บ",1,true) ~= nil
             or string.find(label,"lab",1,true) ~= nil)
end

local function IsGuiVisible(object)
    local current=object
    while current and current ~= MainChilliGui do
        if current:IsA("GuiObject") and not current.Visible then return false end
        current=current.Parent
    end
    return true
end

local function GetDrScroller(title,gui)
    local current=title and title.Parent
    while current and current~=gui do
        if current:IsA("ScrollingFrame") then return current end
        current=current.Parent
    end
    -- Some Chilli builds position the title beside, not within, the scroller.
    -- Find only a centered, on-screen scroll area below the title.
    if not title or not title.Parent then return nil end
    local center=title.AbsolutePosition.X+title.AbsoluteSize.X*0.5
    local top=title.AbsolutePosition.Y
    local best,bestScore=nil,-math.huge
    for _,item in ipairs(gui:GetDescendants()) do
        if item:IsA("ScrollingFrame") and IsGuiVisible(item) then
            local pos,size=item.AbsolutePosition,item.AbsoluteSize
            local mid=pos.X+size.X*0.5
            if size.X>=220 and size.Y>=110 and math.abs(mid-center)<size.X*0.55
                and pos.Y<top+180 and pos.Y+size.Y>top+100 then
                local score=size.X*size.Y/1000-math.abs(mid-center)
                if score>bestScore then best,bestScore=item,score end
            end
        end
    end
    return best
end

local function GetDirectContentHeight(scroller)
    local height=nil
    for _,child in ipairs(scroller:GetChildren()) do
        if child:IsA("UIListLayout") or child:IsA("UIGridLayout") then
            local ok,content=pcall(function() return child.AbsoluteContentSize.Y end)
            if ok and content and content>0 then height=math.max(height or 0,content) end
        end
    end
    return height
end

local function FixOverscroll(scroller)
    if not scroller or not scroller.Parent then return end
    local ok,err=pcall(function()
        local contentHeight=GetDirectContentHeight(scroller)
        if not contentHeight then return end  -- do not guess canvas height
        local viewHeight=scroller.AbsoluteWindowSize.Y
        if viewHeight<32 then return end
        local padding=22
        local maxY=math.max(0,contentHeight+padding-viewHeight)
        local y=scroller.CanvasPosition.Y
        if y>maxY+8 then
            scroller.CanvasPosition=Vector2.new(scroller.CanvasPosition.X,maxY)
            print("[ZIGZAG DR-FIX] corrected empty scroll region",math.floor(y),"->",math.floor(maxY))
        end
    end)
    if not ok then warn("[ZIGZAG DR-FIX] scroll check:",err) end
end

local function ScheduleDrScrollCheck(scroller)
    if not scroller or not scroller.Parent or DR_PENDING[scroller] then return end
    DR_PENDING[scroller]=true
    task.delay(0.20,function()
        DR_PENDING[scroller]=nil
        if scroller.Parent and MainChilliGui and scroller:IsDescendantOf(MainChilliGui) then
            FixOverscroll(scroller)
        end
    end)
end

local function WatchDrScroll(scroller)
    if not scroller or DR_SCROLLS[scroller] then return end
    DR_SCROLLS[scroller]=true
    -- Property and layout listeners, not a perpetual descendant scan.
    BindChilli(scroller:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
        ScheduleDrScrollCheck(scroller)
    end))
    for _,child in ipairs(scroller:GetChildren()) do
        if child:IsA("UIListLayout") or child:IsA("UIGridLayout") then
            BindChilli(child:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                ScheduleDrScrollCheck(scroller)
            end))
        end
    end
end

local function HandleDrHeaderTap(title)
    local gui=MainChilliGui
    if not gui or not gui.Parent or not title or not title.Parent then return end
    task.delay(0.22,function()
        if MainChilliGui~=gui or not title.Parent then return end
        local scroller=GetDrScroller(title,gui)
        if not scroller then
            warn("[ZIGZAG DR-FIX] Dr title found, no matching ScrollingFrame; original Chilli UI controls the rows")
            return
        end
        WatchDrScroll(scroller)
        FixOverscroll(scroller)
        -- A stale scroll offset can leave the expanded DR section visually empty.
        -- On tap, start at the top of the existing content; never create fake rows.
        if scroller.CanvasPosition.Y>0 then
            scroller.CanvasPosition=Vector2.new(scroller.CanvasPosition.X,0)
        end
    end)
end

local function WatchDrHeader(object)
    if not IsDrTitle(object) then return end
    DR_TITLES[object]=true
    if DR_CLICK_GUARD_BOUND then return end
    DR_CLICK_GUARD_BOUND=true
    Bind(UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType~=Enum.UserInputType.Touch
            and input.UserInputType~=Enum.UserInputType.MouseButton1 then return end
        local pos=input.Position
        for title in pairs(DR_TITLES) do
            if title.Parent and MainChilliGui and title:IsDescendantOf(MainChilliGui)
                and IsGuiVisible(title) then
                local at,size=title.AbsolutePosition,title.AbsoluteSize
                if size.X>20 and size.Y>8 and pos.X>=at.X-48 and pos.X<=at.X+size.X+14
                    and pos.Y>=at.Y-6 and pos.Y<=at.Y+size.Y+6 then
                    local now=os.clock()
                    if now-DR_LAST_TAP>0.15 then
                        DR_LAST_TAP=now
                        HandleDrHeaderTap(title)
                    end
                    break
                end
            end
        end
    end))
end

local function TrackChilli(gui)
    if not gui or not gui.Parent then return end
    if MainChilliGui == gui and gui.Parent then return end
    DisconnectChilli()
    MainChilliGui = gui
    for _,object in ipairs(gui:GetDescendants()) do
        ApplyTranslation(object,true)
        ThemeObject(object)
        WatchDrHeader(object)
        if IsChilliTitle(object) then PlaceZigzagLogo(object) end
    end
    BindChilli(gui.DescendantAdded:Connect(function(object)
        if IsTextObject(object) then
            ApplyTranslation(object,true)
            WatchDrHeader(object)
            if IsChilliTitle(object) then PlaceZigzagLogo(object) end
        end
        ThemeObject(object)
        -- Chilli sometimes parents a border before assigning its size/color.
        -- Recheck this ONE new object, never rescan every descendant.
        if object:IsA("UIStroke") or object:IsA("UIGradient")
            or object:IsA("Frame") or object:IsA("TextButton")
            or object:IsA("ImageButton") or object:IsA("ImageLabel") then
            task.delay(0.18,function()
                if MainChilliGui==gui and object.Parent then ThemeObject(object) end
            end)
        end
        if IsTextObject(object) then
            task.defer(function()
                if MainChilliGui==gui and object.Parent then WatchDrHeader(object) end
            end)
        end
    end))
    -- Old watermark calls are harmless no-ops until a safe UI host is verified.
    task.delay(0.85,function()
        if MainChilliGui == gui and gui.Parent then PlaceZigzagWatermark(gui) end
    end)
    -- Two lightweight one-time passes to catch UI gradients initialized late.
    -- No RenderStepped, Heartbeat, or permanent scanning.
    task.delay(0.7,function()
        if MainChilliGui ~= gui or not gui.Parent then return end
        for _,object in ipairs(gui:GetDescendants()) do
            ThemeObject(object)
            if IsChilliTitle(object) then PlaceZigzagLogo(object) end
        end
        PlaceZigzagWatermark(gui)
    end)
    task.delay(2.0,function()
        if MainChilliGui ~= gui or not gui.Parent then return end
        for _,object in ipairs(gui:GetDescendants()) do
            ThemeObject(object)
        end
        PlaceZigzagWatermark(gui)
    end)
    BindChilli(gui.AncestryChanged:Connect(function()
        if not gui.Parent then DisconnectChilli() end
    end))
    print("✅ ZIGZAG attached to Chilli")
end

--========================================================
-- V1.7.9: SIDEBARS FORCE-PURPLE FIX (LABEL-ANCHORED)
-- V1.7.8 only looked for a TextButton ANCESTOR, but Chilli often
-- builds sidebars as a Frame + TextLabel. It also only recolored
-- red at discovery, so subsequent gradients could remain red.
-- This patch locates the actual sidebar rectangular surfaces and
-- gives THEM an event-driven purple theme even if the source
-- changes its accent after Halloween / color transitions.
-- It does NOT touch Chilli text, layout, panels, character, or
-- gameplay functions. No RenderStepped, while loop, or polling.
--========================================================
local SIDEBAR_NAMES = {
    ["ฟาร์ม"]=true,["Farm"]=true,
    ["ตัวละคร"]=true,["Character"]=true,["Player"]=true,
    ["คาดการณ์"]=true,["Predictor"]=true,
    ["ความคืบหน้า"]=true,["Progress"]=true,
    ["เซิร์ฟเวอร์"]=true,["Server"]=true,
    ["อื่นๆ"]=true,["Misc"]=true,
    ["ออโต้ย้ายเซิร์ฟเวอร์"]=true,["Auto Server Hop"]=true,
    ["กิจกรรมแอดมิน"]=true,["Admin Abuse"]=true,
    ["ดิสคอร์ด"]=true,["Discord"]=true,
    ["คีย์ลัด"]=true,["Quick & Keys"]=true,
    ["การตั้งค่า"]=true,["Settings"]=true,
    ["คอนฟิก"]=true,["Config"]=true,
    -- Special 'Venyx' tab deliberately stays red, as in the
    -- original ZIGZAG purple layout, not in this whitelist.
}
local SIDEBAR_TOP = Color3.fromRGB(206,117,255)
local SIDEBAR_BOTTOM = Color3.fromRGB(144,46,218)
local SIDEBAR_FILL = Color3.fromRGB(168,68,233)
local SIDEBAR_TINT = Color3.fromRGB(184,89,246)
local SIDEBAR_GRADIENT = ColorSequence.new({
    ColorSequenceKeypoint.new(0,SIDEBAR_TOP),
    ColorSequenceKeypoint.new(1,SIDEBAR_BOTTOM),
})
local SIDEBAR_TRACKED = setmetatable({}, {__mode="k"})
local SIDEBAR_BUSY = setmetatable({}, {__mode="k"})
local SIDEBAR_LABEL_WATCHED = setmetatable({}, {__mode="k"})
local SIDEBAR_CHILD_WATCHED = setmetatable({}, {__mode="k"})
local SIDEBAR_GRADIENT_WATCHED = setmetatable({}, {__mode="k"})

local function SidebarShape(obj)
    if not obj or not obj:IsA("GuiObject") then return false end
    if obj:IsA("ScrollingFrame") then return false end
    local ok,w,h=pcall(function()
        return obj.AbsoluteSize.X,obj.AbsoluteSize.Y
    end)
    if not ok then return false end
    return w>=75 and w<=530 and h>=26 and h<=145 and w>=h*1.45
end

local function StyleSidebarGradient(gradient)
    if not gradient or not gradient.Parent or SIDEBAR_BUSY[gradient] then return end
    local ok,value=pcall(function() return gradient.Color end)
    if not ok or value==SIDEBAR_GRADIENT then return end
    SIDEBAR_BUSY[gradient]=true
    SaveStyle(gradient,"Color",SIDEBAR_GRADIENT)
    SIDEBAR_BUSY[gradient]=nil
end

local function WatchSidebarGradient(gradient)
    if not gradient or not gradient:IsA("UIGradient") then return end
    StyleSidebarGradient(gradient)
    if SIDEBAR_GRADIENT_WATCHED[gradient] then return end
    SIDEBAR_GRADIENT_WATCHED[gradient]=true
    Bind(gradient:GetPropertyChangedSignal("Color"):Connect(function()
        -- Synchronous correction, rather than one-frame task.defer flicker.
        if gradient.Parent and not SIDEBAR_BUSY[gradient] then
            StyleSidebarGradient(gradient)
        end
    end))
end

local function ForceSidebarPurple(surface)
    if not surface or not surface.Parent or SIDEBAR_BUSY[surface] then return end
    if not SidebarShape(surface) then return end
    SIDEBAR_BUSY[surface]=true
    pcall(function()
        -- Text labels are usually transparent; never paint their text boxes.
        if not surface:IsA("TextLabel") and not surface:IsA("TextBox") then
            if surface.BackgroundTransparency < 0.96
                and surface.BackgroundColor3 ~= SIDEBAR_FILL then
                SaveStyle(surface,"BackgroundColor3",SIDEBAR_FILL)
            end
            -- A full-sized image-button / image fill can also be the backdrop.
            if (surface:IsA("ImageLabel") or surface:IsA("ImageButton"))
                and surface.ImageTransparency < 0.95
                and surface.ImageColor3 ~= SIDEBAR_TINT then
                SaveStyle(surface,"ImageColor3",SIDEBAR_TINT)
            end
        end
        -- Keep existing black outlines; recolor only red ones.
        for _,child in ipairs(surface:GetChildren()) do
            if child:IsA("UIGradient") then
                WatchSidebarGradient(child)
            elseif child:IsA("UIStroke") then
                RepaintRedProperty(child,"Color")
            end
        end
    end)
    SIDEBAR_BUSY[surface]=nil
end

local function TrackSidebarSurface(surface)
    if not SidebarShape(surface) then return end
    ForceSidebarPurple(surface)
    if SIDEBAR_TRACKED[surface] then return end
    SIDEBAR_TRACKED[surface]=true
    -- Chilli recolors UI when switching tabs or when the map changes.
    -- These signals restore purple immediately without full-UI rescans.
    Bind(surface:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
        if surface.Parent then ForceSidebarPurple(surface) end
    end))
    if surface:IsA("ImageLabel") or surface:IsA("ImageButton") then
        Bind(surface:GetPropertyChangedSignal("ImageColor3"):Connect(function()
            if surface.Parent then ForceSidebarPurple(surface) end
        end))
    end
    if not SIDEBAR_CHILD_WATCHED[surface] then
        SIDEBAR_CHILD_WATCHED[surface]=true
        Bind(surface.ChildAdded:Connect(function(child)
            if child:IsA("UIGradient") then
                WatchSidebarGradient(child)
            elseif child:IsA("UIStroke") then
                RepaintRedProperty(child,"Color")
            elseif child:IsA("Frame") or child:IsA("ImageLabel")
                or child:IsA("ImageButton") or child:IsA("TextButton") then
                -- A new full-size colored backdrop underneath the label.
                task.defer(function()
                    if child.Parent and SidebarShape(child) then
                        TrackSidebarSurface(child)
                    end
                end)
            end
        end))
    end
end

local function StyleSidebarForText(object)
    if not IsTextObject(object) or not object.Parent then return end
    local ok,label=pcall(function() return CleanText(object.Text) end)
    if not ok or not SIDEBAR_NAMES[label] then return end
    local okPos,centerX,screenW=pcall(function()
        local camera=workspace.CurrentCamera
        local width=camera and camera.ViewportSize.X or 0
        return object.AbsolutePosition.X+object.AbsoluteSize.X*0.5,width
    end)
    -- Whitelist only edge-mounted sidebar menus; never color central
    -- settings, egg/pet dropdowns, or full-width UI overlays.
    if okPos and screenW>0 and centerX>screenW*0.36
        and centerX<screenW*0.64 then return end
    local current=object
    for depth=1,6 do
        if not current or current:IsA("ScreenGui") then break end
        if SidebarShape(current) and
            (current:IsA("Frame") or current:IsA("CanvasGroup")
             or current:IsA("TextButton") or current:IsA("ImageButton")
             or current:IsA("ImageLabel")) then
            TrackSidebarSurface(current)
            -- Chilli may use a Frame under a transparent clickable parent.
            -- Detect only siblings with the same size, not the whole menu.
            for _,child in ipairs(current:GetChildren()) do
                if child:IsA("Frame") or child:IsA("ImageLabel")
                    or child:IsA("ImageButton") or child:IsA("TextButton") then
                    if SidebarShape(child) then TrackSidebarSurface(child) end
                end
            end
        end
        current=current.Parent
    end
end

local function WatchSidebarLabel(object)
    if not IsTextObject(object) or SIDEBAR_LABEL_WATCHED[object] then return end
    -- Watch only rectangular edge text widgets. Source often sets .Text
    -- *after* parenting, making a one-time label match unreliable.
    local ok,centerX,w=pcall(function()
        return object.AbsolutePosition.X+object.AbsoluteSize.X*0.5,
            object.AbsoluteSize.X
    end)
    if not ok or w<55 then return end
    local camera=workspace.CurrentCamera
    local viewport=camera and camera.ViewportSize.X or 0
    if viewport>0 and centerX>viewport*0.36
        and centerX<viewport*0.64 then return end
    SIDEBAR_LABEL_WATCHED[object]=true
    Bind(object:GetPropertyChangedSignal("Text"):Connect(function()
        if object.Parent then StyleSidebarForText(object) end
    end))
    StyleSidebarForText(object)
end

local FLOATING_PANEL_ROOTS=setmetatable({},{__mode="k"})
local FLOATING_PANEL_TEXTS=setmetatable({},{__mode="k"})
local function WatchFloatingPanelText(object)
    if not IsTextObject(object) or FLOATING_PANEL_TEXTS[object] then return end
    FLOATING_PANEL_TEXTS[object]=true
    ApplyTranslation(object,true)
    Bind(object:GetPropertyChangedSignal("Text"):Connect(function()
        if object.Parent then ApplyTranslation(object,false) end
    end))
end
local function TrackFloatingPanel(container)
    if not container or FLOATING_PANEL_ROOTS[container] then return end
    FLOATING_PANEL_ROOTS[container]=true
    for _,o in ipairs(container:GetDescendants()) do
        WatchFloatingPanelText(o)
    end
    Bind(container.DescendantAdded:Connect(function(o)
        if o.Parent then WatchFloatingPanelText(o) end
    end))
end
local function IsStealPanelHeading(object)
    if not IsTextObject(object) then return false end
    local ok,t=pcall(function() return string.lower(CleanText(object.Text)) end)
    return ok and (t=="steal panel" or t=="แผงขโมย")
end
local function DetectFloatingPanel(object)
    if not IsStealPanelHeading(object) then return end
    local candidate=object
    for _=1,5 do
        if not candidate or candidate:IsA("ScreenGui") then break end
        if candidate:IsA("Frame") or candidate:IsA("CanvasGroup") then
            local size=candidate.AbsoluteSize
            if size.X>=180 and size.Y>=130 then
                TrackFloatingPanel(candidate)
                return
            end
        end
        candidate=candidate.Parent
    end
end

--========================================================
-- 15. LOOSE TARGET (expanded only for floating steal UI)
--========================================================

local function IsLooseTarget(object)
    if not IsTextObject(object) then return false end
    local ok,text = pcall(function() return object.Text end)
    if not ok or type(text) ~= "string" then return false end
    local lower = string.lower(CleanText(text))
    return lower == "anti guard"
        or lower == "anti guard panel"
        or lower == "steal panel"
        or lower == "auto steal: off"
        or lower == "auto steal: on"
        or lower == "instant steal: off"
        or lower == "instant steal: on"
end

--========================================================
-- 16-17. DISCOVERY / ROOT EVENT WATCHER (NO SCAN LOOP)
--========================================================

local function FindExistingChilli()
    if MainChilliGui and MainChilliGui.Parent then return true end
    for _,root in ipairs(UI_ROOTS) do
        local found = false
        pcall(function()
            for _,object in ipairs(root:GetDescendants()) do
                if IsChilliTitle(object) then
                    local gui = FindChilliContainer(object)
                    if gui then
                        TrackChilli(gui)
                        found = true
                        break
                    end
                end
            end
        end)
        if found then return true end
    end
    return false
end
local WatchedRoots = setmetatable({}, {__mode="k"})
local function WatchRoot(root)
    if not root or WatchedRoots[root] then return end
    WatchedRoots[root] = true
    Bind(root.DescendantAdded:Connect(function(object)
        if not IsTextObject(object) then return end
        task.defer(function()
            if object.Parent then
                WatchSidebarLabel(object)
                DetectFloatingPanel(object)
            end
        end)
        -- Three short initializations only for newly created candidate text.
        -- No endless retries and no recurring scan.
        task.delay(0.35,function()
            if object.Parent then WatchSidebarLabel(object) end
        end)
        if IsChilliTitle(object) then
            local gui = FindChilliContainer(object)
            if gui then TrackChilli(gui) end
            return
        end
        if IsLooseTarget(object) then
            ApplyTranslation(object,true)
            return
        end
        if MainChilliGui and MainChilliGui.Parent then
            local ok,text = pcall(function() return object.Text end)
            if ok and type(text) == "string" and text ~= "" then
                local translated = TranslateText(text)
                if translated ~= text then ApplyTranslation(object,true) end
            end
        end
    end))
end
for _,root in ipairs(UI_ROOTS) do
    WatchRoot(root)
    for _,object in ipairs(root:GetDescendants()) do
        if IsTextObject(object) then
            WatchSidebarLabel(object)
            DetectFloatingPanel(object)
        end
    end
end

-- V1.7.9: limited startup discovery in case Chilli paints text/gradients
-- after parenting. This runs at fixed times; there is no permanent loop.
local function CheckExistingSidebarButtons()
    for _,root in ipairs(UI_ROOTS) do
        if root and root.Parent then
            for _,object in ipairs(root:GetDescendants()) do
                if IsTextObject(object) then WatchSidebarLabel(object) end
            end
        end
    end
end
for _,delaySeconds in ipairs({0.65,1.6,3.8}) do
    task.delay(delaySeconds,CheckExistingSidebarButtons)
end


--========================================================
-- CHILLI MAIN + VENYX THAI / ZIGZAG V1.8.3 POPUP FIX
-- CHILLI remains the ONLY startup game loader.
-- VENYX UI translator is armed without loading its gameplay at startup.
-- Tapping the Chilli-side "Venyx" tab explicitly launches original Venyx
-- once per destination-server session; no automatic/gameplay hop reload.
--========================================================
local ZIGZAG_HYBRID_VENYX_SOURCE=
    "https://raw.githubusercontent.com/tienkhanh1/Venyx/main/VenyxHub"
local ZIGZAG_HYBRID_ENV=(type(getgenv)=="function" and getgenv()) or _G
local ZIGZAG_HYBRID_SESSION=tostring(game.PlaceId)..":"..tostring(game.JobId or "")
local ZIGZAG_HYBRID_VENYX_CORE=[===[
--==============================================================
-- VENYX STEAL AN EGG • THAI UI BY ZIGZAG • V1.9 (V1.8 TELEPORT SAFE + HALLOWEEN UI TRANSLATIONS)
-- Translation overlay only; external Venyx loader kept unchanged.
-- Only updates UI Text/PlaceholderText in detected Venyx/Steal Panel GUI.
-- Does not change steal/farm logic, character movement, or settings.
-- This file DOES NOT contain decrypted/protected Venyx source.
--==============================================================
local ENV = (type(getgenv) == "function" and getgenv()) or _G
local OLD = ENV.__ZIGZAG_VENYX_THAI_STATE
local HAD_LOADER = OLD and OLD.LoaderStarted
if OLD and type(OLD.Stop) == "function" then
    pcall(OLD.Stop)
end

local STATE = {
    Running = true,
    Connections = {},
    Observed = setmetatable({}, {__mode = "k"}),
    Roots = setmetatable({}, {__mode = "k"}),
    Busy = setmetatable({}, {__mode = "k"}),
    LoaderStarted = HAD_LOADER or false,
    Count = 0,
}
ENV.__ZIGZAG_VENYX_THAI_STATE = STATE
local function bind(conn)
    if conn then table.insert(STATE.Connections, conn) end
    return conn
end
function STATE.Stop()
    STATE.Running = false
    for _,conn in ipairs(STATE.Connections) do
        pcall(function() conn:Disconnect() end)
    end
    table.clear(STATE.Connections)
end

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local SOURCE_URL = "https://raw.githubusercontent.com/tienkhanh1/Venyx/main/VenyxHub"

-- Translations below come from all supplied Venyx v1.0.2 screenshots.
-- V1.3 translates visible option names (rarities, zones, racers, shop items)
-- only as GUI text; the game's actual option handlers/data are untouched.
local TH = {
    ["aa"] = "กิจกรรมแอดมิน",
    ["active"] = "กำลังใช้งาน",
    ["admin abuse"] = "กิจกรรมแอดมิน",
    ["after stealing a match"] = "หลังขโมยไข่ที่ตรงเงื่อนไข",
    ["all"] = "ทั้งหมด",
    ["all picked rules"] = "ตรงทุกเงื่อนไขที่เลือก",
    ["always"] = "ตลอดเวลา",
    ["anti guard"] = "หลบหลีกยาม",
    ["any picked rule"] = "ตรงอย่างน้อยหนึ่งเงื่อนไข",
    ["apply"] = "นำไปใช้",
    ["auto"] = "อัตโนมัติ",
    ["auto butterfly"] = "ทำผีเสื้ออัตโนมัติ",
    ["auto buy nitro"] = "ซื้อ Nitro อัตโนมัติ",
    ["auto buy shop"] = "ซื้อของในร้านอัตโนมัติ",
    ["auto buy trails"] = "ซื้อรอยเท้าอัตโนมัติ",
    ["auto catch shooting star"] = "จับดาวตกอัตโนมัติ",
    ["auto claim index rewards"] = "รับรางวัลสมุดอัตโนมัติ",
    ["auto claim offline cash"] = "รับเงินออฟไลน์อัตโนมัติ",
    ["auto claim rewards"] = "รับรางวัลอัตโนมัติ",
    ["auto equip"] = "สวมใส่อัตโนมัติ",
    ["auto equip racer"] = "เลือกตัวแข่งให้อัตโนมัติ",
    ["auto favorite"] = "เพิ่มรายการโปรดอัตโนมัติ",
    ["auto fuse"] = "ผสมอัตโนมัติ",
    ["auto hatch"] = "ฟักไข่อัตโนมัติ",
    ["auto hop"] = "ย้ายเซิร์ฟเวอร์อัตโนมัติ",
    ["auto hop server"] = "ย้ายเซิร์ฟเวอร์อัตโนมัติ",
    ["auto if empty"] = "สร้างชื่ออัตโนมัติหากเว้นว่าง",
    ["auto load"] = "โหลดอัตโนมัติ",
    ["auto load script"] = "โหลดสคริปต์อัตโนมัติ",
    ["auto mutate"] = "กลายพันธุ์อัตโนมัติ",
    ["auto place"] = "วางไข่อัตโนมัติ",
    ["auto race"] = "แข่งวิ่งอัตโนมัติ",
    ["auto save"] = "บันทึกอัตโนมัติ",
    ["auto sell eggs"] = "ขายไข่อัตโนมัติ",
    ["auto sell lab eggs"] = "ขายไข่แล็บอัตโนมัติ",
    ["auto sell pets"] = "ขายสัตว์เลี้ยงอัตโนมัติ",
    ["auto steal"] = "ขโมยไข่อัตโนมัติ",
    ["auto treadmill"] = "วิ่งลู่อัตโนมัติ",
    ["auto upgrade base"] = "อัปเกรดฐานอัตโนมัติ",
    ["auto upgrade treadmill"] = "เพิ่มระดับลู่อัตโนมัติ",
    ["background color"] = "สีพื้นหลัง",
    ["bar size"] = "ขนาดแถบปุ่มลัด",
    ["bases"] = "ฐานผู้เล่น",
    ["best"] = "ดีที่สุด",
    ["best mutation"] = "การกลายพันธุ์ดีที่สุด",
    ["best owned"] = "ตัวที่มีดีที่สุด",
    ["best rarity"] = "หายากที่สุด",
    ["best steal"] = "ไข่ที่ดีที่สุด",
    ["best value"] = "มูลค่าสูงสุด",
    ["biggest"] = "ตัวใหญ่ที่สุด",
    ["butterfly"] = "ผีเสื้อ",
    ["butterfly bloom"] = "ผีเสื้อผลิบาน",
    ["butterfly event"] = "กิจกรรมผีเสื้อ",
    ["butterfly machine"] = "เครื่องผีเสื้อ",
    ["buy"] = "ซื้อ",
    ["calculate mutations"] = "คำนวณผลจากการกลายพันธุ์",
    ["cancel"] = "ยกเลิก",
    ["cancel selection"] = "ยกเลิกการเลือก",
    ["cards show the value with these mutations added"] = "การ์ดแสดงมูลค่าหลังรวมการกลายพันธุ์ที่เลือก",
    ["cash"] = "เงินสด",
    ["catch"] = "จับดาว",
    ["caught"] = "จับได้แล้ว",
    ["change if steal fails"] = "ปรับเมื่อขโมยไม่สำเร็จ",
    ["chilli hub"] = "Chilli Hub",
    ["claim"] = "รับ",
    ["clear"] = "ล้าง",
    ["clear all keybinds"] = "ล้างปุ่มลัดคีย์บอร์ดทั้งหมด",
    ["clear all quick bars"] = "ล้างแถบปุ่มลัดทั้งหมด",
    ["close"] = "ปิด",
    ["closest"] = "ใกล้ที่สุด",
    ["common"] = "ทั่วไป",
    ["config"] = "ตั้งค่าโปรไฟล์",
    ["configuration"] = "การตั้งค่า",
    ["confirm"] = "ยืนยัน",
    ["copy"] = "คัดลอก",
    ["copy invite"] = "คัดลอกลิงก์เชิญ",
    ["copy job id"] = "คัดลอก Job ID",
    ["create"] = "สร้าง",
    ["create config"] = "สร้างโปรไฟล์",
    ["credits"] = "เครดิต",
    ["default"] = "ค่าเริ่มต้น",
    ["default config"] = "โปรไฟล์เริ่มต้น",
    ["delete"] = "ลบ",
    ["delete picked"] = "ลบโปรไฟล์ที่เลือก",
    ["delivering"] = "กำลังนำไข่กลับ",
    ["delivery speed"] = "ความเร็วในการนำไข่กลับ",
    ["delivery speed slider"] = "แถบปรับความเร็วส่งไข่",
    ["deselect all"] = "ยกเลิกทั้งหมด",
    ["dim the game"] = "ลดความสว่างเกม",
    ["disable 3d render"] = "ปิดการแสดงผลภาพ 3 มิติ",
    ["disabled"] = "ปิดการใช้งาน",
    ["discord"] = "ดิสคอร์ด",
    ["discord role id"] = "ID ยศ Discord",
    ["discord user id"] = "ID ผู้ใช้ Discord",
    ["discord webhook"] = "เว็บฮุก Discord",
    ["distance"] = "ระยะทาง",
    ["divine"] = "เทพเจ้า",
    ["doing"] = "กำลังทำ",
    ["done"] = "เสร็จแล้ว",
    ["dr. scramble"] = "Dr. Scramble",
    ["dr. scramble lab"] = "แล็บ Dr. Scramble",
    ["drop eggs at safe zone"] = "วางไข่ในเขตปลอดภัย",
    ["duration"] = "ระยะเวลา",
    ["egg"] = "ไข่",
    ["egg bag"] = "กระเป๋าไข่",
    ["egg predictor"] = "คาดการณ์ไข่",
    ["egg showcase"] = "แสดงรายการไข่",
    ["eggs"] = "ไข่",
    ["eject odd pets"] = "นำสัตว์เลี้ยงที่เกินออก",
    ["enabled"] = "เปิดการใช้งาน",
    ["enchanted"] = "ต้องมนตร์",
    ["enchanted forest"] = "ป่ามนตร์",
    ["epic"] = "มหากาพย์",
    ["equip best pets"] = "ใส่สัตว์เลี้ยงที่ดีที่สุด",
    ["error"] = "ข้อผิดพลาด",
    ["eternal"] = "นิรันดร์",
    ["event"] = "กิจกรรม",
    ["expires in"] = "หมดเวลาในอีก",
    ["export config"] = "ส่งออกโปรไฟล์",
    ["failed"] = "ไม่สำเร็จ",
    ["farm"] = "ฟาร์ม",
    ["fast tween to egg"] = "เคลื่อนที่แบบ Tween ไปหาไข่อย่างรวดเร็ว",
    ["favorite"] = "รายการโปรด",
    ["filter"] = "ตัวกรอง",
    ["find an option"] = "ค้นหาตัวเลือก",
    ["first"] = "อันดับแรก",
    ["first hop after"] = "เริ่มย้ายครั้งแรกหลัง",
    ["fix"] = "แก้ไข",
    ["fixed lag back with the tween delivery method"] = "แก้อาการแลคตอนกลับด้วยวิธีส่งแบบ Tween",
    ["fps cap"] = "จำกัด FPS",
    ["fractured"] = "แตกร้าว",
    ["frame rate"] = "อัตราเฟรม",
    ["fuse"] = "ผสม",
    ["fuse filter"] = "ตัวกรองการผสม",
    ["fuse first"] = "เลือกผสมก่อน",
    ["fuse machine"] = "เครื่องผสม",
    ["fuse predictor"] = "คาดการณ์การผสม",
    ["go to egg"] = "วิธีไปหาไข่",
    ["graphics"] = "กราฟิก",
    ["growing"] = "กำลังเติบโต",
    ["hatched"] = "ฟักแล้ว",
    ["hatching"] = "กำลังฟักไข่",
    ["hide game ui"] = "ซ่อนหน้าต่างของเกม",
    ["hide my pets and eggs"] = "ซ่อนสัตว์เลี้ยงและไข่ของฉัน",
    ["hide other players' pets and eggs"] = "ซ่อนสัตว์เลี้ยงและไข่ของผู้เล่นอื่น",
    ["high"] = "สูง",
    ["highest rarity"] = "หายากที่สุด",
    ["highest value first"] = "มูลค่าสูงสุดก่อน",
    ["home"] = "หน้าแรก",
    ["hop server"] = "ย้ายเซิร์ฟเวอร์",
    ["hop to"] = "ย้ายไปเซิร์ฟเวอร์แบบ",
    ["hop when"] = "เงื่อนไขการย้ายเซิร์ฟเวอร์",
    ["idle"] = "ว่าง",
    ["import"] = "นำเข้า",
    ["import config"] = "นำเข้าโปรไฟล์",
    ["import text"] = "ข้อความสำหรับนำเข้า",
    ["in bag"] = "อยู่ในกระเป๋า",
    ["info"] = "ข้อมูล",
    ["information"] = "ข้อมูล",
    ["interface"] = "หน้าต่างควบคุม",
    ["job id"] = "Job ID",
    ["join"] = "เข้าร่วม",
    ["join and stay"] = "เข้าเซิร์ฟเวอร์ที่กำหนด",
    ["join that server"] = "เข้าร่วมเซิร์ฟเวอร์นี้",
    ["keep eggs"] = "เก็บไข่ไว้",
    ["keep lab eggs"] = "เก็บไข่จากแล็บไว้",
    ["keep mutated"] = "เก็บตัวที่กลายพันธุ์ไว้",
    ["key"] = "คีย์",
    ["keybinds"] = "ปุ่มลัด",
    ["lab"] = "แล็บ",
    ["lab eggs"] = "ไข่แล็บ",
    ["lands in"] = "ตกในอีก",
    ["language"] = "ภาษา",
    ["last egg"] = "ไข่ล่าสุด",
    ["least players"] = "ผู้เล่นน้อยที่สุด",
    ["legendary"] = "ตำนาน",
    ["light dark zone"] = "โซนสว่างและมืด",
    ["load"] = "โหลด",
    ["loading"] = "กำลังโหลด",
    ["low"] = "ต่ำ",
    ["low graphics"] = "ลดคุณภาพกราฟิก",
    ["lower it if wins do not count"] = "ลดค่านี้หากชัยชนะไม่ถูกนับ",
    ["lowest rarity"] = "หายากน้อยที่สุด",
    ["lowest value"] = "มูลค่าต่ำสุด",
    ["lowest value first"] = "มูลค่าต่ำสุดก่อน",
    ["match"] = "เงื่อนไขตรงกัน",
    ["max"] = "สูงสุด",
    ["min"] = "ต่ำสุด",
    ["min value /s"] = "มูลค่าขั้นต่ำ/วินาที",
    ["minimum value/s"] = "มูลค่าขั้นต่ำ/วินาที",
    ["misc"] = "อื่น ๆ",
    ["money/s"] = "เงินต่อวินาที",
    ["mutate"] = "กลายพันธุ์",
    ["mutate filter"] = "ตัวกรองการกลายพันธุ์",
    ["mutate first"] = "เลือกกลายพันธุ์ก่อน",
    ["mutation"] = "การกลายพันธุ์",
    ["mutations"] = "การกลายพันธุ์",
    ["mythic"] = "มายาคติ",
    ["name"] = "ชื่อ",
    ["never"] = "ไม่เลย",
    ["never fuse"] = "ห้ามผสม",
    ["never sell"] = "ห้ามขาย",
    ["new"] = "ใหม่",
    ["new config name"] = "ชื่อโปรไฟล์ใหม่",
    ["next race"] = "แข่งครั้งถัดไป",
    ["night"] = "กลางคืน",
    ["night in"] = "กลางคืนในอีก",
    ["nitro"] = "ไนโตร",
    ["no egg matches your targets"] = "ไม่มีไข่ที่ตรงตามเงื่อนไข",
    ["no eggs found"] = "ไม่พบไข่",
    ["no matching eggs"] = "ไม่มีไข่ที่ตรงเงื่อนไข",
    ["no matching pets"] = "ไม่มีสัตว์เลี้ยงที่ตรงเงื่อนไข",
    ["no pets found"] = "ไม่พบสัตว์เลี้ยง",
    ["no targets"] = "ไม่มีเป้าหมาย",
    ["none"] = "ไม่มี",
    ["notification"] = "การแจ้งเตือน",
    ["notifications"] = "การแจ้งเตือน",
    ["off"] = "ปิด",
    ["on"] = "เปิด",
    ["only below /s"] = "เฉพาะที่มีมูลค่าต่ำกว่า/วินาที",
    ["only mutations"] = "เฉพาะแบบกลายพันธุ์ที่เลือก",
    ["only these eggs"] = "เลือกขโมยเฉพาะไข่เหล่านี้",
    ["only these pets"] = "เฉพาะสัตว์เลี้ยงที่เลือก",
    ["opacity"] = "ความทึบของหน้าต่าง",
    ["open"] = "เปิด",
    ["optimizer"] = "ปรับประสิทธิภาพ",
    ["other"] = "อื่น ๆ",
    ["paste a job id"] = "วาง Job ID",
    ["paste config text"] = "วางข้อความโปรไฟล์",
    ["pause"] = "พัก",
    ["pen"] = "คอกไข่",
    ["pet"] = "สัตว์เลี้ยง",
    ["pet bag"] = "กระเป๋าสัตว์เลี้ยง",
    ["pets"] = "สัตว์เลี้ยง",
    ["pick any"] = "เลือกได้หลายตัวเลือก",
    ["pick one"] = "เลือกหนึ่งตัวเลือก",
    ["pick to delete"] = "เลือกโปรไฟล์ที่จะลบ",
    ["pin"] = "ปักหมุด",
    ["ping everyone"] = "แท็กทุกคน",
    ["ping role id"] = "แท็กยศด้วย ID",
    ["ping user id"] = "แท็กผู้ใช้ด้วย ID",
    ["pinned"] = "ปักหมุดแล้ว",
    ["pins and keybinds"] = "ปักหมุดและปุ่มลัด",
    ["place"] = "วางไข่",
    ["place first"] = "เลือกวางก่อน",
    ["place id"] = "Place ID",
    ["place when"] = "เงื่อนไขการวาง",
    ["placed"] = "วางแล้ว",
    ["placing"] = "กำลังวางไข่",
    ["player"] = "ตัวละคร",
    ["player count"] = "จำนวนผู้เล่น",
    ["post fused eggs"] = "แจ้งไข่ที่ผสมแล้ว",
    ["post stolen eggs"] = "แจ้งไข่ที่ขโมยได้",
    ["post when bag is full"] = "แจ้งเมื่อกระเป๋าเต็ม",
    ["posted"] = "ส่งแล้ว",
    ["preview card"] = "แสดงตัวอย่างการ์ด",
    ["price"] = "ราคา",
    ["priority"] = "ลำดับความสำคัญ",
    ["profiles"] = "โปรไฟล์",
    ["progress"] = "ความคืบหน้า",
    ["quick bar 1"] = "แถบด่วน 1",
    ["quick bar 2"] = "แถบด่วน 2",
    ["quick bars"] = "แถบคำสั่งด่วน",
    ["race"] = "แข่งวิ่ง",
    ["race speed"] = "ความเร็วในการแข่ง",
    ["racer"] = "ตัวแข่ง",
    ["racing event"] = "กิจกรรมแข่งวิ่ง",
    ["rare"] = "หายาก",
    ["rare from"] = "ระดับความหายากตั้งแต่",
    ["rarities"] = "ระดับความหายาก",
    ["rarity"] = "ระดับความหายาก",
    ["ready"] = "พร้อม",
    ["ready now"] = "พร้อมตอนนี้",
    ["ready to place"] = "พร้อมวาง",
    ["refresh"] = "รีเฟรช",
    ["rejoin"] = "เข้าเซิร์ฟใหม่",
    ["rejoin on kick"] = "เข้าเกมใหม่เมื่อถูกเตะ",
    ["rejoin this server"] = "กลับเข้าเซิร์ฟเวอร์นี้",
    ["reset"] = "รีเซ็ต",
    ["reset all"] = "รีเซ็ตทั้งหมด",
    ["reset selection"] = "รีเซ็ตการเลือก",
    ["reset to defaults"] = "คืนค่าเริ่มต้นทั้งหมด",
    ["resetting carry"] = "กำลังรีเซ็ตการถือไข่",
    ["restore deleted"] = "กู้คืนโปรไฟล์ที่ลบ",
    ["resume"] = "ทำต่อ",
    ["rewards"] = "รางวัล",
    ["save"] = "บันทึก",
    ["save changes"] = "บันทึกการเปลี่ยนแปลง",
    ["saved configs"] = "โปรไฟล์ที่บันทึก",
    ["scrambled"] = "ปั่นเปลี่ยนสภาพ",
    ["search"] = "ค้นหา",
    ["search servers"] = "ค้นหาเซิร์ฟเวอร์",
    ["search..."] = "ค้นหา...",
    ["searching"] = "กำลังค้นหา",
    ["secret"] = "ลับ",
    ["select"] = "เลือก",
    ["select all"] = "เลือกทั้งหมด",
    ["sell"] = "ขาย",
    ["sell cheapest egg when bag is full"] = "ขายไข่ราคาต่ำสุดเมื่อกระเป๋าเต็ม",
    ["sell matching eggs now"] = "ขายไข่ที่ตรงเงื่อนไขทันที",
    ["sell matching lab eggs now"] = "ขายไข่แล็บที่ตรงเงื่อนไขทันที",
    ["sell matching pets now"] = "ขายสัตว์เลี้ยงที่ตรงเงื่อนไขทันที",
    ["sell rarities"] = "ระดับที่จะขาย",
    ["send a test post"] = "ส่งข้อความทดสอบ",
    ["server"] = "เซิร์ฟเวอร์",
    ["server hop"] = "ย้ายเซิร์ฟเวอร์",
    ["session"] = "ข้อมูลรอบนี้",
    ["session time"] = "เวลาในรอบนี้",
    ["set active"] = "ตั้งให้ใช้งาน",
    ["set as active config"] = "ตั้งเป็นโปรไฟล์ที่ใช้งาน",
    ["settings"] = "ตั้งค่า",
    ["shooting star"] = "ดาวตก",
    ["shop items"] = "สินค้าในร้าน",
    ["show / hide ui"] = "แสดง / ซ่อนหน้าต่าง",
    ["show fps and ping"] = "แสดง FPS และ Ping",
    ["show quick bars"] = "แสดงแถบปุ่มลัด",
    ["skip eggs with"] = "ข้ามไข่ที่มี",
    ["skip mutated"] = "ข้ามสัตว์เลี้ยงที่กลายพันธุ์แล้ว",
    ["slipped"] = "หลุดมือ",
    ["sort by"] = "เรียงตาม",
    ["sort eggs"] = "เรียงไข่ตาม",
    ["speed boost"] = "เพิ่มความเร็ว",
    ["speed power"] = "พลังความเร็ว",
    ["star"] = "ดาวตก",
    ["star catch"] = "จับดาวตก",
    ["star event"] = "กิจกรรมดาว",
    ["status"] = "สถานะ",
    ["steal"] = "ขโมยไข่",
    ["steal an egg"] = "เกมขโมยไข่",
    ["steal filter eggs"] = "ขโมยไข่ตามตัวกรอง",
    ["steal first"] = "เลือกไข่ที่จะขโมยก่อน",
    ["steal from other players"] = "ขโมยไข่จากผู้เล่นอื่น",
    ["steal lab eggs"] = "ขโมยไข่แล็บ",
    ["steal missing index"] = "ขโมยตัวที่ยังไม่ลงสมุด",
    ["steal missing index eggs"] = "ขโมยไข่ที่ยังไม่มีในสมุดสะสม",
    ["steal wisp eggs"] = "ขโมยไข่ Wisp",
    ["stealing"] = "กำลังขโมย",
    ["stolen"] = "ขโมยแล้ว",
    ["stop"] = "หยุด",
    ["success"] = "สำเร็จ",
    ["support"] = "ฝ่ายช่วยเหลือ",
    ["system"] = "ระบบ",
    ["task order"] = "ลำดับงาน",
    ["teleport"] = "วาร์ป",
    ["teleport to egg"] = "วาร์ปไปหาไข่",
    ["teleport zones"] = "โซนที่วาร์ปได้",
    ["teleporting"] = "กำลังย้ายตำแหน่ง",
    ["test"] = "ทดสอบ",
    ["theme"] = "ธีม",
    ["time"] = "เวลา",
    ["tip: you can also hold any option, or right-click it on pc, to pin it or set a key."] = "เคล็ดลับ: กดตัวเลือกค้างไว้ หรือคลิกขวาบน PC เพื่อปักหมุดหรือตั้งปุ่มลัด",
    ["tone"] = "โทนสี",
    ["top goes first. a carried egg is always delivered first, and before the field opens every task waits in the safe zone."] = "รายการบนสุดทำก่อน • ไข่ที่ถืออยู่จะถูกส่งก่อนเสมอ และจะรอที่เขตปลอดภัยก่อนสนามเปิด",
    ["treadmill"] = "ลู่วิ่ง",
    ["tries"] = "จำนวนครั้ง",
    ["trophies"] = "ถ้วยรางวัล",
    ["turn off"] = "ปิดทั้งหมด",
    ["turn off all toggles"] = "ปิดสวิตช์ทั้งหมด",
    ["tween"] = "เคลื่อนที่แบบ Tween",
    ["tween speed slider"] = "แถบปรับความเร็ว Tween",
    ["ui scale"] = "ขนาดหน้าต่าง",
    ["ui settings"] = "ตั้งค่าหน้าต่าง",
    ["uncommon"] = "ไม่ธรรมดา",
    ["unload hub"] = "ปิดฮับ",
    ["update"] = "อัปเดต",
    ["updates, keys, support"] = "อัปเดต • คีย์ • ช่วยเหลือ",
    ["upgrade"] = "อัปเกรด",
    ["use items"] = "ไอเทมที่ใช้",
    ["use pets"] = "ลำดับใช้สัตว์เลี้ยง",
    ["use power-ups"] = "ใช้ไอเทมเพิ่มพลัง",
    ["value"] = "มูลค่า",
    ["venyx"] = "VENYX",
    ["venyx / steal an egg"] = "Venyx / เกมขโมยไข่",
    ["venyx discord"] = "ดิสคอร์ด Venyx",
    ["version"] = "เวอร์ชัน",
    ["waiting"] = "กำลังรอ",
    ["waiting for server"] = "กำลังรอเซิร์ฟเวอร์",
    ["walk / sprint"] = "เดิน / วิ่งเร็ว",
    ["walk/sprint"] = "เดิน / วิ่งเร็ว",
    ["warning"] = "คำเตือน",
    ["webhook"] = "เว็บฮุก",
    ["webhook url"] = "ลิงก์ Webhook",
    ["welcome back"] = "ยินดีต้อนรับกลับ",
    ["welcome to venyx 1.0.2! join our discord for updates and support"] = "ยินดีต้อนรับสู่ Venyx 1.0.2! เข้าดิสคอร์ดเพื่อรับข่าวสารและความช่วยเหลือ",
    ["welcome to venyx 1.0.2! join our discord for updates and support."] = "ยินดีต้อนรับสู่ Venyx 1.0.2! เข้าดิสคอร์ดเพื่อรับข่าวสารและความช่วยเหลือ",
    ["what to post"] = "ข้อมูลที่จะส่ง",
    ["what's new"] = "มีอะไรใหม่",
    ["white"] = "ขาว",
    ["wins"] = "ชัยชนะ",
    ["wisp"] = "Wisp",
    ["wisp event"] = "กิจกรรม Wisp",
    ["worst"] = "ต่ำที่สุด",
    ["zones"] = "โซน",
    ["anti afk"] = "ป้องกันหลุดเมื่อไม่ขยับ",
    ["anti ragdoll"] = "ป้องกันตัวละครล้มกลิ้ง",
    ["auto banjo cricket"] = "ทำภารกิจจิ้งหรีดแบนโจอัตโนมัติ",
    ["auto butterfly bloom"] = "ทำกิจกรรมผีเสื้อผลิบานอัตโนมัติ",
    ["auto capture event egg"] = "ชิงไข่กิจกรรมอัตโนมัติ",
    ["auto craft essence"] = "สร้างแก่นพลังอัตโนมัติ",
    ["auto hit"] = "โจมตีอัตโนมัติ",
    ["auto reroll recipe"] = "สุ่มสูตรใหม่อัตโนมัติ",
    ["auto steal minigame egg"] = "ขโมยไข่จากมินิเกมอัตโนมัติ",
    ["auto trade in"] = "แลกไข่กับแล็บอัตโนมัติ",
    ["auto trade up"] = "แลกเปลี่ยนเป็นระดับสูงขึ้นอัตโนมัติ",
    ["auto wisp quest"] = "ทำภารกิจวิสป์อัตโนมัติ",
    ["banner"] = "ตู้สุ่ม",
    ["banner chance"] = "โอกาสได้รับจากตู้สุ่ม",
    ["boost speed"] = "เพิ่มความเร็ว",
    ["capture the egg"] = "ชิงไข่กิจกรรม",
    ["catch mode"] = "รูปแบบการจับ",
    ["catch priority"] = "ลำดับความสำคัญในการจับ",
    ["catch speed"] = "ความเร็วในการจับ",
    ["chase"] = "ไล่จับ",
    ["chase speed"] = "ความเร็วไล่ตาม",
    ["chasing butterflies"] = "กำลังไล่จับผีเสื้อ",
    ["chosen player"] = "ผู้เล่นที่เลือก",
    ["combat"] = "ต่อสู้",
    ["complete"] = "สำเร็จ",
    ["delivery method"] = "วิธีนำไข่กลับ",
    ["done, the enchanted tree is open"] = "เสร็จแล้ว ต้นไม้มนตร์เปิดใช้งานแล้ว",
    ["egg esp"] = "แสดงตำแหน่งไข่",
    ["ends in"] = "สิ้นสุดในอีก",
    ["esp size"] = "ขนาดการแสดงตำแหน่ง",
    ["experimental pets"] = "สัตว์เลี้ยงทดลอง",
    ["field eggs"] = "ไข่ในสนาม",
    ["fixed size"] = "ขนาดคงที่",
    ["god mode"] = "โหมดอมตะ",
    ["guard esp"] = "แสดงตำแหน่งยาม",
    ["hide sleeping guards"] = "ซ่อนยามที่กำลังหลับ",
    ["hit aura"] = "โจมตีรอบตัว",
    ["hit who"] = "เลือกผู้ที่จะโจมตี",
    ["hold each"] = "ถืออาวุธแต่ละชิ้นนาน",
    ["hold height"] = "ความสูงขณะถือ",
    ["icon"] = "ไอคอน",
    ["ignore traps"] = "ไม่ติดกับดัก",
    ["infinite jump"] = "กระโดดไม่จำกัด",
    ["instant prompts"] = "โต้ตอบได้ทันที",
    ["instant steal (admin treadmill)"] = "ขโมยทันที (ลู่วิ่งแอดมิน)",
    ["invisible"] = "ล่องหน",
    ["keep away"] = "รักษาระยะห่าง",
    ["lab banners"] = "ตู้สุ่มแล็บ",
    ["lab odds"] = "อัตราโอกาสออกสัตว์เลี้ยงจากแล็บ",
    ["lab stock"] = "สินค้าในแล็บ",
    ["minigame eggs"] = "ไข่จากมินิเกม",
    ["move"] = "เคลื่อนที่",
    ["movement"] = "การเคลื่อนที่",
    ["nearest player"] = "ผู้เล่นที่ใกล้ที่สุด",
    ["next"] = "ถัดไป",
    ["no admin boost right now"] = "ตอนนี้ไม่มีบูสต์แอดมิน",
    ["other pens esp"] = "แสดงตำแหน่งคอกผู้เล่นอื่น",
    ["others"] = "อื่น ๆ",
    ["pen egg esp"] = "แสดงตำแหน่งไข่ในคอก",
    ["place lab reward eggs"] = "วางไข่รางวัลจากแล็บ",
    ["player esp"] = "แสดงตำแหน่งผู้เล่น",
    ["protection"] = "การป้องกัน",
    ["racer selection"] = "เลือกตัวแข่ง",
    ["rarest"] = "หายากที่สุด",
    ["show"] = "แสดง",
    ["skip friends"] = "ไม่โจมตีเพื่อน",
    ["smart trade for essence"] = "แลกอย่างคุ้มค่าเพื่อรับแก่นพลัง",
    ["stage"] = "ด่าน",
    ["take it from the holder"] = "แย่งไข่จากผู้ที่ถืออยู่",
    ["trade"] = "แลก",
    ["tween speed"] = "ความเร็วการเคลื่อนที่แบบ Tween",
    ["upcoming banners"] = "ตู้สุ่มชุดถัดไป",
    ["use admin treadmill"] = "ใช้ลู่วิ่งของแอดมิน",
    ["use weapons"] = "อาวุธที่จะใช้",
    ["waiting for red light green light or t-rex run"] = "กำลังรอมินิเกม Red Light Green Light หรือ T-Rex Run",
    ["weapons"] = "อาวุธ",
    ["wisp companion"] = "คู่หูวิญญาณวิสป์",
    -- V1.3 • คำแปลตัวเลือกและชื่อฟังก์ชันเพิ่มเติมจากภาพชุดล่าสุด
    ["abyss ocean"] = "มหาสมุทรใต้พิภพ",
    ["all 106"] = "ทั้งหมด 106",
    ["all 108"] = "ทั้งหมด 108",
    ["always favorite"] = "ตั้งเป็นรายการโปรดเสมอ",
    ["amethyst"] = "อเมทิสต์",
    ["any"] = "ใดก็ได้",
    ["bird"] = "นก",
    ["cash booster"] = "ตัวคูณเงิน",
    ["celestial sunlion"] = "สิงโตสุริยันสวรรค์",
    ["cheetah"] = "เสือชีตาห์",
    ["cherry blossom"] = "ดอกซากุระ",
    ["cosmic"] = "จักรวาล",
    ["current"] = "ปัจจุบัน",
    ["desert"] = "ทะเลทราย",
    ["emerald"] = "มรกต",
    ["esp"] = "แสดงตำแหน่ง",
    ["essence"] = "แก่นพลัง",
    ["favorite equipped"] = "ตั้งสัตว์เลี้ยงที่สวมใส่เป็นรายการโปรด",
    ["forest"] = "ป่าไม้",
    ["frogfly"] = "กบแมลงวัน",
    ["growing 0"] = "กำลังเติบโต 0",
    ["highest value"] = "มูลค่าสูงสุด",
    ["highest weight"] = "น้ำหนักมากที่สุด",
    ["icon + text"] = "ไอคอนและข้อความ",
    ["in bag 97"] = "ในกระเป๋า 97",
    ["jungle"] = "ป่าดงดิบ",
    ["kitsune"] = "คิทสึเนะ",
    ["lake"] = "ทะเลสาบ",
    ["light dark"] = "สว่างและมืด",
    ["lizard"] = "กิ้งก่า",
    ["lowest weight"] = "น้ำหนักน้อยที่สุด",
    ["most valuable"] = "มูลค่าสูงสุด",
    ["move to egg"] = "วิธีเคลื่อนที่ไปหาไข่",
    ["nearest"] = "ใกล้ที่สุด",
    ["ostrich"] = "นกกระจอกเทศ",
    ["prehistoric"] = "ยุคก่อนประวัติศาสตร์",
    ["preview"] = "ตัวอย่าง",
    ["pure jellyfish"] = "แมงกะพรุนบริสุทธิ์",
    ["racing bat"] = "ไม้ตีสำหรับแข่ง",
    ["radiant"] = "เรืองแสง",
    ["ready 9"] = "พร้อม 9",
    ["sapphire"] = "ไพลิน",
    ["seahorse"] = "ม้าน้ำ",
    ["selected"] = "เลือกแล้ว",
    ["shop"] = "ร้านค้า",
    ["shortest time first"] = "เหลือเวลาน้อยที่สุดก่อน",
    ["showcase"] = "รายการไข่",
    ["skeleton horse"] = "ม้าโครงกระดูก",
    ["snow"] = "ดินแดนหิมะ",
    ["stacked turtle"] = "เต่าซ้อนชั้น",
    ["starry fox"] = "จิ้งจอกดวงดาว",
    ["step"] = "เคลื่อนที่ทีละก้าว",
    ["step to egg"] = "เคลื่อนที่ทีละก้าวไปหาไข่",
    ["text"] = "ข้อความ",
    ["three headed chicken"] = "ไก่สามหัว",
    ["time left"] = "เวลาที่เหลือ",
    ["time remaining"] = "เวลาที่เหลือ",
    ["titan temple"] = "วิหารไททัน",
    ["treadmill boost"] = "ตัวช่วยเร่งลู่วิ่ง",
    ["unfavorite pets not matching"] = "นำสัตว์เลี้ยงที่ไม่ตรงเงื่อนไขออกจากรายการโปรด",
    ["volcano"] = "ภูเขาไฟ",
    ["weight"] = "น้ำหนัก",
    ["weight first"] = "น้ำหนักมากสุดก่อน",
    ["wheel hamster"] = "แฮมสเตอร์ล้อวิ่ง",
    ["zone"] = "โซน",
    -- V1.4 • Additive Thai translations for remaining visible options (ZIGZAG)
    ["auto place eggs"] = "วางไข่อัตโนมัติ",
    ["bloom"] = "เบ่งบาน",
    ["choose what to place first"] = "เลือกวางก่อน",
    ["choose who to hit"] = "เลือกผู้ที่จะโจมตี",
    ["choose who to hit / hit who"] = "เลือกผู้ที่จะโจมตี",
    ["cracked"] = "แตกร้าว",
    ["defaults"] = "ค่าเริ่มต้น",
    ["diamond"] = "เพชร",
    ["egg holders"] = "ผู้ถือไข่",
    ["egg(s) ready to place"] = "ฟองพร้อมวาง",
    ["first hop after slider"] = "แถบปรับเวลาก่อนย้ายเซิร์ฟเวอร์ครั้งแรก",
    ["from chilii"] = "จาก Chilii",
    ["game hud"] = "แผงควบคุมในเกม",
    ["golden"] = "ทอง",
    ["instant steps slider"] = "แถบปรับจำนวนก้าว",
    ["min value /s slider"] = "แถบปรับมูลค่าขั้นต่ำ/วินาที",
    ["only at night"] = "เฉพาะตอนกลางคืน",
    ["parasite"] = "ปรสิต",
    ["place condition"] = "เงื่อนไขการวาง",
    ["rainbow"] = "สายรุ้ง",
    ["right after a steal"] = "ทันทีหลังขโมยไข่",
    ["shapeshift"] = "แปลงร่าง",
    ["silver"] = "เงิน",
    ["smallest"] = "ตัวเล็กที่สุด",
    ["spirit bloom"] = "เบ่งบานแห่งวิญญาณ",
    ["steal is idle"] = "เมื่อระบบขโมยไข่ว่าง",
    ["steal panel button on game hud"] = "แสดงปุ่มแผงขโมยไข่บน HUD",

    -- V1.5 • คำแปลเพิ่มเติมจากภาพ VENYX: แล็บ, ผีเสื้อ, ปักหมุด และตัวเลือกย่อย
    ["no egg matches here"] = "ไม่มีไข่ที่ตรงเงื่อนไขในเซิร์ฟเวอร์นี้",
    ["a rare egg spawned"] = "มีไข่หายากปรากฏแล้ว",
    ["waiting for daytime"] = "กำลังรอเวลากลางวัน",
    ["waiting for the next butterfly bloom"] = "กำลังรอกิจกรรมผีเสื้อผลิบานครั้งถัดไป",
    ["kept eggs are never placed, hatched or sold, in your bag or your pen."] = "ไข่ที่เลือกเก็บจะไม่ถูกนำไปวาง ฟัก หรือขาย ไม่ว่าจะอยู่ในกระเป๋าหรือคอกไข่",
    ["eggs to keep"] = "ไข่ที่จะเก็บไว้",
    ["most copies"] = "มีตัวซ้ำมากที่สุด",
    ["stand"] = "ยืนนิ่ง",
    ["patrol"] = "เดินตรวจตรา",
    ["circle"] = "เคลื่อนที่วนรอบ",
    ["emerald to sapphire"] = "มรกต → ไพลิน",
    ["sapphire to amethyst"] = "ไพลิน → อเมทิสต์",
    ["amethyst to radiant"] = "อเมทิสต์ → เรืองแสง",
    ["biohazard pets"] = "สัตว์เลี้ยงชีวอันตราย",
    ["unstable dna"] = "ดีเอ็นเอไม่เสถียร",
    ["stock lab eggs"] = "สำรองไข่สำหรับแล็บ",
    ["stock for banners"] = "สำรองไข่สำหรับตู้สุ่ม",
    ["biohazard pets eggs"] = "ไข่สัตว์เลี้ยงชีวอันตราย",
    ["experimental pets eggs"] = "ไข่สัตว์เลี้ยงทดลอง",
    ["unstable dna eggs"] = "ไข่ดีเอ็นเอไม่เสถียร",
    ["stock per egg"] = "จำนวนไข่ที่สำรองต่อชนิด",
    ["keeps eggs for recipes that have not shown up yet. % is how often a recipe asks for that egg."] = "สำรองไข่ไว้สำหรับสูตรที่ยังไม่ปรากฏ โดย % บอกความถี่ที่สูตรต้องใช้ไข่ชนิดนั้น",
    ["octophant"] = "อ็อกโทแฟนต์",
    ["slider"] = "แถบปรับค่า",
    ["only below /s slider"] = "แถบปรับมูลค่าสูงสุด/วินาที",
    ["+ pin"] = "+ ปักหมุด",
    ["steal / auto steal"] = "ขโมยไข่ / ขโมยอัตโนมัติ",
    ["steal / auto steal / filter"] = "ขโมยไข่ / อัตโนมัติ / ตัวกรอง",
    ["steal / auto steal / auto hop server"] = "ขโมยไข่ / อัตโนมัติ / ย้ายเซิร์ฟเวอร์",
    ["farm / pen / auto place"] = "ฟาร์ม / คอกไข่ / วางไข่อัตโนมัติ",
    ["farm / pen / auto hatch"] = "ฟาร์ม / คอกไข่ / ฟักไข่อัตโนมัติ",
    ["system / interface / game hud"] = "ระบบ / หน้าต่าง / แผงควบคุมในเกม",
    ["twilight"] = "ยามสนธยา",
    ["aurora"] = "แสงเหนือ",
    ["ocean"] = "มหาสมุทร",
    ["midnight"] = "เที่ยงคืน",
    ["sakura"] = "ซากุระ",
    ["onyx"] = "หินนิล",
    ["black"] = "ดำ",
    ["mono"] = "ขาวดำ",

    -- V1.6 • All circled English labels in the PIN / quick-bar picker.
    -- Only GUI text: these keys do not affect the original Venyx option IDs.
    ["min value /s slider"] = "แถบปรับมูลค่าขั้นต่ำต่อวินาที",
    ["only below /s slider"] = "แถบปรับเกณฑ์มูลค่าต่ำกว่าต่อวินาที",
    ["tween speed slider"] = "แถบปรับความเร็วการเคลื่อนที่",
    ["delivery speed slider"] = "แถบปรับความเร็วส่งไข่",
    ["instant steps slider"] = "แถบปรับจำนวนก้าวแบบทันที",
    ["first hop after slider"] = "แถบปรับเวลาย้ายเซิร์ฟเวอร์ครั้งแรก",
    ["stock per egg slider"] = "แถบปรับจำนวนไข่สำรองต่อชนิด",
    ["upcoming banners button"] = "ปุ่มดูตู้สุ่มชุดถัดไป",
    ["race speed slider"] = "แถบปรับความเร็วแข่งวิ่ง",
    ["catch speed slider"] = "แถบปรับความเร็วในการจับ",
    ["hold height slider"] = "แถบปรับความสูงขณะถือ",
    ["keep away slider"] = "แถบปรับระยะห่าง",
    ["sell matching lab eggs now button"] = "ปุ่มขายไข่แล็บที่ตรงเงื่อนไขทันที",
    ["sell matching pets now button"] = "ปุ่มขายสัตว์เลี้ยงที่ตรงเงื่อนไขทันที",
    -- Additional button/slider variants generated by the same Venyx pin picker.
    ["sell matching eggs now button"] = "ปุ่มขายไข่ที่ตรงเงื่อนไขทันที",
    ["first hop after"] = "เวลาย้ายเซิร์ฟเวอร์ครั้งแรก",
    ["stock per egg"] = "จำนวนไข่สำรองต่อชนิด",
    ["upcoming banners"] = "ตู้สุ่มชุดถัดไป",
    ["race speed"] = "ความเร็วแข่งวิ่ง",
    ["catch speed"] = "ความเร็วในการจับ",
    ["hold height"] = "ความสูงขณะถือ",
    ["keep away"] = "ระยะห่าง",

    -- V1.7 • Steal Panel ด้านขวา (เฉพาะข้อความ UI ไม่แตะข้อมูลตัวละคร/เกม)
    ["steal panel"] = "แผงขโมยไข่",
    ["auto steal on"] = "ขโมยไข่อัตโนมัติ: เปิด",
    ["auto steal off"] = "ขโมยไข่อัตโนมัติ: ปิด",
    ["auto steal: on"] = "ขโมยไข่อัตโนมัติ: เปิด",
    ["auto steal: off"] = "ขโมยไข่อัตโนมัติ: ปิด",
    ["show: all"] = "แสดง: ทั้งหมด",
    ["show: ready"] = "แสดง: พร้อมขโมย",
    ["show: stolen"] = "แสดง: ขโมยแล้ว",
    ["show: available"] = "แสดง: ขโมยได้",
    ["show: none"] = "แสดง: ไม่มี",
    ["show: mine"] = "แสดง: ของฉัน",
    ["show: others"] = "แสดง: ของผู้อื่น",
    ["show: rarity"] = "แสดง: ระดับความหายาก",
    ["show: value"] = "แสดง: มูลค่า",
    -- ชื่อสัตว์ที่เห็นในภาพ: แปลเฉพาะป้ายชื่อที่ปรากฏ ไม่เปลี่ยนข้อมูลสัตว์
    ["gargoyle"] = "การ์กอยล์",
    ["spirit panda"] = "แพนด้าวิญญาณ",
    ["mantaris"] = "แมนทาริส",
    ["astral jackalope"] = "แจ็กคาโลปแห่งดวงดาว",
    ["demon hound"] = "สุนัขล่าเนื้อปีศาจ",

    -- V1.9 • VENYX v1.1.0 HALLOWEEN: เฉพาะคำแปลที่เห็นใน UI
    -- ไม่แก้ไขตัวเลือก / ค่า / remote / gameplay / loader / teleport logic
    ["halloween"] = "ฮาโลวีน",
    ["halloween dimension"] = "มิติฮาโลวีน",
    ["halloween eggs"] = "ไข่ฮาโลวีน",
    ["halloween egg"] = "ไข่ฮาโลวีน",
    ["halloween rarities"] = "ระดับความหายากของไข่ฮาโลวีน",
    ["auto steal halloween eggs"] = "ขโมยไข่ฮาโลวีนอัตโนมัติ",
    ["instant steal halloween eggs"] = "ขโมยไข่ฮาโลวีนทันที",
    ["steal speed"] = "ความเร็วในการขโมยไข่",
    ["auto pumpkin moon"] = "ทำกิจกรรมพระจันทร์ฟักทองอัตโนมัติ",
    ["pumpkin moon"] = "พระจันทร์ฟักทอง",
    ["walk speed"] = "ความเร็วเดิน",
    ["auto buy halloween dimension egg"] = "ซื้อไข่มิติฮาโลวีนอัตโนมัติ",
    ["auto buy halloween dimension eggs"] = "ซื้อไข่มิติฮาโลวีนอัตโนมัติ",
    ["monsters"] = "มอนสเตอร์",
    ["monster"] = "มอนสเตอร์",
    ["auto kill monsters"] = "กำจัดมอนสเตอร์อัตโนมัติ",
    ["monster order"] = "ลำดับเลือกมอนสเตอร์",
    ["most tokens"] = "ได้รับโทเคนมากที่สุด",
    ["phantom express"] = "รถไฟภูตพราย",
    ["train"] = "รถไฟ",
    ["not here"] = "ยังไม่มา",
    ["souls"] = "วิญญาณ",
    ["soul"] = "วิญญาณ",
    ["auto phantom express"] = "ขึ้นรถไฟภูตพรายอัตโนมัติ",
    ["auto vacuum ghouler boss"] = "ดูดบอส Ghouler อัตโนมัติ",
    ["ghouler boss"] = "บอส Ghouler",
    ["ghost target"] = "เป้าหมายผี",
    ["rarest first"] = "หายากที่สุดก่อน",
    ["auto trade souls"] = "แลกวิญญาณอัตโนมัติ",
    ["ghost dog and fishing"] = "เควสต์สุนัขผีและตกปลา",
    ["ghost dog quest"] = "เควสต์สุนัขผี",
    ["quest"] = "เควสต์",
    ["fish caught"] = "ปลาที่จับได้",
    ["auto ghost dog quest"] = "ทำเควสต์สุนัขผีอัตโนมัติ",
    ["auto fishing"] = "ตกปลาอัตโนมัติ",
    ["cast luck"] = "โชคในการเหวี่ยงเบ็ด",
    ["x1.5 perfect"] = "x1.5 สมบูรณ์แบบ",
    -- V1.8.3 • NEW VENYX v1.1.0 SCREENSHOTS (2026-10-19) – exact UI labels only
    -- Cursed Island Wars: event card + target-selector modal + choices
    ["cursed island wars"] = "สงครามเกาะต้องสาป",
    ["waiting for cursed island wars"] = "กำลังรอสงครามเกาะต้องสาป",
    ["auto play cursed island wars"] = "เล่นสงครามเกาะต้องสาปอัตโนมัติ",
    ["island wars target"] = "เป้าหมายสงครามเกาะ",
    ["enemies and base"] = "ศัตรูและฐาน",
    ["walls and crystal"] = "กำแพงและคริสตัล",
    -- Farm > Mutation: status text below the existing automatic mutation card
    ["every egg that fits already has these mutations"] = "ไข่ทุกฟองที่ตรงเงื่อนไขมีการกลายพันธุ์เหล่านี้อยู่แล้ว",
    ["every egg that fits already has these mutations."] = "ไข่ทุกฟองที่ตรงเงื่อนไขมีการกลายพันธุ์เหล่านี้อยู่แล้ว",

    -- HYBRID V1.8.3: video-based UI / pop-up / dropdown labels
    ["quick bar"] = "แถบทางลัด",
    ["favorites"] = "รายการโปรด",
    ["favorite items"] = "ไอเทมโปรด",
    ["options"] = "ตัวเลือก",
    ["select one option"] = "เลือกหนึ่งตัวเลือก",
    ["select an option"] = "เลือกตัวเลือก",
    ["search options"] = "ค้นหาตัวเลือก",
    ["search for option"] = "ค้นหาตัวเลือก",
    ["no options"] = "ไม่มีตัวเลือก",
    ["submit"] = "ส่ง",
    ["back"] = "ย้อนกลับ",
    ["yes"] = "ใช่",
    ["no"] = "ไม่",
    ["auto import"] = "นำเข้าอัตโนมัติ",
    ["no updates available"] = "ไม่มีอัปเดตใหม่",
    ["candy corn"] = "ลูกอมข้าวโพด",
    ["money /s"] = "เงินต่อวินาที",
    ["pinned actions"] = "คำสั่งที่ปักหมุด",
    ["choose an option"] = "เลือกตัวเลือก",
}

-- ZIGZAG V1.8.5: VENYX v1.2.2 / Halloween & Star / fishing popup
-- Lowercase exact UI text only; preserve option IDs, handlers, and loader.
local ZIGZAG_V184_VENYX_LABELS = {
    ["halloween & star"] = "ฮาโลวีนและดาวตก",
    ["place and hatch missing index eggs"] = "วางและฟักไข่ที่ยังไม่มีในสารบัญ",
    ["fishing spot"] = "จุดตกปลา",
    ["save spot here"] = "บันทึกจุดตกปลาที่นี่",
    ["spot 1"] = "จุด 1",
    ["spot 2"] = "จุด 2",
    ["spot 3"] = "จุด 3",
    ["waiting for the phantom express"] = "กำลังรอรถไฟภูตพราย",
    ["only during blood moon"] = "เฉพาะช่วงพระจันทร์สีเลือด",
    ["fighting large monster"] = "กำลังต่อสู้กับมอนสเตอร์ขนาดใหญ่",
}
for english,thai in pairs(ZIGZAG_V184_VENYX_LABELS) do
    if TH[english] == nil then
        TH[english] = thai
    end
end

--========================================================
-- ZIGZAG V1.8.5 • VENYX v1.2.4 BLOOD MOON / FISHING
-- Add-only UI label dictionary. Original popup behavior untouched.
--========================================================
local ZIGZAG_V185_VENYX_LABELS = {
    ["farm all monsters in blood moon"] = "ฟาร์มมอนสเตอร์ทั้งหมดช่วงพระจันทร์สีเลือด",
    ["farm monsters while fishing"] = "ฟาร์มมอนสเตอร์ระหว่างตกปลา",
    ["waiting: nothing to do"] = "กำลังรอ: ไม่มีงานให้ทำ",
    ["take halloween eggs from holders"] = "แย่งไข่ฮาโลวีนจากผู้ที่กำลังถือ",
    ["teleport to pumpkins"] = "วาร์ปไปหาฟักทอง",
    ["teleport to monsters"] = "วาร์ปไปหามอนสเตอร์",
    ["teleport to ghosts"] = "วาร์ปไปหาผี",
    ["fishing history"] = "ประวัติการตกปลา",
    ["catches"] = "จำนวนที่จับได้",
}
for english,thai in pairs(ZIGZAG_V185_VENYX_LABELS) do
    if TH[english] == nil then
        TH[english] = thai
    end
end

--========================================================
-- ZIGZAG V1.8.6 • VENYX v1.2.8 PRIORITY ROTATION/THE HOLLOW
-- UI label translations only. Option IDs & callbacks stay intact.
--========================================================
local ZIGZAG_V186_VENYX_LABELS = {
    ["priority rotation"] = "สลับงานตามลำดับความสำคัญ",
    ["rotate fishing and treadmill"] = "สลับตกปลากับลู่วิ่ง",
    ["rotation switch"] = "เงื่อนไขการสลับงาน",
    ["fishing minutes"] = "เวลาตกปลา (นาที)",
    ["treadmill minutes"] = "เวลาวิ่งลู่ (นาที)",
    ["timer"] = "ตั้งเวลา",
    ["every day"] = "ทุกวัน",
    ["switch"] = "สลับงาน",
    ["the hollow"] = "เดอะฮอลโลว์",
    ["the hollow race"] = "การแข่งขันเดอะฮอลโลว์",
    ["auto race the hollow"] = "แข่งเดอะฮอลโลว์อัตโนมัติ",
    ["hollow race speed"] = "ความเร็วแข่งเดอะฮอลโลว์",
    ["use race power-ups"] = "ใช้ไอเทมเพิ่มพลังระหว่างแข่ง",
    ["wins"] = "ชัยชนะ",
    ["now"] = "ตอนนี้",
    ["doing now"] = "กำลังทำ",
    ["switch in"] = "สลับในอีก",
    ["next 1"] = "ถัดไป 1",
    ["next 2"] = "ถัดไป 2",
    ["next 3"] = "ถัดไป 3",
    ["farm monsters"] = "ฟาร์มมอนสเตอร์",
    ["farm monsters in blood moon"] = "ฟาร์มมอนสเตอร์ช่วงพระจันทร์สีเลือด",
    ["place eggs"] = "วางไข่",
    ["mutate eggs"] = "ทำให้ไข่กลายพันธุ์",
    ["wisp quest"] = "ภารกิจ Wisp",
    ["riding the phantom express"] = "กำลังขึ้นรถไฟภูตพราย",
    ["fighting small monster"] = "กำลังต่อสู้กับมอนสเตอร์ขนาดเล็ก",
    ["top goes first. a task never stops halfway: the next one waits until it finishes. a carried egg is always delivered first."] = "งานลำดับบนสุดทำก่อน งานที่เริ่มแล้วจะทำให้เสร็จก่อนจึงสลับงานถัดไป และจะนำไข่ที่ถืออยู่ไปส่งก่อนเสมอ",
    ["lower it if laps do not count"] = "ลดความเร็วลงหากระบบไม่นับรอบการแข่งขัน",
}
for english,thai in pairs(ZIGZAG_V186_VENYX_LABELS) do
    -- V1.8.6 supersedes older inconsistent translations for exact labels.
    TH[english] = thai
end

--========================================================
-- ZIGZAG V1.8.7 • VENYX LABELS + PROMOTIONAL POP-UPS
-- Covers the corresponding English labels on the native Venyx side.
-- Only visible display text; no option IDs / callbacks / loader edits.
--========================================================
local ZIGZAG_V187_VENYX_LABELS = {
    ["move to egg speed"] = "ความเร็วในการไปหาไข่",
    ["delivery"] = "วิธีส่งไข่กลับฐาน",
    ["fast tween"] = "เคลื่อนที่เร็วแบบ Tween",
    ["fast tween speed"] = "ความเร็วส่งไข่แบบ Tween",
    ["instant steps"] = "เคลื่อนที่ทันทีแบบเป็นขั้น",
    ["leap"] = "กระโดดพุ่ง",
    ["auto claim money"] = "รับเงินอัตโนมัติ",
    ["auto claim cash"] = "รับเงินอัตโนมัติ",
    ["sell matching eggs once"] = "ขายไข่ที่ตรงเงื่อนไขหนึ่งครั้ง",
    ["sell matching eggs once."] = "ขายไข่ที่ตรงเงื่อนไขหนึ่งครั้ง",
    ["sell egg rule"] = "กฎการขายไข่",
    ["egg max rarity"] = "ความหายากสูงสุดของไข่ที่จะขาย",
    ["sell eggs at or below this rarity"] = "ขายไข่ระดับนี้หรือต่ำกว่า",
    ["sell eggs at or below this rarity."] = "ขายไข่ระดับนี้หรือต่ำกว่า",
    ["egg sell value"] = "มูลค่าไข่ที่จะขาย",
    ["sell eggs worth less than this (0 = off)"] = "ขายไข่ที่มูลค่าต่ำกว่าที่กำหนด (0 = ปิด)",
    ["keep mutated eggs"] = "เก็บไข่ที่กลายพันธุ์ไว้",
    ["never sell mutated eggs"] = "ห้ามขายไข่ที่กลายพันธุ์",
    ["never sell mutated eggs."] = "ห้ามขายไข่ที่กลายพันธุ์",
    ["blacklist sell eggs"] = "รายการไข่ห้ามขาย",
    ["these eggs are never sold"] = "ไข่เหล่านี้จะไม่ถูกขาย",
    ["these eggs are never sold."] = "ไข่เหล่านี้จะไม่ถูกขาย",
    ["cursed island wars"] = "สงครามเกาะต้องสาป",
    ["waiting for cursed island wars"] = "กำลังรอสงครามเกาะต้องสาป",
    ["auto play cursed island wars"] = "เล่นสงครามเกาะต้องสาปอัตโนมัติ",
    ["island wars target"] = "เป้าหมายสงครามเกาะต้องสาป",
    ["enemies and base"] = "ศัตรูและฐาน",
    ["walls and crystal"] = "กำแพงและคริสตัล",
    ["smoother, faster and more ways to steal."] = "ลื่นไหลขึ้น เร็วขึ้น พร้อมวิธีขโมยที่หลากหลายกว่าเดิม",
    ["smoother, faster and more ways to steal"] = "ลื่นไหลขึ้น เร็วขึ้น พร้อมวิธีขโมยที่หลากหลายกว่าเดิม",
    ["try now"] = "ลองใช้งานเลย",
    ["smoother & faster"] = "ลื่นไหลและเร็วขึ้น",
    ["smoother and faster"] = "ลื่นไหลและเร็วขึ้น",
    ["less lag, quick to load."] = "แลคน้อยลง โหลดเร็วขึ้น",
    ["less lag, quick to load"] = "แลคน้อยลง โหลดเร็วขึ้น",
    ["more steal methods"] = "มีวิธีขโมยไข่มากขึ้น",
    ["teleport, fast tween and more."] = "วาร์ป เคลื่อนที่เร็วแบบ Tween และอีกมากมาย",
    ["teleport, fast tween and more"] = "วาร์ป เคลื่อนที่เร็วแบบ Tween และอีกมากมาย",
    ["steal from players"] = "ขโมยไข่จากผู้เล่น",
    ["hits whoever takes your egg."] = "โจมตีผู้ที่แย่งไข่ของคุณไป",
    ["hits whoever takes your egg"] = "โจมตีผู้ที่แย่งไข่ของคุณไป",
    ["easy setup"] = "ตั้งค่าง่าย",
    ["bring your chilli config over."] = "นำคอนฟิกจาก Chilli มาใช้ได้",
    ["bring your chilli config over"] = "นำคอนฟิกจาก Chilli มาใช้ได้",
}
for english,thai in pairs(ZIGZAG_V187_VENYX_LABELS) do
    TH[english] = thai
end

local function tidy(text)
    return (text:gsub("^%s+", ""):gsub("%s+$", ""))
end
local function key(text)
    return string.lower(tidy(text))
end

-- Translate count/status labels while preserving user values and item names.
local DYNAMIC = {
    -- V1.8.7 • Alternate mutation-capacity wording on newer builds.
    {"^(%d+) eggs? can be mutated%.?$", function(n)
        return "มีไข่ที่กลายพันธุ์ได้ " .. n .. " ฟอง"
    end},
    {"^(%d+) egg%(s%) can be mutated%.?$", function(n)
        return "มีไข่ที่กลายพันธุ์ได้ " .. n .. " ฟอง"
    end},
    -- V1.8.6 • Variable race wins, minutes, and priority queue indices.
    {"^[Oo][Ff][Ff]%s*|%s*[Ww]ins:%s*(%d+)%s*/%s*(%d+)$", function(wins,total)
        return "ปิด | ชัยชนะ: " .. wins .. "/" .. total
    end},
    {"^[Oo][Nn]%s*|%s*[Ww]ins:%s*(%d+)%s*/%s*(%d+)$", function(wins,total)
        return "เปิด | ชัยชนะ: " .. wins .. "/" .. total
    end},
    {"^[Ww]ins:%s*(%d+)%s*/%s*(%d+)$", function(wins,total)
        return "ชัยชนะ: " .. wins .. "/" .. total
    end},
    {"^[Nn][Ee][Xx][Tt]%s+(%d+)$", function(n)
        return "ถัดไป " .. n
    end},
    {"^(%d+)%s+min$", function(n)
        return n .. " นาที"
    end},

    -- V1.5 • แปลข้อความยาวที่ตัดบรรทัด และอัตราโอกาสการออกสัตว์เลี้ยงจากตู้สุ่ม
    {"^Keeps eggs for recipes that have not shown up yet%.%s*%% is how often a recipe asks for that egg%.$", function()
        return "สำรองไข่ไว้สำหรับสูตรที่ยังไม่ปรากฏ โดย % บอกความถี่ที่สูตรต้องใช้ไข่ชนิดนั้น"
    end},
    {"^(.+) %- 1 in ([%d%.]+) %(pity (%d+)%)$", function(rarity, chance, pity)
        local label = TH[key(rarity)] or rarity
        return label .. " • โอกาส 1 ใน " .. chance .. " (การันตีที่ " .. pity .. " ครั้ง)"
    end},
    {"^(.+) %- 1 in ([%d%.]+)$", function(rarity, chance)
        local label = TH[key(rarity)] or rarity
        return label .. " • โอกาส 1 ใน " .. chance
    end},
    {"^ALL (%d+)$", function(n) return "ทั้งหมด " .. n end},
    {"^READY (%d+)$", function(n) return "พร้อม " .. n end},
    {"^GROWING (%d+)$", function(n) return "กำลังเติบโต " .. n end},
    {"^IN BAG (%d+)$", function(n) return "ในกระเป๋า " .. n end},
    {"^%+?(%d+) hours? ago$", function(n) return n .. " ชั่วโมงก่อน" end},
    {"^(.+), changes in (%d+)m (%d+)s%s*Still needs: (.-)%s*Guaranteed pet in (%d+) trades, (%d+) free rerolls left$", function(name, mins, secs, needed, trades, rerolls)
        return name .. " • เปลี่ยนใน " .. mins .. " นาที " .. secs .. " วินาที\nยังต้องการ: " .. needed .. "\nรับประกันสัตว์เลี้ยงในอีก " .. trades .. " ครั้ง • สุ่มสูตรฟรีคงเหลือ " .. rerolls .. " ครั้ง"
    end},
    {"^(.+), changes in (%d+)m (%d+)s$", function(name, mins, secs)
        return name .. " • เปลี่ยนใน " .. mins .. " นาที " .. secs .. " วินาที"
    end},
    {"^Still needs: (.+)$", function(items)
        return "ยังต้องการ: " .. items
    end},
    {"^Guaranteed pet in (%d+) trades, (%d+) free rerolls left$", function(trades, rerolls)
        return "รับประกันสัตว์เลี้ยงในอีก " .. trades .. " ครั้ง • สุ่มสูตรฟรีคงเหลือ " .. rerolls .. " ครั้ง"
    end},
    {"^Pen (%d+/%d+) %- (%d+) egg%(s%) ready to place$", function(p, n)
        return "คอก " .. p .. " • ไข่พร้อมวาง " .. n .. " ฟอง"
    end},
    {"^(%d+) egg%(s%) can be mutated$", function(n)
        return "มีไข่กลายพันธุ์ได้ " .. n .. " ฟอง"
    end},
    {"^(%d+) pet%(s%) match$", function(n)
        return "พบสัตว์เลี้ยง " .. n .. " ตัว"
    end},
    {"^(%d+) egg%(s%) match$", function(n)
        return "พบไข่ " .. n .. " ฟอง"
    end},
    {"^(%d+) lab egg%(s%) match$", function(n)
        return "พบไข่แล็บ " .. n .. " ฟอง"
    end},
    {"^(%d+) x (.+) ready to fuse$", function(n, name)
        return name .. " พร้อมผสม " .. n .. " ตัว"
    end},
    {"^(%d+) egg%(s%) ready to place$", function(n)
        return "ไข่พร้อมวาง " .. n .. " ฟอง"
    end},
    {"^(%d+) hours? ago$", function(n)
        return n .. " ชั่วโมงก่อน"
    end},
    {"^(%d+) days? ago$", function(n)
        return n .. " วันก่อน"
    end},
    {"^(%d+) minutes? ago$", function(n)
        return n .. " นาทีก่อน"
    end},
    {"^Welcome back[,]?$", function()
        return "ยินดีต้อนรับกลับ"
    end},
}

-- In the pin picker, Venyx can use RichText to render the option name
-- in white and the control type ("slider" / "button") in gray.
-- A raw string like `Min value /s <font ...>slider</font>` did not match
-- the plain-string dictionary in V1.5 and therefore stayed in English.
-- Match by the VISIBLE text only, never edit option IDs/callbacks.
local function pinnedLabelTranslation(text)
    local exact = TH[key(text)]
    if exact then return exact end
    -- Generic fallback for further pinned entries: translate only when
    -- their base name is already known in the UI dictionary.
    local base = text:match("^(.-)%s+slider$")
    if base then
        local baseThai = TH[key(base)]
        if baseThai then return "แถบปรับ" .. baseThai end
    end
    base = text:match("^(.-)%s+button$")
    if base then
        local baseThai = TH[key(base)]
        if baseThai then return "ปุ่ม" .. baseThai end
    end
    base = text:match("^(.-)%s+input$")
    if base then
        local baseThai = TH[key(base)]
        if baseThai then return "ช่องกรอก" .. baseThai end
    end
    return nil
end

local function translate(raw)
    if type(raw) ~= "string" or raw == "" then return raw end
    local normalized = tidy(raw)
    local translated = TH[key(normalized)]
    local richText = false
    if not translated then
        -- A UI-only fix: tolerate styled suffixes and extra whitespace.
        -- Unknown descriptions, account/player names and user inputs
        -- remain unchanged, avoiding accidental alteration of game data.
        richText = normalized:find("<[^>]+>") ~= nil
        local visible = normalized
        if richText then
            visible = visible:gsub("<[^>]+>", "")
            visible = visible:gsub("&nbsp;", " "):gsub("&amp;", "&")
        end
        visible = tidy((visible:gsub("%s+", " ")))
        translated = pinnedLabelTranslation(visible)
    end
    if not translated then
        -- Preserve everything that is not a known UI label, e.g. egg names,
        -- player names, inventory amounts, settings data and custom inputs.
        for _, rule in ipairs(DYNAMIC) do
            local captures = {string.match(normalized, rule[1])}
            if #captures > 0 then
                translated = rule[2](table.unpack(captures))
                break
            end
        end
    end
    if not translated and normalized:find("\n",1,true) then
        -- Pop-up descriptions may render multiple distinct known labels
        -- in ONE TextLabel. Translate lines without touching unknown lines.
        local changed=false
        local lines={}
        for line in (normalized.."\n"):gmatch("(.-)\n") do
            local candidate=translate(line)
            if candidate~=line then changed=true end
            lines[#lines+1]=candidate
        end
        if changed then translated=table.concat(lines,"\n") end
    end
    if not translated or translated == normalized then return raw end
    local pre = raw:match("^(%s*)") or ""
    local post = raw:match("(%s*)$") or ""
    -- For RichText pin labels, return clean Thai text rather than leaving
    -- English in font tags. This only affects those matching known labels.
    return pre .. translated .. post
end

local function isText(obj)
    return obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox")
end

local function translateProperty(obj, property)
    if not STATE.Running or STATE.Busy[obj] then return end
    local ok, current = pcall(function() return obj[property] end)
    if not ok or type(current) ~= "string" then return end
    -- Never replace what the user has typed into search/config text boxes.
    if property == "Text" and obj:IsA("TextBox") then return end
    local updated = translate(current)
    if updated == current then return end
    STATE.Busy[obj] = true
    local success = pcall(function() obj[property] = updated end)
    STATE.Busy[obj] = nil
    if success then STATE.Count = STATE.Count + 1 end
end

local function watchText(obj)
    if not STATE.Running or STATE.Observed[obj] or not isText(obj) then return end
    STATE.Observed[obj] = true
    translateProperty(obj, "Text")
    bind(obj:GetPropertyChangedSignal("Text"):Connect(function()
        translateProperty(obj, "Text")
    end))
    if obj:IsA("TextBox") then
        translateProperty(obj, "PlaceholderText")
        bind(obj:GetPropertyChangedSignal("PlaceholderText"):Connect(function()
            translateProperty(obj, "PlaceholderText")
        end))
    end
end

local function marker(text)
    if type(text) ~= "string" then return false end
    local lower = string.lower(text)
    return lower == "venyx" or lower == "venyx 🇹🇭"
        or lower:find("venyx discord", 1, true) ~= nil
        or lower:find("venyx sae", 1, true) ~= nil
end
-- Distinguish Chilli's *navigation button* from Venyx's full window.
-- IMPORTANT: VENYX Home contains a Chilli Hub/ZIGZAG promotional button.
-- The older "not chilliHeading" test rejected the actual VENYX window!
local function hasVenyxEvidence(root)
    if not root or not root.Parent then return false end
    local name=string.lower(tostring(root.Name or ""))
    if root:IsA("ScreenGui") and name:find("venyx",1,true) then
        return true
    end
    local brand=false
    local context=false
    local proof=false
    local seen=0
    for _,item in ipairs(root:GetDescendants()) do
        if isText(item) then
            local ok, value=pcall(function() return item.Text end)
            if ok and type(value)=="string" then
                local t=key(value:gsub("<[^>]+>",""))
                if t=="venyx" or t=="venyx 🇹🇭" or
                   t=="venyx / steal an egg" then brand=true end
                if t=="steal an egg" or t=="venyx / steal an egg" or
                   t=="venyx discord" then context=true end
                -- Visible controls that a mere Chilli sidebar shortcut
                -- doesn't have. Needed even on non-Home Venyx tabs.
                if t=="venyx discord" or t=="copy invite" or
                   t=="unload hub" or t=="what's new" or
                   t=="go to egg" or t=="delivery speed" or
                   t=="only these eggs" or t=="mutate first" or
                   t=="auto claim index rewards" or
                   t=="auto trade souls" or t=="monster order" or
                   t=="quick bar 1" or t=="pinned" then
                    proof=true
                end
                seen=seen+1
            end
        end
    end
    return brand and context and proof
end
local function isVenyxRoot(gui)
    if not gui or not gui.Parent then return false end
    if isText(gui) then return false end -- no Chilli "Venyx" button
    if not gui:IsA("ScreenGui") and not gui:IsA("Frame") and
       not gui:IsA("CanvasGroup") then return false end
    return hasVenyxEvidence(gui)
end

-- If both hubs share a ScreenGui, locate the actual VENYX window/frame
-- instead of translating every Chilli button or the game's HUD.
local function findVenyxSubwindow(screen)
    local best,bestSize=nil,math.huge
    for _,item in ipairs(screen:GetDescendants()) do
        if isText(item) then
            local ok,title=pcall(function() return item.Text end)
            if ok and type(title)=="string" then
                local t=key(title:gsub("<[^>]+>",""))
                if t=="venyx" or t=="venyx / steal an egg" then
                    local parent=item.Parent
                    while parent and parent~=screen do
                        if (parent:IsA("Frame") or parent:IsA("CanvasGroup")) then
                            local okSize,sz=pcall(function()return parent.AbsoluteSize end)
                            if okSize and sz.X>=330 and sz.Y>=180 and
                               hasVenyxEvidence(parent) then
                                -- Choose the narrowest Venyx subtree, NOT
                                -- the smallest on-screen frame: a Chilli
                                -- container can be smaller in pixel area.
                                local complexity=#parent:GetDescendants()
                                if complexity<bestSize then
                                    best,bestSize=parent,complexity
                                end
                            end
                        end
                        parent=parent.Parent
                    end
                end
            end
        end
    end
    return best
end

local function AddVenyxCredit(root)
    if not root or not root.Parent then return end
    if root:FindFirstChild("ZIGZAG_VENYX_TRANSLATION_CREDIT",true) then return end
    local host = nil
    for _,obj in ipairs(root:GetDescendants()) do
        if isText(obj) then
            local ok,t = pcall(function() return obj.Text end)
            if ok and type(t)=="string" and
                (key(t)=="venyx" or key(t):find("venyx / steal an egg",1,true)) then
                local ancestor = obj.Parent
                while ancestor and ancestor~=root do
                    if ancestor:IsA("GuiObject") and
                       ancestor.AbsoluteSize.X>=300 and
                       ancestor.AbsoluteSize.Y>=200 then
                        host=ancestor
                        break
                    end
                    ancestor=ancestor.Parent
                end
                if host then break end
            end
        end
    end
    if not host then
        for _,obj in ipairs(root:GetChildren()) do
            if obj:IsA("GuiObject") and obj.AbsoluteSize.X>=300 and
               obj.AbsoluteSize.Y>=200 then
                host=obj
                break
            end
        end
    end
    if not host then host=root end
    local label=Instance.new("TextLabel")
    label.Name="ZIGZAG_VENYX_TRANSLATION_CREDIT"
    label.BackgroundTransparency=1
    label.Active=false
    label.Selectable=false
    label.AnchorPoint=Vector2.new(1,1)
    label.Position=UDim2.new(1,-11,1,-6)
    label.Size=UDim2.fromOffset(190,16)
    label.Text="✦ แปลไทยโดย ZIGZAG"
    label.TextSize=12
    label.Font=Enum.Font.GothamBold
    label.TextColor3=Color3.fromRGB(255,138,228)
    label.TextStrokeColor3=Color3.fromRGB(22,7,43)
    label.TextStrokeTransparency=0.18
    label.TextXAlignment=Enum.TextXAlignment.Right
    label.ZIndex=200
    label.Parent=host
    -- Only cosmetic. Never modifies Venyx's control values or callbacks.
end

local function observeRoot(root)
    if not STATE.Running or STATE.Roots[root] then return end
    STATE.Roots[root] = true
    local looksLikeMain=false
    local okMain,isMain=pcall(isVenyxRoot,root)
    if okMain and isMain then looksLikeMain=true end
    if looksLikeMain then
        STATE.MainSeen=true
        pcall(AddVenyxCredit,root)
    end
    for _,obj in ipairs(root:GetDescendants()) do watchText(obj) end
    bind(root.DescendantAdded:Connect(function(obj)
        -- Postpone one frame: Venyx may set new text just after parenting.
        task.defer(function()
            if not STATE.Running then return end
            watchText(obj)
            for _,nested in ipairs(obj:GetDescendants()) do watchText(nested) end
        end)
    end))
    print("[ZIGZAG VENYX THAI] พบ UI Venyx และเปิดตัวแปลไทยแล้ว")
end

local function containers()
    local sources = {CoreGui, PlayerGui}
    if type(gethui) == "function" then
        local ok, hidden = pcall(gethui)
        if ok and typeof(hidden) == "Instance" and hidden ~= CoreGui and hidden ~= PlayerGui then
            table.insert(sources, hidden)
        end
    end
    return sources
end

-- V1.7 • The optional Steal Panel can be a second ScreenGui rather than
-- a child of the Venyx main window. Detect it from its visible header
-- AND its distinct controls, then watch only that panel subtree.
local function isPanelLayoutContainer(instance)
    return instance:IsA("Frame") or instance:IsA("ScrollingFrame")
        or instance:IsA("CanvasGroup")
end

local function isStealPanelHeader(text)
    local name = key(text)
    return name == "steal panel" or name == "แผงขโมยไข่"
end

local function hasStealPanelControls(parent)
    local foundAuto, foundFilter, foundSteal = false, false, false
    for _, descendant in ipairs(parent:GetDescendants()) do
        if isText(descendant) then
            local ok, value = pcall(function() return descendant.Text end)
            if ok and type(value) == "string" then
                local label = key(value)
                if label == "auto steal on" or label == "auto steal off"
                    or label == "ขโมยไข่อัตโนมัติ: เปิด" or label == "ขโมยไข่อัตโนมัติ: ปิด" then
                    foundAuto = true
                elseif label == "show: all" or label == "แสดง: ทั้งหมด"
                    or label:sub(1, 6) == "show: " then
                    foundFilter = true
                elseif label == "steal" or label == "ขโมยไข่" then
                    foundSteal = true
                end
            end
        end
        if foundAuto and (foundFilter or foundSteal) then return true end
    end
    return false
end

local function findStandaloneStealPanel(gui)
    for _, obj in ipairs(gui:GetDescendants()) do
        if isText(obj) then
            local ok, value = pcall(function() return obj.Text end)
            if ok and isStealPanelHeader(value) then
                local parent = obj.Parent
                while parent and parent ~= gui do
                    if isPanelLayoutContainer(parent) and hasStealPanelControls(parent) then
                        return parent
                    end
                    parent = parent.Parent
                end
                -- An independent ScreenGui can be the panel itself.
                if hasStealPanelControls(gui) then return gui end
            end
        end
    end
    return nil
end

local function scan()
    for _,host in ipairs(containers()) do
        local ok, items = pcall(function() return host:GetDescendants() end)
        if ok then
            for _,obj in ipairs(items) do
                if obj:IsA("ScreenGui") then
                    if not STATE.Roots[obj] then
                        local found, answer = pcall(isVenyxRoot, obj)
                        if found and answer then observeRoot(obj) end
                    end
                    -- The Steal Panel may live in a separate game ScreenGui.
                    -- Observe only its own Frame, not all of the game's HUD.
                    if not STATE.Roots[obj] then
                        local okPanel, panel = pcall(findStandaloneStealPanel, obj)
                        if okPanel and panel and not STATE.Roots[panel] then
                            observeRoot(panel)
                        end
                    end
                end
            end
        end
    end
end

-- Hybrid V1.8.1: detect Venyx's UI as it appears without a permanent
-- scan loop. Batch ScreenGui updates to avoid scanning once per label.
local HOST_WATCHED = setmetatable({}, {__mode="k"})
local SCREEN_PENDING = setmetatable({}, {__mode="k"})
local POPUP_UNIQUE={
    ["monster order"]=true,["most tokens"]=true,
    ["ghost target"]=true,["pin options"]=true,
    ["pinned actions"]=true,["selected pinned features"]=true,
    ["smoother & faster"]=true,["more steal methods"]=true,
    ["steal from players"]=true,["easy setup"]=true,
    ["quick bar 1"]=true,["steal rarities"]=true,
    ["which mutations"]=true,["auto vacuum ghouler boss"]=true,
}
local function isVenyxPopup(screen)
    if not STATE.MainSeen then return false end
    local title=false
    local options=0
    local hint=false
    local shortName=string.lower(tostring(screen.Name or ""))
    local popupNamed=shortName:find("popup",1,true) or
        shortName:find("dropdown",1,true) or
        shortName:find("picker",1,true) or
        shortName:find("modal",1,true)
    for _,obj in ipairs(screen:GetDescendants()) do
        if isText(obj) then
            local ok,t=pcall(function()return obj.Text end)
            if ok and type(t)=="string" then
                local k=key(t:gsub("<[^>]+>",""))
                if POPUP_UNIQUE[k] then title=true end
                if k=="search" or k=="select all" or k=="select one option" or
                   k=="select an option" or k=="choose an option" or
                   k=="search options" or k=="options" then hint=true end
                if TH[k] and k~="venyx" and k~="chilli hub" then
                    options=options+1
                end
            end
            if obj:IsA("TextBox") then
                local okPH,p=pcall(function()return obj.PlaceholderText end)
                if okPH and type(p)=="string" then
                    local ph=key(p)
                    if ph:find("search",1,true) or
                       ph:find("ค้นหา",1,true) then hint=true end
                end
            end
        end
    end
    return (title and options>=2) or
        (popupNamed and options>=3 and hint)
end
local function checkScreen(gui)
    if not STATE.Running or not gui or not gui.Parent then return end
    if STATE.Roots[gui] then return end
    local ok, answer=pcall(isVenyxRoot,gui)
    if ok and answer then
        -- Real Venyx Home has a *Chilli Hub shortcut* in its own UI.
        -- This is NOT evidence the whole window belongs to Chilli.
        local chTab=false
        for _,item in ipairs(gui:GetDescendants()) do
            if isText(item) then
                local okText,t=pcall(function()return item.Text end)
                if okText and type(t)=="string" then
                    local k=key(t)
                    if k:find("chilli hub",1,true) then chTab=true end
                end
            end
        end
        local mixed=false
        if chTab then
            -- If Chilli is top-level, isolate a Venyx sub-window; do not
            -- recolor/translate the whole Chilli container by accident.
            local n=string.lower(tostring(gui.Name or ""))
            mixed=n:find("chilli",1,true)~=nil
        end
        if mixed then
            local sub=findVenyxSubwindow(gui)
            if sub then
                observeRoot(sub)
                STATE.MainSeen=true
            end
        else
            observeRoot(gui)
            STATE.MainSeen=true
        end
        return
    end
    -- Venyx may be embedded in the same ScreenGui as Chilli. The
    -- window has its own header and labels: translate JUST that frame.
    local okSub,sub=pcall(findVenyxSubwindow,gui)
    if okSub and sub and not STATE.Roots[sub] then
        observeRoot(sub)
        STATE.MainSeen=true
    end
    local okPanel,panel=pcall(findStandaloneStealPanel,gui)
    if okPanel and panel and not STATE.Roots[panel] then
        observeRoot(panel)
    end
    if not STATE.Roots[gui] then
        local okPopup,popup=pcall(isVenyxPopup,gui)
        if okPopup and popup then observeRoot(gui) end
    end
end
local function scheduleScreen(gui)
    if not STATE.Running or not gui or not gui.Parent or SCREEN_PENDING[gui] then return end
    SCREEN_PENDING[gui]=true
    task.delay(0.16,function()
        SCREEN_PENDING[gui]=nil
        if STATE.Running then pcall(checkScreen,gui) end
    end)
end
local function watchHost(host)
    if not host or HOST_WATCHED[host] or not STATE.Running then return end
    HOST_WATCHED[host]=true
    bind(host.DescendantAdded:Connect(function(obj)
        if not STATE.Running then return end
        if obj:IsA("ScreenGui") then
            scheduleScreen(obj)
        elseif isText(obj) then
            local gui=obj:FindFirstAncestorWhichIsA("ScreenGui")
            if gui and not STATE.Roots[gui] then scheduleScreen(gui) end
        end
    end))
end
local function armVenyxHosts()
    if not STATE.Running then return end
    for _,host in ipairs(containers()) do watchHost(host) end
end
armVenyxHosts()
-- After Venyx has appeared, a click can open a separate pop-up/dropdown
-- not attached under its ScreenGui. Recheck once on touch (debounced),
-- no endless timer and no scanning each frame.
local POPUP_TOUCH_PENDING=false
local okInput,UIS=pcall(function() return game:GetService("UserInputService") end)
if okInput and UIS then
    bind(UIS.InputEnded:Connect(function(input)
        if not STATE.MainSeen or not STATE.Running or POPUP_TOUCH_PENDING then return end
        if input.UserInputType~=Enum.UserInputType.Touch and
           input.UserInputType~=Enum.UserInputType.MouseButton1 then return end
        POPUP_TOUCH_PENDING=true
        task.delay(0.10,function()
            POPUP_TOUCH_PENDING=false
            if STATE.Running then pcall(STATE.Recheck) end
        end)
    end))
end
-- Only a handful of discovery checks during startup. This catches a GUI
-- that was already open before the translator ran, including gethui roots.
for _,s in ipairs({0.1,0.6,1.6,3.2,6.0}) do
    task.delay(s,function()
        if not STATE.Running then return end
        armVenyxHosts()
        pcall(STATE.Recheck)
    end)
end

-- Recheck on demand when Chilli opens Venyx and when a separate pop-up
-- is added by the remote UI. It is bounded and never runs per-frame.
function STATE.Recheck()
    if not STATE.Running then return end
    armVenyxHosts()
    for _,host in ipairs(containers()) do
        local ok,all=pcall(function() return host:GetDescendants() end)
        if ok then
            for _,obj in ipairs(all) do
                if obj:IsA("ScreenGui") then pcall(checkScreen,obj) end
            end
        end
    end
end


]===]

-- Start Venyx translation with its own isolated scope/state. If the user
-- already has Venyx UI open, it is translated in place, not reloaded.
do
    local old=ZIGZAG_HYBRID_ENV.__ZIGZAG_VENYX_THAI_STATE
    if not (ZIGZAG_HYBRID_ENV.__ZIGZAG_HYBRID_VENYX_ARMED==ZIGZAG_HYBRID_SESSION
        and old and old.Running) then
        local f,err=loadstring(ZIGZAG_HYBRID_VENYX_CORE)
        if f then
            local ok,reason=pcall(f)
            if ok then
                ZIGZAG_HYBRID_ENV.__ZIGZAG_HYBRID_VENYX_ARMED=ZIGZAG_HYBRID_SESSION
                print("✅ [ZIGZAG] Venyx THAI V1.9 armed inside Chilli")
            else
                warn("[ZIGZAG HYBRID] Venyx translator runtime:",reason)
            end
        else
            warn("[ZIGZAG HYBRID] Venyx translator syntax:",err)
        end
    end
end

local function ZIGZAG_HybridHasVenyx()
    -- Check for the ACTUAL Venyx main window, not the Chilli promotional tab.
    local roots={CoreGui,PlayerGui}
    if type(gethui)=="function" then
        local ok,hui=pcall(gethui)
        if ok and hui and hui~=CoreGui and hui~=PlayerGui then
            table.insert(roots,hui)
        end
    end
    for _,host in ipairs(roots) do
        local ok,items=pcall(function() return host:GetDescendants() end)
        if ok then
            for _,gui in ipairs(items) do
                if gui:IsA("ScreenGui") then
                    local n=string.lower(tostring(gui.Name or ""))
                    if n:find("venyx",1,true) then return true end
                    local title=false
                    local ident=false
                    local chilli=false
                    local proof=false
                    for _,obj in ipairs(gui:GetDescendants()) do
                        if IsTextObject(obj) then
                            local okText,t=pcall(function() return obj.Text end)
                            if okText and type(t)=="string" then
                                local lower=string.lower(CleanText(t))
                                if lower=="venyx" or
                                   lower:find("venyx / steal an egg",1,true) then title=true end
                                if lower=="steal an egg" or
                                   lower:find("venyx / steal an egg",1,true) or
                                   lower=="venyx discord" then ident=true end
                                if lower=="venyx discord" or lower=="copy invite" or
                                   lower=="unload hub" or lower=="go to egg" or
                                   lower=="delivery speed" or lower=="only these eggs" or
                                   lower=="auto claim index rewards" or
                                   lower=="monster order" then proof=true end
                                if lower=="chilli hub" or
                                   lower:find("chilli hub 🇹🇭",1,true) then chilli=true end
                            end
                        end
                    end
                    if title and ident and proof then return true end
                end
            end
        end
    end
    return false
end

local ZIGZAG_HybridLoadingVenyx=false
local function ZIGZAG_HybridLaunchVenyx()
    if ZIGZAG_HybridLoadingVenyx then return end
    if ZIGZAG_HYBRID_ENV.__ZIGZAG_HYBRID_VENYX_LAUNCH==ZIGZAG_HYBRID_SESSION then
        return
    end
    if ZIGZAG_HybridHasVenyx() then
        ZIGZAG_HYBRID_ENV.__ZIGZAG_HYBRID_VENYX_LAUNCH=ZIGZAG_HYBRID_SESSION
        return
    end
    ZIGZAG_HybridLoadingVenyx=true
    ZIGZAG_HYBRID_ENV.__ZIGZAG_HYBRID_VENYX_LAUNCH=ZIGZAG_HYBRID_SESSION
    task.spawn(function()
        local ok,err=pcall(function()
            local src=game:HttpGet(ZIGZAG_HYBRID_VENYX_SOURCE)
            local fn,compileError=loadstring(src)
            if type(fn)~="function" then error(compileError or "Venyx compile failed") end
            fn()
        end)
        ZIGZAG_HybridLoadingVenyx=false
        if not ok then
            ZIGZAG_HYBRID_ENV.__ZIGZAG_HYBRID_VENYX_LAUNCH=nil
            warn("[ZIGZAG HYBRID] เปิด Venyx ไม่สำเร็จ:",err)
        else
            -- Venyx opens asynchronously; a few bounded checks are safer
            -- than relying only on the time of a single popup creation.
            for _,waitSec in ipairs({0.3,1,2.5,5,8}) do
                task.delay(waitSec,function()
                    local state=ZIGZAG_HYBRID_ENV.__ZIGZAG_VENYX_THAI_STATE
                    if state and type(state.Recheck)=="function" then
                        pcall(state.Recheck)
                    end
                end)
            end
            print("✅ [ZIGZAG HYBRID] Venyx launched ONCE from Chilli; translator refresh armed")
        end
    end)
end

-- The native Chilli Venyx tab is a TextButton on some builds and a
-- Frame+TextLabel on mobile. Use ONE non-invasive touch listener for both.
-- DO NOT change its callback, color (native Venyx tab stays red), or layout.
local ZIGZAG_HybridVenyxTabs=setmetatable({}, {__mode="k"})
local function ZIGZAG_HybridTrackTab(obj)
    if not obj or not IsTextObject(obj) or not obj.Parent then return end
    if not MainChilliGui or not MainChilliGui.Parent or not obj:IsDescendantOf(MainChilliGui) then return end
    local ok,value=pcall(function() return obj.Text end)
    if not ok or type(value)~="string" or
       string.lower(CleanText(value))~="venyx" then return end
    ZIGZAG_HybridVenyxTabs[obj]=true
end
local ZIGZAG_HybridTabInput=Bind(UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType~=Enum.UserInputType.Touch and
       input.UserInputType~=Enum.UserInputType.MouseButton1 then return end
    if not MainChilliGui or not MainChilliGui.Parent then return end
    if MainChilliGui:IsA("ScreenGui") and not MainChilliGui.Enabled then return end
    local pos=input.Position
    for label in pairs(ZIGZAG_HybridVenyxTabs) do
        if label.Parent and label:IsDescendantOf(MainChilliGui) and
           IsGuiVisible(label) then
            local at,size=label.AbsolutePosition,label.AbsoluteSize
            if size.X>=24 and size.Y>=12 and
               pos.X>=at.X-4 and pos.X<=at.X+size.X+4 and
               pos.Y>=at.Y-4 and pos.Y<=at.Y+size.Y+4 then
                task.defer(ZIGZAG_HybridLaunchVenyx)
                -- Even when the *native* Chilli tab opens Venyx itself,
                -- refresh the translator after the tab/popup becomes visible.
                task.delay(0.5,function()
                    local state=ZIGZAG_HYBRID_ENV.__ZIGZAG_VENYX_THAI_STATE
                    if state and type(state.Recheck)=="function" then pcall(state.Recheck) end
                end)
                break
            end
        end
    end
end))

-- Startup tab recognition and event hooks; no per-frame/scan timer.
local ZIGZAG_HybridAddCredit
ZIGZAG_HybridAddCredit=function(gui)
    if not gui or not gui.Parent then return end
    if gui:FindFirstChild("ZIGZAG_CHILLI_TRANSLATION_CREDIT",true) then return end
    local host=nil
    for _,obj in ipairs(gui:GetDescendants()) do
        if IsChilliTitle(obj) then
            local current=obj.Parent
            while current and current~=gui do
                if current:IsA("GuiObject") and
                   current.AbsoluteSize.X>=350 and current.AbsoluteSize.Y>=200 then
                    host=current
                    break
                end
                current=current.Parent
            end
            break
        end
    end
    if not host then host=gui end
    local credit=Instance.new("TextLabel")
    credit.Name="ZIGZAG_CHILLI_TRANSLATION_CREDIT"
    credit.BackgroundTransparency=1
    credit.AnchorPoint=Vector2.new(1,1)
    credit.Position=UDim2.new(1,-10,1,-4)
    credit.Size=UDim2.fromOffset(176,17)
    credit.Text="✦ แปลไทยโดย ZIGZAG"
    credit.TextColor3=Color3.fromRGB(255,166,240)
    credit.TextSize=12
    credit.Font=Enum.Font.GothamBold
    credit.TextXAlignment=Enum.TextXAlignment.Right
    credit.TextStrokeTransparency=0.23
    credit.TextStrokeColor3=Color3.fromRGB(31,5,57)
    credit.ZIndex=1000
    credit.Active=false
    credit.Selectable=false
    credit.Parent=host
    table.insert(THEME_LOGOS,credit)
end
local function ZIGZAG_HybridRegisterChilli()
    if not MainChilliGui or not MainChilliGui.Parent then return end
    for _,obj in ipairs(MainChilliGui:GetDescendants()) do
        if IsTextObject(obj) then ZIGZAG_HybridTrackTab(obj) end
    end
    ZIGZAG_HybridAddCredit(MainChilliGui)
end

-- Hook into the existing Chilli tracking function WITHOUT replacing Chilli's
-- working translator/theme. This wrapper is scoped to this Lua chunk only.
local ZIGZAG_HybridOriginalTrackChilli=TrackChilli
TrackChilli=function(gui)
    ZIGZAG_HybridOriginalTrackChilli(gui)
    ZIGZAG_HybridRegisterChilli()
end
-- If Chilli was already present when this translator was armed, discover it.
if FindExistingChilli() then ZIGZAG_HybridRegisterChilli() end
Bind(PlayerGui.DescendantAdded:Connect(function(obj)
    if MainChilliGui and MainChilliGui.Parent and IsTextObject(obj) then
        task.defer(function()
            if obj.Parent then ZIGZAG_HybridTrackTab(obj) end
        end)
    end
end))
Bind(CoreGui.DescendantAdded:Connect(function(obj)
    if MainChilliGui and MainChilliGui.Parent and IsTextObject(obj) then
        task.defer(function()
            if obj.Parent then ZIGZAG_HybridTrackTab(obj) end
        end)
    end
end))

-- One combined-file shutdown also stops only the embedded Venyx translator.
local ZIGZAG_HybridPreviousDisconnect=STATE.Disconnect
function STATE.Disconnect()
    local v=ZIGZAG_HYBRID_ENV.__ZIGZAG_VENYX_THAI_STATE
    if v and type(v.Stop)=="function" then pcall(v.Stop) end
    ZIGZAG_HybridPreviousDisconnect()
end
print("✅ CHILLI + VENYX THAI ZIGZAG / single entry; click Chilli's Venyx tab")

--========================================================
-- 17A. ZIGZAG V1.8.0 — TELEPORT PERSISTENCE (THAI/THEME ONLY)
-- Intentionally queue ONLY the UI translator+purple theme, never a second
-- Chilli gameplay loader. The original source continues to run once below.
-- This avoids the prior repeated character blink after server hopping.
--========================================================
do
    local ZIGZAG_BOOT_TEMPLATE = [====[--========================================================
-- ZIGZAG CHILLI + VENYX V1.8.7 / TELEPORT TRANSLATOR-ONLY CONTINUATION
-- Always re-arm before running the queued translator to support multi-hop.
-- Does NOT call the upstream Chilli gameplay loader.
--========================================================
local ZIGZAG_TRANSLATOR_SOURCE = %q
local ZIGZAG_BOOT_TEMPLATE = %q
local ZIGZAG_ENV = (type(getgenv)=="function" and getgenv()) or _G
local ZIGZAG_ACTIVE = ZIGZAG_ENV.__ZIGZAG_CHILLI_STATE
local ZIGZAG_JOB = tostring(game.JobId or "")
if ZIGZAG_ACTIVE and ZIGZAG_ACTIVE.Release=="CHILLI_VENYX_ZIGZAG_V1.8.7_POPUP_AUTO_SELL"
    and ZIGZAG_ACTIVE.JobId==ZIGZAG_JOB and ZIGZAG_ACTIVE.Live then
    return
end
local function ZIGZAG_GET_QUEUE()
    if type(queue_on_teleport)=="function" then return queue_on_teleport end
    if type(queueonteleport)=="function" then return queueonteleport end
    if type(syn)=="table" and type(syn.queue_on_teleport)=="function" then
        return syn.queue_on_teleport
    end
    if type(fluxus)=="table" and type(fluxus.queue_on_teleport)=="function" then
        return fluxus.queue_on_teleport
    end
    if type(ZIGZAG_ENV.queue_on_teleport)=="function" then
        return ZIGZAG_ENV.queue_on_teleport
    end
    return nil
end
local q=ZIGZAG_GET_QUEUE()
if q then
    local continuation=string.format(ZIGZAG_BOOT_TEMPLATE,
        ZIGZAG_TRANSLATOR_SOURCE,ZIGZAG_BOOT_TEMPLATE)
    local ok,err=pcall(q,continuation)
    if not ok and type(writefile)=="function" and type(readfile)=="function" then
        -- Some mobile executors impose a small queue text limit. Save the
        -- same bootstrap locally and queue a tiny reader instead, if possible.
        local path="ZIGZAG_CHILLI_V187_POPUP_AUTO_SELL_TP_CACHE.lua"
        local saved=pcall(writefile,path,continuation)
        if saved then
            local tiny='local f=readfile("ZIGZAG_CHILLI_V187_POPUP_AUTO_SELL_TP_CACHE.lua"); local r=loadstring(f); if r then r() end'
            ok,err=pcall(q,tiny)
        end
    end
    if not ok then warn("[ZIGZAG TP] Requeue failed; use Auto Execute:",err) end
else
    warn("[ZIGZAG TP] Executor lacks teleport queue. Enable Auto Execute for this release.")
end
-- The queued continuation might run before the destination game is loaded.
local okLoaded,loaded=pcall(function() return game:IsLoaded() end)
if okLoaded and not loaded then
    pcall(function() game.Loaded:Wait() end)
end
local players=game:GetService("Players")
if not players.LocalPlayer then
    for i=1,30 do
        if players.LocalPlayer then break end
        task.wait(0.15)
    end
end
if not players.LocalPlayer then
    warn("[ZIGZAG TP] LocalPlayer not available; wait for Auto Execute or rerun")
    return
end
local runner,err=loadstring(ZIGZAG_TRANSLATOR_SOURCE)
if not runner then
    warn("[ZIGZAG TP] Thai/theme source compile failed:",err)
    return
end
local ok,reason=pcall(runner)
if not ok then warn("[ZIGZAG TP] Thai/theme source failed:",reason) end
]====]
    local ZIGZAG_TRANSLATOR_SOURCE = [====[--========================================================
-- CHILLI + VENYX THAI - ZIGZAG V1.8.7 AUTO STEAL SELL MUTATION VENYX POPUP TELEPORT SAFE FULL MERGED
-- DIRECT SOURCE / ONE BLOCK / ANTI-FLICKER / LOW-LAG
-- V1.6 BASE / DR. SCRAMBLE SCROLL GUARD / DYNAMIC PURPLE BORDERS (2026-10-09)
-- Original translator/source preserved; visual theme never changes .Text
-- Halloween mappings / verified V1.7.9 sidebar styling retained
--========================================================

local ENV = (type(getgenv) == "function" and getgenv()) or _G
local ZIGZAG_RELEASE = "CHILLI_VENYX_ZIGZAG_V1.8.7_POPUP_AUTO_SELL"
local ZIGZAG_JOB = tostring(game.JobId or "")
local OLD = ENV.__ZIGZAG_CHILLI_STATE
-- If executor Auto Execute and a teleport queue both fire, keep the already
-- running version instead of tearing down/repainting the GUI (no flicker).
if OLD and OLD.Release == ZIGZAG_RELEASE
    and OLD.JobId == ZIGZAG_JOB and OLD.Live then
    return
end
if OLD and type(OLD.Disconnect) == "function" then pcall(OLD.Disconnect) end
local STATE = {Connections={},Release=ZIGZAG_RELEASE,JobId=ZIGZAG_JOB,Live=true,Mode="translator_only"}
local function Bind(connection)
    if connection then table.insert(STATE.Connections, connection) end
    return connection
end
function STATE.Disconnect()
    STATE.Live = false
    for _,connection in ipairs(STATE.Connections) do
        pcall(function() connection:Disconnect() end)
    end
    table.clear(STATE.Connections)
end
ENV.__ZIGZAG_CHILLI_STATE = STATE

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local SOURCE_URL = "https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"

-- Full translations from ZIGZAG V1.3; preserved without removing keys
local TRANSLATIONS = {
    ["Chilli Hub"] = "Chilli Hub 🇹🇭 • ZIGZAG",
    ["Farm"] = "ฟาร์ม",
    ["Player"] = "ตัวละคร",
    ["Character"] = "ตัวละคร",
    ["Predictor"] = "คาดการณ์",
    ["Progress"] = "ความคืบหน้า",
    ["Egg Finder"] = "ค้นหาไข่",
    ["Server"] = "เซิร์ฟเวอร์",
    ["Misc"] = "อื่นๆ",
    ["Webhook"] = "เว็บฮุก",
    ["Discord"] = "ดิสคอร์ด",
    ["Quick & Keys"] = "คีย์ลัด",
    ["Settings"] = "การตั้งค่า",
    ["Config"] = "คอนฟิก",
    ["WARNING"] = "คำเตือน",
    ["Credits"] = "เครดิต",
    ["Version"] = "เวอร์ชัน",
    ["Games Supported"] = "เกมที่รองรับ",
    ["Game"] = "ข้อมูลเกม",
    ["System"] = "ระบบ",
    ["Automation"] = "ระบบอัตโนมัติ",
    ["Inventory"] = "คลังของ",
    ["Theme"] = "ธีม",
    ["Filters"] = "ตัวกรอง",
    ["Filter"] = "ตัวกรอง",
    ["Actions"] = "คำสั่ง",
    ["Visuals"] = "การแสดงผล",
    ["Visual"] = "การแสดงผล",
    ["Intel"] = "ข้อมูลเซิร์ฟเวอร์",
    ["Toggle"] = "เปิด/ปิด",
    ["Lock"] = "ล็อก",
    ["Off"] = "ปิด",
    ["On"] = "เปิด",
    ["None"] = "ไม่มี",
    ["All"] = "ทั้งหมด",
    ["Any"] = "ทุกระดับ",
    ["Any Size"] = "ทุกขนาด",
    ["Select..."] = "เลือก...",
    ["Search"] = "ค้นหา",
    ["Search..."] = "ค้นหา...",
    ["Filter features..."] = "ค้นหาฟีเจอร์...",
    ["Idle"] = "ว่าง",
    ["Default"] = "ค่าเริ่มต้น",
    ["Status"] = "สถานะ",
    ["Priority"] = "ลำดับความสำคัญ",
    ["Value"] = "มูลค่า",
    ["Size"] = "ขนาด",
    ["Rarity"] = "ความหายาก",
    ["Mutation"] = "การกลายพันธุ์",
    ["Area"] = "พื้นที่",
    ["Areas"] = "พื้นที่",
    ["Sell"] = "ขาย",
    ["Favorite"] = "ถูกใจ",
    ["Unfavorite"] = "เลิกถูกใจ",
    ["Hop"] = "ย้าย",
    ["Join"] = "เข้า",
    ["Copy"] = "คัดลอก",
    ["Rejoin"] = "เข้าใหม่",
    ["Add"] = "เพิ่ม",
    ["Reset"] = "รีเซ็ต",
    ["Turn Off"] = "ปิดทั้งหมด",
    ["Save"] = "บันทึก",
    ["Import"] = "นำเข้า",
    ["Steal"] = "ขโมย",
    ["Steal Panel"] = "แผงขโมย",
    ["Basic"] = "พื้นฐาน",
    ["Common"] = "ธรรมดา",
    ["Uncommon"] = "ไม่ธรรมดา",
    ["Rare"] = "แรร์",
    ["SuperRare"] = "ซูเปอร์แรร์",
    ["Epic"] = "อีพิก",
    ["Legendary"] = "เลเจนดารี",
    ["Mythic"] = "มิธิค",
    ["Mythical"] = "มิธิค",
    ["Cosmic"] = "คอสมิก",
    ["Celestial"] = "เซเลสเชียล",
    ["Divine"] = "ดีไวน์",
    ["Superior"] = "ซูพีเรียร์",
    ["Eternal"] = "อีเทอร์นัล",
    ["Secret"] = "ซีเคร็ต",
    ["Limited"] = "ลิมิเต็ด",
    ["Exclusive"] = "เอ็กซ์คลูซีฟ",
    ["Exotic"] = "เอ็กโซติก",
    ["Titan"] = "ไททัน",
    ["Rainbow"] = "เรนโบว์",
    ["Movement"] = "การเคลื่อนที่",
    ["Speed Boost"] = "เพิ่มความเร็ว",
    ["Boost Speed"] = "ระดับความเร็ว",
    ["Anti AFK"] = "กันหลุด (Anti AFK)",
    ["Anti-AFK"] = "กันหลุด (Anti AFK)",
    ["Anti Guard"] = "ป้องกันยาม",
    ["Anti Guard Panel"] = "แผงป้องกันยาม",
    ["Anti Die"] = "ป้องกันตาย",
    ["Anti Ragdoll"] = "กันล้ม / กันกระเด็น",
    ["Anti Trap"] = "หลบกับดัก",
    ["Anti Hit"] = "ป้องกันการโจมตี",
    ["Anti Knockback"] = "กันกระเด็น",
    ["God Mode"] = "โหมดป้องกัน",
    ["GodMode"] = "โหมดป้องกัน",
    ["Invisibility"] = "ล่องหน",
    ["Makes you invisible to other players"] = "ทำให้ผู้เล่นอื่นมองไม่เห็นคุณ",
    ["No Animations"] = "ปิดแอนิเมชัน",
    ["NoClip"] = "เดินทะลุสิ่งกีดขวาง",
    ["Infinite Jump"] = "กระโดดไม่จำกัด",
    ["Fly"] = "บิน",
    ["Fly Up"] = "บินขึ้น",
    ["Fly Down"] = "บินลง",
    ["Fly Up (hold)"] = "บินขึ้น (กดค้าง)",
    ["Fly Down (hold)"] = "บินลง (กดค้าง)",
    ["Fly Speed"] = "ความเร็วบิน",
    ["Walk Speed"] = "ความเร็วเดิน",
    ["Jump Power"] = "พลังการกระโดด",
    ["Traps from other players cannot catch you"] = "กับดักของผู้เล่นอื่นจะจับคุณไม่ได้",
    ["Instant Prompts"] = "โต้ตอบทันที",
    ["Combat"] = "การต่อสู้",
    ["Auto Hit Nearest Player"] = "ออโต้ตีผู้เล่นที่ใกล้สุด",
    ["Auto Hit Egg Holders"] = "ออโต้ตีผู้เล่นที่ถือไข่",
    ["Auto Hit Specific Player"] = "ออโต้ตีผู้เล่นที่เลือก",
    ["Hit Player"] = "เลือกผู้เล่นที่จะตี",
    ["Hit Aura"] = "ตีรอบตัว",
    ["Hit Tween Speed"] = "ความเร็ววาร์ปตอนตี",
    ["Hit Max Speed"] = "ความเร็วสูงสุดตอนตี",
    ["Chase Settings"] = "ตั้งค่าการไล่ตาม",
    ["Hit Lead"] = "ระยะนำเป้าหมาย",
    ["Stand further ahead of the target (+) or closer to them (-)"] = "ยืนล้ำหน้าเป้าหมาย (+) หรือเข้าใกล้เป้าหมาย (-)",
    ["Hit Sweep"] = "ระยะกวาดตอนตี",
    ["How far you move back and forth in front of the target"] = "ระยะที่เคลื่อนที่ไป-กลับด้านหน้าเป้าหมาย",
    ["Add/Remove Hits On Quick Bar 2"] = "เพิ่ม/ลบเมนูตีในแถบด่วน 2",
    ["Pin or unpin the hit toggles on Quick Bar 2"] = "เพิ่มหรือลบสวิตช์ตีออกจากแถบด่วน 2",
    ["Performance"] = "ประสิทธิภาพ",
    ["FPS Boost"] = "เพิ่ม FPS",
    ["Ultra FPS Boost"] = "เพิ่ม FPS สูงสุด",
    ["Disable 3D Render"] = "ปิดการเรนเดอร์ 3D",
    ["Disable 3D Rendering"] = "ปิดการเรนเดอร์ 3D",
    ["Farm HUD"] = "แผง HUD ฟาร์ม",
    ["Drag any panel to place it where you like"] = "ลากแผงไปวางตรงตำแหน่งที่ต้องการได้",
    ["Hide Game UI"] = "ซ่อน UI ของเกม",
    ["Showcase Cards"] = "แสดงการ์ดข้อมูล",
    ["HUD Size"] = "ขนาด HUD",
    ["Black Screen"] = "จอดำ",
    ["Low Graphics"] = "กราฟิกต่ำ",
    ["Limit FPS"] = "จำกัด FPS",
    ["FPS Cap"] = "จำกัด FPS",
    ["Show FPS and Ping"] = "แสดง FPS และ Ping",
    ["FPS and Ping"] = "แสดง FPS และ Ping",
    ["FPS and Ping Size"] = "ขนาด FPS และ Ping",
    ["Optimizer"] = "ตัวปรับประสิทธิภาพ",
    ["Server Hop"] = "ย้ายเซิร์ฟเวอร์",
    ["Auto Server Hop"] = "ย้ายเซิร์ฟเวอร์อัตโนมัติ",
    ["Auto Hop"] = "ออโต้ย้ายเซิร์ฟเวอร์",
    ["Hop Mode"] = "โหมดย้ายเซิร์ฟเวอร์",
    ["Server Hop Mode"] = "โหมดย้ายเซิร์ฟเวอร์",
    ["Most Players"] = "คนเยอะสุด",
    ["Least Players"] = "คนน้อยสุด",
    ["Random"] = "สุ่ม",
    ["Rejoin Server"] = "เข้าเซิร์ฟเวอร์เดิมอีกครั้ง",
    ["Boss Server Hop"] = "ย้ายเซิร์ฟเวอร์หาบอส",
    ["Keep Hopping For"] = "ย้ายเซิร์ฟต่อเพื่อค้นหา",
    ["Joins new servers to find eggs that match the filters below"] = "เข้าเซิร์ฟเวอร์ใหม่เพื่อหาไข่ที่ตรงกับตัวกรองด้านล่าง",
    ["Turn on Auto Hop to start hunting"] = "เปิดออโต้ย้ายเซิร์ฟเวอร์เพื่อเริ่มค้นหาไข่",
    ["When to move on to the next server"] = "กำหนดว่าจะย้ายไปเซิร์ฟเวอร์ถัดไปเมื่อใด",
    ["Until An Egg Matches"] = "จนกว่าจะเจอไข่ตรงเงื่อนไข",
    ["Steal Then Hop"] = "ขโมยแล้วค่อยย้ายเซิร์ฟ",
    ["After A Rare Spawns"] = "เมื่อไข่แรร์เกิดแล้ว",
    ["Rarity To Wait For"] = "ระดับความหายากที่ต้องรอ",
    ["For After A Rare Spawns: this rarity or higher"] = "สำหรับโหมดรอไข่แรร์: รอระดับนี้หรือสูงกว่า",
    ["Sync With Auto Steal Filters"] = "ใช้ตัวกรองเดียวกับออโต้ขโมย",
    ["Changing a filter here also changes it in Auto Steal, and back"] = "เปลี่ยนตัวกรองตรงนี้จะเปลี่ยนในออโต้ขโมยด้วย",
    ["Find eggs of the chosen rarity and every rarity above it"] = "ค้นหาไข่ระดับที่เลือกและทุกระดับที่สูงกว่า",
    ["Only look for these eggs (empty = all)"] = "ค้นหาเฉพาะไข่เหล่านี้ (เว้นว่าง = ทั้งหมด)",
    ["Min Value To Find"] = "มูลค่าขั้นต่ำที่จะค้นหา",
    ["Skip eggs worth less than this. Drag or type 250k, 50m, 1.5b"] = "ข้ามไข่ที่มูลค่าต่ำกว่านี้ เช่น 250k, 50m, 1.5b",
    ["First Hop Delay"] = "หน่วงเวลาก่อนย้ายเซิร์ฟครั้งแรก",
    ["Wait after the script loads before the first hop"] = "รอหลังสคริปต์โหลดก่อนย้ายเซิร์ฟครั้งแรก",
    ["Auto Load Script"] = "โหลดสคริปต์อัตโนมัติ",
    ["Job ID"] = "Job ID",
    ["Paste a server Job ID..."] = "วาง Job ID ของเซิร์ฟเวอร์...",
    ["Join Job ID"] = "เข้าเซิร์ฟเวอร์ตาม Job ID",
    ["Copy Current Job ID"] = "คัดลอก Job ID ปัจจุบัน",
    ["Auto Rejoin When Disconnect"] = "เข้าเซิร์ฟเวอร์ใหม่อัตโนมัติเมื่อหลุด",
    ["Auto Steal"] = "ออโต้ขโมย",
    ["Auto Steal Egg"] = "ขโมยไข่อัตโนมัติ",
    ["Auto Steal Eggs"] = "ขโมยไข่อัตโนมัติ",
    ["Instant Steal"] = "ขโมยทันที",
    ["Instant Steal Steps"] = "จำนวนขั้นตอนขโมยทันที",
    ["Target Areas"] = "พื้นที่เป้าหมาย",
    ["Min Rarity"] = "ความหายากขั้นต่ำ",
    ["Min Steal Value"] = "มูลค่าขั้นต่ำที่จะขโมย",
    ["Min Value To Steal"] = "มูลค่าขั้นต่ำที่จะขโมย",
    ["Target Specific Eggs"] = "ขโมยเฉพาะไข่ที่เลือก",
    ["Steal Missing Lab Eggs"] = "ขโมยไข่แล็บที่ยังไม่มี",
    ["Steal Missing Index Eggs"] = "ขโมยไข่ในสมุดที่ยังไม่มี",
    ["Skip Owned Lab Eggs"] = "ข้ามไข่แล็บที่มีอยู่แล้ว",
    ["Steal Priority"] = "ลำดับความสำคัญขโมย",
    ["Stock Per Egg"] = "จำนวนสำรองต่อไข่",
    ["Carry Speed"] = "ความเร็วขณะถือไข่",
    ["Tween Speed"] = "ความเร็วการวาร์ป (Tween)",
    ["Steal Glide Speed"] = "ความเร็ว Glide ตอนขโมย",
    ["Auto Return to Base"] = "กลับฐานอัตโนมัติ",
    ["Avoid Rifts"] = "หลีกเลี่ยง Rift",
    ["Auto Place Egg"] = "ออโต้วางไข่",
    ["Auto Place Eggs"] = "ออโต้วางไข่",
    ["Auto Place Selected"] = "ออโต้วางไข่ที่เลือก",
    ["Auto Place Carried Egg"] = "ออโต้วางไข่ที่ถืออยู่",
    ["Min Place Value"] = "มูลค่าขั้นต่ำที่จะวาง",
    ["Place Egg Rule"] = "กฎการวางไข่",
    ["Place Rule"] = "กฎการวางไข่",
    ["Placement Rule"] = "กฎการวางไข่",
    ["Place Egg Order"] = "ลำดับการวางไข่",
    ["Place Egg Priority"] = "ลำดับความสำคัญการวางไข่",
    ["Place Rarities"] = "ระดับที่จะวางไข่",
    ["Place Specific Eggs"] = "วางเฉพาะไข่ที่กำหนด",
    ["Always"] = "ตลอดเวลา",
    ["Steal Idle"] = "ช่วงไม่ได้ขโมย",
    ["After Steal"] = "หลังขโมย",
    ["Night Only"] = "เฉพาะกลางคืน",
    ["Auto Hatch"] = "ออโต้ฟักไข่",
    ["Auto Hatch Egg"] = "ออโต้ฟักไข่",
    ["Auto Hatch Eggs"] = "ออโต้ฟักไข่",
    ["Auto Hatch & Equip"] = "ออโต้ฟักไข่และสวมใส่",
    ["Hatch Min Rarity"] = "ความหายากขั้นต่ำที่จะฟัก",
    ["Hatch eggs of the chosen rarity and every rarity above it"] = "ฟักไข่ระดับที่เลือก และทุกระดับที่สูงกว่า",
    ["Hatch Min Value"] = "มูลค่าขั้นต่ำที่จะฟัก",
    ["Minimum Hatch Value"] = "มูลค่าขั้นต่ำที่จะฟัก",
    ["Hatch Specific Egg"] = "ฟักเฉพาะไข่ที่เลือก",
    ["Hatch Specific Eggs"] = "ฟักเฉพาะไข่ที่เลือก",
    ["Only hatch these eggs (empty = all)"] = "ฟักเฉพาะไข่เหล่านี้ (เว้นว่าง = ทั้งหมด)",
    ["Auto Equip Best"] = "ออโต้ใส่ตัวที่ดีที่สุด",
    ["Auto Equip Best Pets"] = "ออโต้ใส่สัตว์เลี้ยงที่ดีที่สุด",
    ["Auto Equip Best Gear"] = "ออโต้ใส่อุปกรณ์ดีที่สุด",
    ["Auto Equip Best Trail"] = "ออโต้ใส่ Trail ที่ดีที่สุด",
    ["Equip Best"] = "ใส่ตัวที่ดีที่สุด",
    ["Switch to a better pet immediately when available"] = "เปลี่ยนไปใช้สัตว์เลี้ยงที่ดีกว่าทันทีเมื่อมี",
    ["Auto Treadmill"] = "ออโต้ลู่วิ่ง",
    ["Auto Treadmill Upgrade"] = "อัปเกรดลู่วิ่งอัตโนมัติ",
    ["Auto Upgrade Treadmill"] = "อัปเกรดลู่วิ่งอัตโนมัติ",
    ["AFK Treadmill"] = "ใช้ลู่วิ่งขณะ AFK",
    ["Treadmill Between Steals"] = "ใช้ลู่วิ่งระหว่างรอขโมย",
    ["Stay On Treadmill"] = "อยู่บนลู่วิ่งตลอดเวลา",
    ["Automatically upgrade treadmill when money is available"] = "อัปเกรดลู่วิ่งอัตโนมัติเมื่อมีเงินพอ",
    ["Auto Sell"] = "ออโต้ขาย",
    ["Auto Sell Egg"] = "ออโต้ขายไข่",
    ["Auto Sell Eggs"] = "ขายไข่อัตโนมัติ",
    ["Auto Sell Pet"] = "ออโต้ขายสัตว์เลี้ยง",
    ["Auto Sell Pets"] = "ขายสัตว์เลี้ยงอัตโนมัติ",
    ["Sell Eggs Now"] = "ขายไข่ตอนนี้",
    ["Sell Pets Now"] = "ขายสัตว์เลี้ยงตอนนี้",
    ["Pet Sell Value"] = "มูลค่าสัตว์เลี้ยงที่จะขาย",
    ["Egg Sell Value"] = "มูลค่าไข่ที่จะขาย",
    ["Never Sell Mutated"] = "ห้ามขายตัวที่กลายพันธุ์",
    ["Never Sell Equipped"] = "ห้ามขายตัวที่กำลังใช้งาน",
    ["Sell Pet Rule"] = "กฎการขายสัตว์เลี้ยง",
    ["Which checks must pass to sell"] = "เลือกเงื่อนไขที่ต้องผ่านก่อนขาย",
    ["Rarity Only"] = "เฉพาะความหายาก",
    ["Value Only"] = "เฉพาะมูลค่า",
    ["Rarity Or Value"] = "ความหายากหรือมูลค่า",
    ["Pet Max Rarity"] = "ความหายากสูงสุดของสัตว์เลี้ยง",
    ["Sell pets at or below this rarity"] = "ขายสัตว์เลี้ยงระดับนี้หรือต่ำกว่า",
    ["Sell pets worth less than this (0 = off)"] = "ขายสัตว์เลี้ยงที่มูลค่าต่ำกว่านี้ (0 = ปิด)",
    ["Keep Mutated Pets"] = "เก็บสัตว์เลี้ยงกลายพันธุ์ไว้",
    ["Never sell mutated pets"] = "ห้ามขายสัตว์เลี้ยงที่กลายพันธุ์",
    ["Blacklist Sell Pets"] = "สัตว์เลี้ยงห้ามขาย",
    ["These pets are never sold"] = "สัตว์เลี้ยงเหล่านี้จะไม่ถูกขาย",
    ["Auto Sell Lab Egg"] = "ออโต้ขายไข่แล็บ",
    ["Sell eggs traded from Dr Scramble that match the filters below"] = "ขายไข่ที่ได้จาก Dr. Scramble ตามเงื่อนไขด้านล่าง",
    ["Sell Lab Eggs Now"] = "ขายไข่แล็บตอนนี้",
    ["Sell matching Lab eggs once"] = "ขายไข่แล็บที่ตรงเงื่อนไข 1 ครั้ง",
    ["Lab Egg Rule"] = "กฎการขายไข่แล็บ",
    ["Rarity And Value"] = "ความแรร์และมูลค่า",
    ["Lab Egg Max Rarity"] = "ความแรร์สูงสุดของไข่แล็บที่จะขาย",
    ["Sell Lab eggs at or below this rarity (Off = none by rarity)"] = "ขายไข่แล็บระดับนี้หรือต่ำกว่า (ปิด = ไม่กรองความแรร์)",
    ["Lab Egg Sell Value"] = "มูลค่าไข่แล็บที่จะขาย",
    ["Sell Lab eggs worth less than this (0 = off)"] = "ขายไข่แล็บที่มูลค่าต่ำกว่านี้ (0 = ปิด)",
    ["Keep Mutated Lab Eggs"] = "เก็บไข่แล็บที่กลายพันธุ์ไว้",
    ["Never sell mutated Lab eggs"] = "ห้ามขายไข่แล็บที่กลายพันธุ์",
    ["Keep Lab Pets"] = "เก็บสัตว์เลี้ยงแล็บเหล่านี้ไว้",
    ["Lab eggs of these pets are never sold"] = "ไข่แล็บของสัตว์เหล่านี้จะไม่ถูกขาย",
    ["Auto Place Lab Reward Eggs"] = "ออโต้วางไข่รางวัลจากแล็บ",
    ["Dr. Scramble"] = "Dr. Scramble",
    ["Dr Scramble"] = "Dr. Scramble",
    ["Dr Scramble Event"] = "กิจกรรม Dr. Scramble",
    ["Dr Scramble Lab & Mech"] = "ห้องแล็บ Dr. Scramble & หุ่นรบ",
    ["Dr. Scramble Lab & Mech"] = "ห้องแล็บ Dr. Scramble & หุ่นรบ",
    ["Auto Mech Boss"] = "ออโต้ตีบอสหุ่นรบ",
    ["Mech Tween Speed"] = "ความเร็วบินไปตีหุ่นรบ",
    ["Main Weapon Hold"] = "เวลากดอาวุธหลัก",
    ["Scrambler Hold"] = "เวลากด Scrambler",
    ["Swap Two Weapons"] = "สลับอาวุธ 2 ชิ้น",
    ["Auto Claim Mastery"] = "ออโต้รับรางวัล Mastery",
    ["Auto Use Scrambled"] = "ออโต้ใช้ Scrambled",
    ["Auto Use Scrambled Mutation"] = "ออโต้ใช้ Scrambled",
    ["Auto Buy Scrambled"] = "ออโต้ซื้อ Scrambled",
    ["Auto Buy Scramble Shop"] = "ออโต้ซื้อของร้าน Scramble",
    ["Auto Buy Offers"] = "ซื้อของร้าน Scramble อัตโนมัติ",
    ["Auto Collect Drops"] = "เก็บของดรอปอัตโนมัติ",
    ["Teleport To Drops"] = "วาร์ปไปหาของดรอป",
    ["Auto Farm Drones"] = "ฟาร์มโดรนอัตโนมัติ",
    ["Drone Priority"] = "ลำดับเป้าหมายโดรน",
    ["Movement Speed"] = "ความเร็วการเคลื่อนที่",
    ["Auto Laboratory Trade-In"] = "แลกของในห้องทดลองอัตโนมัติ",
    ["Auto Lab Trade-In"] = "ออโต้แลกของในแล็บ",
    ["Collect Laboratory Rewards"] = "รับรางวัลห้องทดลอง",
    ["Auto Claim Lab Rewards"] = "ออโต้รับรางวัลจากแล็บ",
    ["Auto Reroll Lab Recipe"] = "ออโต้สุ่มสูตรแล็บใหม่",
    ["Maximum Trade Rarity"] = "ความแรร์สูงสุดที่ยอมแลก",
    ["Wanted Offers"] = "ของที่ต้องการซื้อ",
    ["Attack Boss"] = "โจมตีบอส",
    ["Dodge Attacks"] = "หลบการโจมตี",
    ["Enter Arena When Live"] = "เข้าสนามเมื่อบอสเริ่ม",
    ["Biohazard Pets"] = "สัตว์ Biohazard",
    ["Experimental Pets"] = "สัตว์ทดลอง",
    ["Unstable DNA"] = "DNA ไม่เสถียร",
    ["Lab Banner"] = "ป้ายแบนเนอร์แล็บ",
    ["Lab Banners"] = "ป้ายแบนเนอร์แล็บ",
    ["Scramble Shop"] = "ร้าน Scramble",
    ["Scramble Shop Items"] = "ไอเทมในร้าน Scramble",
    ["Items to Buy"] = "ไอเทมที่จะซื้อในร้าน",
    ["Items To Buy"] = "ไอเทมที่จะซื้อในร้าน",
    ["Keep Samples"] = "สำรอง Samples ไว้",
    ["Reserve Samples"] = "สำรอง Samples ไว้",
    ["Samples Reserve"] = "จำนวน Samples สำรอง",
    ["Minimum Mutation Rarity"] = "ระดับไข่กลายพันธุ์ขั้นต่ำ",
    ["Mutation Egg Min Rarity"] = "ระดับไข่กลายพันธุ์ขั้นต่ำ",
    ["Mutation Min Rarity"] = "ระดับไข่กลายพันธุ์ขั้นต่ำ",
    ["Min Mutation Value"] = "มูลค่าขั้นต่ำการกลายพันธุ์",
    ["Mutation Min Value"] = "มูลค่าขั้นต่ำการกลายพันธุ์",
    ["Mutation Priority"] = "ลำดับความสำคัญกลายพันธุ์",
    ["Mutation Target Eggs"] = "เป้าหมายไข่กลายพันธุ์",
    ["2x Cash Booster"] = "บูสต์เงิน x2",
    ["1.25x Speed"] = "ความเร็ว x1.25",
    ["2x Treadmill Booster"] = "บูสต์ลู่วิ่ง x2",
    ["Auto Fuse Machine"] = "ออโต้เครื่องผสมสัตว์",
    ["Fuse 3 same pets into an egg, nonstop"] = "ผสมสัตว์เลี้ยงชนิดเดียวกัน 3 ตัวเป็นไข่แบบต่อเนื่อง",
    ["Fuse Priority Mode"] = "โหมดลำดับการผสม",
    ["Lowest Rarity First"] = "ความหายากต่ำสุดก่อน",
    ["Highest Rarity First"] = "ความหายากสูงสุดก่อน",
    ["Most Copies First"] = "จำนวนตัวซ้ำมากสุดก่อน",
    ["Lowest Value First"] = "มูลค่าต่ำสุดก่อน",
    ["Pets To Use"] = "สัตว์เลี้ยงที่จะใช้",
    ["Lowest To Highest"] = "ต่ำไปสูง",
    ["Highest To Lowest"] = "สูงไปต่ำ",
    ["Max Rarity to Fuse"] = "ความหายากสูงสุดที่จะผสม",
    ["Specific Species to Fuse"] = "ระบุสายพันธุ์ที่จะผสม",
    ["Only fuse these species (empty = all)"] = "ผสมเฉพาะสายพันธุ์เหล่านี้ (เว้นว่าง = ทั้งหมด)",
    ["Skip Mutated Pets"] = "ข้ามสัตว์เลี้ยงกลายพันธุ์",
    ["Eject Incomplete Slots"] = "เอาสัตว์ที่จัดชุดไม่ได้ออก",
    ["Take out pets that can't make a set"] = "นำสัตว์เลี้ยงที่จัดเป็นชุดไม่ได้ออก",
    ["Butterfly Bloom"] = "ผีเสื้อผลิบาน",
    ["Auto Butterfly Bloom"] = "ออโต้ Butterfly Bloom",
    ["Catch Mode"] = "โหมดจับผีเสื้อ",
    ["Stand"] = "ยืนรอ",
    ["Chase"] = "ไล่จับ",
    ["Circle"] = "วนเป็นวง",
    ["Patrol"] = "ลาดตระเวน",
    ["Catch Priority"] = "ลำดับการจับ",
    ["Only for Chase mode"] = "ใช้เฉพาะโหมดไล่จับ",
    ["Rarest"] = "หายากสุดก่อน",
    ["Closest"] = "ใกล้สุดก่อน",
    ["Nearest"] = "ใกล้สุดก่อน",
    ["Catch Butterflies"] = "จับผีเสื้อ",
    ["Radiant Butterfly"] = "ผีเสื้อ Radiant",
    ["Amethyst Butterfly"] = "ผีเสื้อ Amethyst",
    ["Sapphire Butterfly"] = "ผีเสื้อ Sapphire",
    ["Emerald Butterfly"] = "ผีเสื้อ Emerald",
    ["Wisp"] = "ภูตแสง (Wisp)",
    ["Wisp Companion"] = "คู่หู Wisp",
    ["Auto Wisp"] = "ออโต้ Wisp",
    ["Auto Wisp Quests"] = "ออโต้ภารกิจ Wisp",
    ["Steal Wisp Quest Eggs"] = "ขโมยไข่ภารกิจ Wisp",
    ["Butterflies"] = "ผีเสื้อ",
    ["Auto Claim Net"] = "ออโต้รับตาข่าย",
    ["Auto Catch Butterflies"] = "ออโต้จับผีเสื้อ",
    ["Auto Banjo Cricket"] = "ออโต้ Banjo Cricket",
    ["Banjo Cricket"] = "Banjo Cricket",
    ["Auto Trade Up"] = "ออโต้เลื่อนระดับ",
    ["Trade Up"] = "เลื่อนระดับ",
    ["Trade Up Tiers"] = "ระดับการเลื่อนขั้น",
    ["Trades"] = "การแลก",
    ["Emerald To Sapphire"] = "Emerald → Sapphire",
    ["Sapphire To Amethyst"] = "Sapphire → Amethyst",
    ["Amethyst To Radiant"] = "Amethyst → Radiant",
    ["Emerald -> Sapphire"] = "Emerald → Sapphire",
    ["Sapphire -> Amethyst"] = "Sapphire → Amethyst",
    ["Amethyst -> Radiant"] = "Amethyst → Radiant",
    ["Smart Trade For Essence"] = "แลกอัจฉริยะเพื่อ Essence",
    ["Auto Craft Essence"] = "ออโต้สร้าง Essence",
    ["Auto Essence"] = "ออโต้ Essence",
    ["Essence"] = "Essence",
    ["Auto Use Enchanted Essence"] = "ออโต้ใช้ Enchanted Essence",
    ["Essence Min Rarity"] = "ความหายากขั้นต่ำสำหรับ Essence",
    ["Only eggs of this rarity and above get the essence"] = "ใช้ Essence เฉพาะไข่ระดับนี้ขึ้นไป",
    ["Essence Min Value"] = "มูลค่าขั้นต่ำสำหรับ Essence",
    ["Essence Target Eggs"] = "ไข่เป้าหมายสำหรับ Essence",
    ["Only use the essence on these eggs (empty = all)"] = "ใช้ Essence กับไข่เหล่านี้เท่านั้น (เว้นว่าง = ทั้งหมด)",
    ["Essence Priority"] = "ลำดับความสำคัญของ Essence",
    ["Which egg gets the essence first"] = "กำหนดว่าไข่ใบไหนจะได้รับ Essence ก่อน",
    ["Essence Skip Enchanted Eggs"] = "ข้ามไข่ Enchanted สำหรับ Essence",
    ["Skip eggs that already got Enchanted, other mutations still get the essence"] = "ข้ามไข่ที่มี Enchanted แล้ว การกลายพันธุ์อื่นยังได้รับ Essence",
    ["Highest Value"] = "มูลค่าสูงสุด",
    ["Lowest Value"] = "มูลค่าต่ำสุด",
    ["Best Rarity"] = "ความหายากสูงสุด",
    ["Biggest Size"] = "ขนาดใหญ่สุด",
    ["Smallest Size"] = "ขนาดเล็กสุด",
    ["Biggest Weight"] = "น้ำหนักมากสุด",
    ["Best Mutation"] = "การกลายพันธุ์ดีที่สุด",
    ["Backpack Order"] = "ลำดับในกระเป๋า",
    ["Auto Favorite"] = "ออโต้กดถูกใจ",
    ["Auto Favorite Pet"] = "ออโต้กดถูกใจสัตว์เลี้ยง",
    ["Auto Favorite Pets"] = "ออโต้กดถูกใจสัตว์เลี้ยง",
    ["Favorite Pets Now"] = "กดถูกใจสัตว์เลี้ยงตอนนี้",
    ["Favorite pets matching the rules below"] = "กดถูกใจสัตว์เลี้ยงที่ตรงตามกฎด้านล่าง",
    ["Favorite matching pets once"] = "กดถูกใจสัตว์เลี้ยงที่ตรงเงื่อนไข 1 ครั้ง",
    ["Favorite Rule"] = "กฎการกดถูกใจ",
    ["Pass any check or all checks"] = "กำหนดให้ผ่านบางเงื่อนไขหรือทุกเงื่อนไข",
    ["Match Any"] = "ตรงอย่างใดอย่างหนึ่ง",
    ["Match All"] = "ตรงทุกเงื่อนไข",
    ["Favorite Min Rarity"] = "ความหายากขั้นต่ำที่จะกดถูกใจ",
    ["Favorite pets of the chosen rarity and every rarity above it (Off = skip)"] = "กดถูกใจสัตว์เลี้ยงระดับที่เลือกและสูงกว่า (ปิด = ข้าม)",
    ["Favorite Mutations"] = "การกลายพันธุ์ที่จะกดถูกใจ",
    ["Mutation check (empty = skip)"] = "ตรวจการกลายพันธุ์ (เว้นว่าง = ข้าม)",
    ["Min Favorite Value"] = "มูลค่าขั้นต่ำที่จะกดถูกใจ",
    ["Value check (0 = skip)"] = "ตรวจมูลค่า (0 = ข้าม)",
    ["Always Favorite Species"] = "กดถูกใจสายพันธุ์เหล่านี้เสมอ",
    ["Always favorite these species"] = "กดถูกใจสายพันธุ์เหล่านี้เสมอ",
    ["Auto Favorite Equipped"] = "ออโต้กดถูกใจตัวที่สวมใส่",
    ["Keep equipped pets favorited"] = "คงสถานะถูกใจให้สัตว์เลี้ยงที่สวมใส่",
    ["Auto Unfavorite Equipped"] = "ออโต้ปลดถูกใจตัวที่สวมใส่",
    ["Unfavorite equipped pets not in the rules"] = "ปลดถูกใจสัตว์เลี้ยงที่สวมใส่ซึ่งไม่ตรงกฎ",
    ["Favorite Equipped Now"] = "กดถูกใจตัวที่สวมใส่ตอนนี้",
    ["Favorite all equipped pets once"] = "กดถูกใจสัตว์เลี้ยงที่สวมใส่ทั้งหมด 1 ครั้ง",
    ["Unfavorite Equipped Now"] = "ยกเลิกถูกใจตัวที่สวมใส่อยู่ตอนนี้",
    ["Unfavorite all equipped pets once"] = "ปลดถูกใจสัตว์เลี้ยงที่สวมใส่ทั้งหมด 1 ครั้ง",
    ["Auto Progression"] = "พัฒนาอัตโนมัติ",
    ["Auto Buy Trail"] = "ออโต้ซื้อ Trail",
    ["Automatically buy available trails when affordable"] = "ซื้อ Trail ที่ซื้อได้อัตโนมัติเมื่อเงินพอ",
    ["Auto Upgrade Base"] = "ออโต้อัปเกรดฐาน",
    ["Automatically upgrade base when money is available"] = "อัปเกรดฐานอัตโนมัติเมื่อมีเงินพอ",
    ["Auto Claim"] = "ออโต้รับรางวัล",
    ["Claim offline money & index rewards"] = "รับเงินออฟไลน์และรางวัล Index อัตโนมัติ",
    ["Auto Claim Index"] = "ออโต้รับรางวัล Index",
    ["Claim index rewards as soon as they unlock"] = "รับรางวัล Index ทันทีเมื่อปลดล็อก",
    ["ESP"] = "ESP",
    ["ESP Eggs"] = "ESP ไข่",
    ["ESP Fixed Size"] = "ใช้ขนาด ESP คงที่",
    ["ESP Own Base"] = "ESP ไข่ในฐานตัวเอง",
    ["ESP Own Base Eggs"] = "ESP ไข่ในฐานตัวเอง",
    ["Also show the eggs placed in your own base"] = "แสดงไข่ที่วางอยู่ในฐานของตัวเองด้วย",
    ["ESP Min Rarity"] = "ความหายากขั้นต่ำของ ESP",
    ["Show eggs of the chosen rarity and every rarity above it"] = "แสดงไข่ระดับที่เลือกและทุกระดับที่สูงกว่า",
    ["ESP Show Info"] = "ข้อมูลที่แสดงใน ESP",
    ["Min ESP Value"] = "มูลค่าขั้นต่ำของ ESP",
    ["ESP Egg Size"] = "ขนาด ESP ไข่",
    ["ESP Guards"] = "ESP ยาม",
    ["ESP Guard Size"] = "ขนาด ESP ยาม",
    ["ESP Lost Parts"] = "ESP ชิ้นส่วนที่หาย",
    ["ESP Missing Parts"] = "ESP ชิ้นส่วนที่หาย",
    ["ESP Players"] = "ESP ผู้เล่น",
    ["ESP Player Info"] = "ข้อมูล ESP ผู้เล่น",
    ["ESP Player Size"] = "ขนาด ESP ผู้เล่น",
    ["Guards"] = "ยาม",
    ["Icon"] = "ไอคอน",
    ["Name"] = "ชื่อ",
    ["Weight"] = "น้ำหนัก",
    ["Sell Price"] = "ราคาขาย",
    ["Distance"] = "ระยะทาง",
    ["State"] = "สถานะ",
    ["Username"] = "ชื่อผู้ใช้",
    ["Avatar"] = "อวตาร",
    ["Tool"] = "อุปกรณ์",
    ["Discord Webhook"] = "เว็บฮุก Discord",
    ["Discord Webhook URL"] = "URL Webhook ของ Discord",
    ["Webhook URL"] = "URL ของ Webhook",
    ["Ping @everyone"] = "แท็ก @everyone",
    ["Notify Stolen Eggs"] = "แจ้งเตือนไข่ที่ขโมยได้",
    ["Egg Predictor"] = "คาดการณ์ไข่",
    ["Fuse Predictor"] = "คาดการณ์ผลการผสม",
    ["Lab Predictor"] = "คาดการณ์ห้องแล็บ",
    ["Machine is empty"] = "เครื่องยังว่าง",
    ["Predictor Tab > Discord Webhook"] = "แท็บคาดการณ์ > Discord Webhook",
    ["Predictor Tab > Egg Predictor"] = "แท็บคาดการณ์ > คาดการณ์ไข่",
    ["Progress Tab > Auto Progression"] = "แท็บความคืบหน้า > พัฒนาอัตโนมัติ",
    ["Sort By"] = "เรียงตาม",
    ["Time Left"] = "เวลาที่เหลือ",
    ["Preview Card"] = "แสดงตัวอย่างการ์ด",
    ["Search eggs..."] = "ค้นหาไข่...",
    ["HOLD EGG"] = "ถือไข่",
    ["IN BAG"] = "ในกระเป๋า",
    ["EGGS"] = "ไข่",
    ["READY"] = "พร้อม",
    ["GROWING"] = "กำลังโต",
    ["TOTAL /S"] = "รวม /วินาที",
    ["Interface"] = "หน้าตา",
    ["UI Size"] = "ขนาด UI",
    ["Scales the main window; the corner grip does the same by hand"] = "ปรับขนาดหน้าต่างหลัก หรือลากมุมเพื่อปรับเอง",
    ["Notifications"] = "การแจ้งเตือน",
    ["Show notification cards; turning this off hides every notify"] = "แสดงการแจ้งเตือน ปิดแล้วจะซ่อนการแจ้งเตือนทั้งหมด",
    ["Open On Launch"] = "เปิด UI ตอนเริ่ม",
    ["Open the UI automatically when the script starts"] = "เปิดหน้าต่าง UI อัตโนมัติเมื่อสคริปต์เริ่ม",
    ["Defaults"] = "ค่าเริ่มต้น",
    ["Reset to Defaults"] = "รีเซ็ตเป็นค่าเริ่มต้น",
    ["Reset every feature to its built-in default"] = "คืนค่าทุกฟีเจอร์กลับเป็นค่าเริ่มต้น",
    ["Turn Off All Toggles"] = "ปิดสวิตช์ทั้งหมด",
    ["Switch off every enabled toggle in the feature tabs"] = "ปิดทุกสวิตช์ที่เปิดอยู่ในแท็บฟีเจอร์",
    ["Quick Access"] = "เมนูลัด",
    ["Show Quick Bars"] = "แสดงแถบลัด",
    ["Floating quick bars; drag a header to move one"] = "แสดงแถบลัดแบบลอย ลากหัวแถบเพื่อย้ายตำแหน่ง",
    ["Visible Quick Bars"] = "แถบลัดที่แสดง",
    ["Quick Bar Size"] = "ขนาดแถบลัด",
    ["Quick Bar & Keybinds"] = "แถบลัดและปุ่มคีย์ลัด",
    ["Reset Quick Access"] = "รีเซ็ตเมนูลัด",
    ["Restore default items, bars and positions"] = "คืนค่าไอเท็ม แถบ และตำแหน่งเริ่มต้น",
    ["Reset Keybinds"] = "รีเซ็ตปุ่มคีย์ลัด",
    ["Restore the defaults set in code"] = "คืนค่าปุ่มตามค่าเริ่มต้นของสคริปต์",
    ["Quick Bar 1"] = "แถบลัด 1",
    ["Profiles"] = "โปรไฟล์",
    ["Startup Config"] = "คอนฟิกเริ่มต้น",
    ["Auto Save Config"] = "บันทึกคอนฟิกอัตโนมัติ",
    ["Auto Load Config"] = "โหลดคอนฟิกอัตโนมัติ",
    ["Delete Config"] = "ลบคอนฟิก",
    ["Set Startup Config"] = "ตั้งคอนฟิกเริ่มต้น",
    ["Load Config"] = "โหลดคอนฟิก",
    ["Save Config"] = "บันทึกคอนฟิก",
    ["Import / Export"] = "นำเข้า / ส่งออก",
    ["Import / export"] = "นำเข้า / ส่งออก",
    ["Export Config"] = "ส่งออกคอนฟิก",
    ["Import Config"] = "นำเข้าคอนฟิก",
    ["Import Config Text"] = "ข้อความนำเข้าคอนฟิก",
    ["Paste exported config JSON..."] = "วาง JSON คอนฟิกที่ส่งออกไว้ที่นี่...",
    ["Creates a config only; use Load Config or Set Startup after"] = "สร้างคอนฟิกเท่านั้น จากนั้นใช้ โหลดคอนฟิก หรือ ตั้งคอนฟิกเริ่มต้น",
    ["Config name"] = "ชื่อคอนฟิก",
    ["New Config Name"] = "ชื่อคอนฟิกใหม่",
    ["New config name..."] = "ชื่อคอนฟิกใหม่...",
    ["Create config"] = "สร้างคอนฟิก",
    ["Create New Config"] = "สร้างคอนฟิกใหม่",
    ["Create New"] = "สร้างใหม่",
    ["New config copies current settings"] = "คอนฟิกใหม่จะคัดลอกการตั้งค่าปัจจุบัน",
    ["Delete config"] = "ลบคอนฟิก",
    ["Load config"] = "โหลดคอนฟิก",
    ["Refresh list"] = "รีเฟรชรายการ",
    ["Set autoload"] = "ตั้งโหลดอัตโนมัติ",
    ["Reset autoload"] = "ยกเลิกโหลดอัตโนมัติ",
    ["Farm Tab > Auto Sell Lab Egg"] = "แท็บฟาร์ม > ออโต้ขายไข่แล็บ",
    ["Farm Tab > Auto Place Egg"] = "แท็บฟาร์ม > ออโต้วางไข่",
    ["Farm Tab > Auto Treadmill"] = "แท็บฟาร์ม > ออโต้ลู่วิ่ง",
    ["Farm Tab > Auto Hatch & Equip"] = "แท็บฟาร์ม > ออโต้ฟักไข่และสวมใส่",
    ["Farm Tab > Auto Sell"] = "แท็บฟาร์ม > ออโต้ขาย",
    ["Farm Tab > Auto Steal"] = "แท็บฟาร์ม > ออโต้ขโมย",
    ["Farm Tab > Dr Scramble Lab & Mech"] = "แท็บฟาร์ม > ห้องแล็บ Dr. Scramble & หุ่นรบ",
    ["Misc Tab > Utility"] = "แท็บอื่นๆ > เครื่องมือ",
    ["Auto Hop Tab > Egg Finder"] = "แท็บย้ายเซิร์ฟอัตโนมัติ > ค้นหาไข่",
    ["Discord Tab > Community"] = "แท็บดิสคอร์ด > ชุมชน",
    ["Copy Discord Link"] = "คัดลอกลิงก์ดิสคอร์ด",
    ["Settings Tab > Defaults"] = "แท็บตั้งค่า > ค่าเริ่มต้น",
    ["Delivers the egg to the safe zone in a few seconds, needs enough Speed"] = "ส่งไข่กลับเขตปลอดภัยภายในไม่กี่วินาที ต้องมีความเร็วเพียงพอ",
    ["Higher is safer but takes longer"] = "ค่ายิ่งสูงยิ่งปลอดภัย แต่ใช้เวลานานขึ้น",
    ["Fast Delivery"] = "ส่งไข่กลับฐานแบบเร็ว",
    ["Delivers the same way as Instant Steal V2 instead of using steps"] = "ส่งไข่กลับฐานด้วยวิธีเดียวกับขโมยทันที V2 แทนการใช้ขั้นตอน",
    ["Instant Steal V2"] = "ขโมยทันที V2",
    ["Steal eggs of the chosen rarity and every rarity above it"] = "ขโมยไข่ระดับที่เลือกและทุกระดับที่สูงกว่า",
    ["Enchanted Forest"] = "ป่ามนตรา",
    ["Over 100% may glitch"] = "เกิน 100% อาจทำให้การเคลื่อนที่ผิดปกติ",
    ["Drop Eggs At Safe Zone"] = "วางไข่ในเขตปลอดภัย",
    ["Auto Steal: OFF"] = "ออโต้ขโมย: ปิด",
    ["Auto Steal: ON"] = "ออโต้ขโมย: เปิด",
    ["Instant Steal: OFF"] = "ขโมยทันที: ปิด",
    ["Instant Steal: ON"] = "ขโมยทันที: เปิด",

    -- V1.7.8: floating animal-steal panel (screenshot 2026-10-18)
    ["Halloween: OFF"] = "ฮาโลวีน: ปิด",
    ["Halloween: ON"] = "ฮาโลวีน: เปิด",
    ["Eggs: All"] = "ไข่: ทั้งหมด",
    ["Eggs: ALL"] = "ไข่: ทั้งหมด",
    ["Auto Steal: Off"] = "ออโต้ขโมย: ปิด",
    ["Auto Steal: On"] = "ออโต้ขโมย: เปิด",
    ["Halloween: Off"] = "ฮาโลวีน: ปิด",
    ["Halloween: On"] = "ฮาโลวีน: เปิด",
    ["Eggs"] = "ไข่",
    ["Halloween"] = "ฮาโลวีน",

    -- V1.3: New Chilli Farm > Instant Steal Zones (2026-10-09)
    ["Teleport To Egg"] = "วาร์ปไปหาไข่",
    ["Teleport to Egg"] = "วาร์ปไปหาไข่",
    ["Teleport To Eggs"] = "วาร์ปไปหาไข่",
    ["Instant Steal Zones"] = "โซนขโมยทันที",
    ["Instant Steal Zone"] = "โซนขโมยทันที",
    ["Zones where Instant Steal V2 is used"] = "โซนที่ใช้ระบบขโมยทันที V2",
    ["Prehistoric"] = "ยุคดึกดำบรรพ์",
    ["Cherry Blossom"] = "ซากุระ",
    ["Light Dark"] = "แสงและความมืด",
    ["Titan Temple"] = "วิหารไททัน",
}

--========================================================
-- V1.7 ADD-ONLY TRANSLATIONS: CHILLI RACE / SHOOTING STAR
-- / AUTO MUTATION / QUICK-BAR LABELS (2026-10-11)
-- Preserves all existing V1.6 DR-FIX 3 mappings.
-- No hooks, layout changes or additional scanning.
--========================================================

local ZIGZAG_V17_TRANSLATIONS = {
    ["Racing Event"] = "กิจกรรมแข่งวิ่ง",
    ["Auto Race"] = "ออโต้แข่งวิ่ง",
    ["Race Speed"] = "ความเร็วในการแข่งขัน",
    ["Auto Use Power-Ups"] = "ออโต้ใช้ไอเทมเพิ่มพลัง",
    ["Auto Claim Race Rewards"] = "ออโต้รับรางวัลการแข่งขัน",
    ["Auto Equip Racer"] = "ออโต้เลือกพาหนะแข่ง",
    ["Racer"] = "พาหนะแข่ง",
    ["Best Owned"] = "ตัวที่ดีที่สุดที่มี",
    ["Ostrich"] = "นกกระจอกเทศ",
    ["Auto Buy Race Shop"] = "ออโต้ซื้อของจากร้านการแข่งขัน",
    ["Race Shop Items"] = "ไอเทมในร้านการแข่งขัน",
    ["Nitro Mutation"] = "การกลายพันธุ์ไนโตร",
    ["Cash Booster"] = "ตัวเพิ่มรายได้",
    ["Treadmill Boost"] = "บูสต์ลู่วิ่ง",
    ["Racing Bat"] = "ไม้ตีการแข่งขัน",
    ["Shooting Star"] = "ดาวตก",
    ["Shooting Stars"] = "ดาวตก",
    ["Waiting for a shooting star"] = "กำลังรอดาวตก",
    ["Waiting for a shooting star."] = "กำลังรอดาวตก",
    ["Waiting for a shooting star..."] = "กำลังรอดาวตก",
    ["Auto Catch Shooting Star"] = "ออโต้เก็บดาวตก",
    ["Auto Catch Shooting Stars"] = "ออโต้เก็บดาวตก",
    ["Auto Mutation"] = "ออโต้กลายพันธุ์",
    ["Auto Mutate"] = "ออโต้กลายพันธุ์",
    ["Mutations To Use"] = "การกลายพันธุ์ที่ต้องการใช้",
    ["Fractured"] = "แตกสลาย",
    ["Scrambled"] = "สแครมเบิล",
    ["Enchanted"] = "มนตรา",
    ["Nitro"] = "ไนโตร",
    ["Auto Buy Nitro"] = "ออโต้ซื้อไนโตร",
    ["Buy Nitro from the Racing Event shop as soon as you run out"] = "ซื้อไนโตรจากร้านกิจกรรมแข่งวิ่งทันทีเมื่อไนโตรหมด",
    ["Mutate Min Rarity"] = "ความหายากขั้นต่ำสำหรับการกลายพันธุ์",
    ["Only eggs of this rarity and above get mutated"] = "กลายพันธุ์เฉพาะไข่ระดับนี้ขึ้นไป",
    ["Mutate Min Value"] = "มูลค่าขั้นต่ำสำหรับการกลายพันธุ์",
    ["Skip eggs worth less than this (0 = off)"] = "ข้ามไข่ที่มูลค่าต่ำกว่าที่กำหนด (0 = ปิด)",
    ["Mutate Target Eggs"] = "ไข่เป้าหมายสำหรับการกลายพันธุ์",
    ["Only mutate these eggs (empty = all)"] = "กลายพันธุ์เฉพาะไข่ที่เลือก (เว้นว่าง = ทั้งหมด)",
    ["Mutate Priority"] = "ลำดับความสำคัญการกลายพันธุ์",
    ["Which egg gets mutated first"] = "เลือกไข่ที่จะกลายพันธุ์ก่อน",
    ["Keep Mutated Eggs"] = "เก็บไข่ที่กลายพันธุ์ไว้",
    ["Min Hatch Value"] = "มูลค่าขั้นต่ำในการฟักไข่",
    ["Farm Tab > Racing Event"] = "แท็บฟาร์ม > กิจกรรมแข่งวิ่ง",
    ["Farm Tab > Shooting Star"] = "แท็บฟาร์ม > ดาวตก",
    ["Farm Tab > Butterfly Bloom"] = "แท็บฟาร์ม > ผีเสื้อผลิบาน",
    ["Farm Tab > Auto Mutation"] = "แท็บฟาร์ม > ออโต้กลายพันธุ์",
    ["Farm Tab > Auto Fuse Machine"] = "แท็บฟาร์ม > ออโต้เครื่องผสมสัตว์",
    ["Farm Tab > Auto Sell Pet"] = "แท็บฟาร์ม > ออโต้ขายสัตว์เลี้ยง",
    ["Farm Tab > Auto Sell Egg"] = "แท็บฟาร์ม > ออโต้ขายไข่",
    ["Farm Tab > Auto Buy Race Shop"] = "แท็บฟาร์ม > ออโต้ซื้อของร้านการแข่งขัน",
    ["Next Racing Event in"] = "กิจกรรมแข่งวิ่งครั้งถัดไปใน",
    ["Race Rewards"] = "รางวัลการแข่งขัน",
    ["Race Shop"] = "ร้านการแข่งขัน",
}

for english,thai in pairs(ZIGZAG_V17_TRANSLATIONS) do
    if TRANSLATIONS[english] == nil then
        TRANSLATIONS[english] = thai
    end
end

--========================================================
-- V1.7.1: ADMIN ABUSE TRANSLATIONS (ADD-ONLY)
-- Uses original cache/translator; zero new watchers or scans.
--========================================================
local ZIGZAG_V171_ADMIN_TRANSLATIONS = {
    ["Admin Abuse"] = "กิจกรรมแอดมิน",
    ["Admin Abuse Tab"] = "แท็บกิจกรรมแอดมิน",
    ["Capture The Egg"] = "จับไข่กิจกรรม",
    ["Capture the Egg"] = "จับไข่กิจกรรม",
    ["Auto Capture Event Egg"] = "ออโต้จับไข่กิจกรรม",
    ["Take It From The Holder"] = "แย่งไข่จากผู้ที่กำลังถือ",
    ["Hold Height"] = "ความสูงขณะถือไข่",
    ["Keep Away Distance"] = "ระยะเว้นห่างจากผู้อื่น",
    ["Admin Treadmill"] = "ลู่วิ่งแอดมิน",
    ["Auto Use Admin Treadmill"] = "ออโต้ใช้ลู่วิ่งแอดมิน",
    ["Instant Steal V3"] = "ขโมยทันที V3",
    ["Minigame Eggs"] = "ไข่มินิเกม",
    ["Minigame Egg"] = "ไข่มินิเกม",
    ["Auto Steal Minigame Egg"] = "ออโต้ขโมยไข่มินิเกม",
    ["Admin Abuse Tab > Capture The Egg"] = "แท็บกิจกรรมแอดมิน > จับไข่กิจกรรม",
    ["Admin Abuse Tab > Admin Treadmill"] = "แท็บกิจกรรมแอดมิน > ลู่วิ่งแอดมิน",
    ["Admin Abuse Tab > Instant Steal V3"] = "แท็บกิจกรรมแอดมิน > ขโมยทันที V3",
    ["Admin Abuse Tab > Minigame Eggs"] = "แท็บกิจกรรมแอดมิน > ไข่มินิเกม",
}
for en,th in pairs(ZIGZAG_V171_ADMIN_TRANSLATIONS) do
    if TRANSLATIONS[en] == nil then
        TRANSLATIONS[en] = th
    end
end


--========================================================
-- V1.7.1 VERIFIED BASE + V1.7.4 ADD-ONLY TRANSLATIONS
-- New English -> Thai dictionary entries only; NO engine/loader/UI changes.
-- This section MUST run before LOWER_TRANSLATIONS cache creation.
--========================================================
local ZIGZAG_V174_ADDED_TRANSLATIONS = {
    ["Toggle is off"] = "สวิตช์ปิดอยู่",
    ["Needs Admin Treadmill"] = "ต้องมีลู่วิ่งแอดมิน",
    ["Needs Admin Treadmill to work"] = "ต้องมีลู่วิ่งแอดมินจึงจะใช้งานได้",
    ["INACTIVE"] = "ยังไม่ทำงาน",
    ["WAITING"] = "กำลังรอ",
    ["Waiting for Capture The Egg"] = "กำลังรอกิจกรรมจับไข่",
    ["Turn on Capture The Egg below to join the event"] = "เปิดระบบจับไข่ด้านล่างเพื่อเข้าร่วมกิจกรรม",
    ["Waiting for Red Light Green Light or T-Rex Run"] = "กำลังรอกิจกรรมไฟแดงไฟเขียวหรือวิ่งหนีทีเร็กซ์",
    ["Turn on Auto Steal Minigame Egg below"] = "เปิดระบบขโมยไข่มินิเกมอัตโนมัติด้านล่าง",
    ["Red Light Green Light, T-Rex Run"] = "ไฟแดงไฟเขียว, วิ่งหนีทีเร็กซ์",
    ["Red Light Green Light"] = "ไฟแดงไฟเขียว",
    ["T-Rex Run"] = "วิ่งหนีทีเร็กซ์",
    ["Swap Weapons"] = "สลับอาวุธ",
    ["Pick up to 2 weapons you own to switch between while hitting (empty = best bat only)"] = "เลือกอาวุธที่คุณมีได้สูงสุด 2 ชิ้นเพื่อสลับใช้ระหว่างตี (ถ้าเว้นว่าง = ใช้ไม้ที่ดีที่สุดเท่านั้น)",
    ["Weapon 1 Hold"] = "เวลาถืออาวุธ 1",
    ["Weapon 2 Hold"] = "เวลาถืออาวุธ 2",
    ["The Scrambler"] = "เดอะ สแครมเบลอร์",
    ["EnchantedHammer"] = "ค้อนมนตรา",
    ["Light Dark Staff"] = "คทาแสงและความมืด",
    ["Titan Axe"] = "ขวานไททัน",
    ["Katana"] = "คาตานะ",
    ["Scramble Sword"] = "ดาบสแครมเบิล",
    ["Cosmic Bat"] = "ไม้คอสมิก",
    ["Prehistoric Bat"] = "ไม้ยุคดึกดำบรรพ์",
    ["Abyss Ocean Bat"] = "ไม้ห้วงสมุทรลึก",
    ["Volcano Bat"] = "ไม้ภูเขาไฟ",
    ["Snow Bat"] = "ไม้หิมะ",
    ["Jungle Bat"] = "ไม้ป่า",
    ["Desert Bat"] = "ไม้ทะเลทราย",
    ["Lake Bat"] = "ไม้ทะเลสาบ",
    ["Forest Bat"] = "ไม้ป่า",
    ["Aura ready, nobody in reach"] = "ออร่าพร้อมแล้ว แต่ยังไม่มีใครอยู่ในระยะ",
    ["Turn on Auto Use Admin Treadmill below"] = "เปิดใช้งานออโต้ใช้ลู่วิ่งแอดมินด้านล่าง",
    ["Waiting for the Admin Treadmill"] = "กำลังรอลู่วิ่งแอดมิน",
    ["Strip shadows, textures and effects for the highest FPS"] = "ปิดเงา พื้นผิว และเอฟเฟกต์ เพื่อให้ได้ FPS สูงสุด",
    ["Utility"] = "ยูทิลิตี้",
    ["HUD Items"] = "รายการ HUD",
    ["Egg Card Image"] = "รูปการ์ดไข่",
    ["Picture used for Top Eggs and Steal History"] = "รูปภาพที่ใช้สำหรับไข่เด่นและประวัติการขโมย",
    ["Egg Image"] = "รูปไข่",
    ["Sort: Best Rarity"] = "เรียงตาม: ระดับความหายากสูงสุด",
    ["Sacred Moth"] = "ผีเสื้อกลางคืนศักดิ์สิทธิ์",
    ["Astral Jackalope"] = "แจ็กคาโลปแห่งดวงดาว",
    ["Holy Peacock"] = "นกยูงศักดิ์สิทธิ์",
    ["Imp"] = "อิมพ์",
    ["Pick up to two weapons you own to switch between while hitting (empty = best bat only)"] = "เลือกอาวุธที่มีได้สูงสุด 2 ชิ้นเพื่อสลับใช้ขณะตี (เว้นว่าง = ใช้ไม้ตีที่ดีที่สุดเท่านั้น)",
}
for english,thai in pairs(ZIGZAG_V174_ADDED_TRANSLATIONS) do
    if TRANSLATIONS[english] == nil then
        TRANSLATIONS[english] = thai
    end
end

--========================================================
-- V1.7.1 VERIFIED BASE + V1.7.4 + 2026-10-14 LABELS
-- ONLY missing English -> Thai dictionary entries from three screenshots.
-- NO loader, translator, UI, theme, scan, or gameplay logic changes.
-- Must run BEFORE cache/lookup construction; old translations win.
--========================================================
local ZIGZAG_NEW_STEAL_METHOD_LABELS = {
    ["Move To Egg"] = "วิธีเคลื่อนที่ไปหาไข่",
    ["Delivery Method"] = "วิธีส่งไข่กลับฐาน",
    ["Teleport"] = "วาร์ป",
    ["Step"] = "ทีละขั้น",
    ["Tween"] = "เคลื่อนที่ลื่นไหล",
}
for english,thai in pairs(ZIGZAG_NEW_STEAL_METHOD_LABELS) do
    if TRANSLATIONS[english] == nil then
        TRANSLATIONS[english] = thai
    end
end

--========================================================
-- ZIGZAG 2026-10-18 HALLOWEEN UPDATE (ADDITIVE TRANSLATIONS ONLY)
-- UI labels captured from CHILLI Hub screenshots; game logic unchanged.
-- Stays before lookup/cache construction, so every new label is reactive.
-- No new task loops, GUIs, re-loads, teleport hooks, or .Text overrides.
--========================================================
local ZIGZAG_HALLOWEEN_TRANSLATIONS = {
    ["Halloween Dimension"] = "มิติฮาโลวีน",
    ["Halloween Monsters"] = "มอนสเตอร์ฮาโลวีน",
    ["Ghost Dog & Fishing"] = "เควสต์สุนัขผีและตกปลา",
    ["Ghost Dog and Fishing"] = "เควสต์สุนัขผีและตกปลา",
    ["Phantom Express"] = "รถไฟภูตพราย",
    ["Auto Steal Halloween Eggs"] = "ออโต้ขโมยไข่ฮาโลวีน",
    ["Instant Steal Halloween Eggs"] = "ขโมยไข่ฮาโลวีนทันที",
    ["Steal Missing Halloween Index"] = "ขโมยไข่ฮาโลวีนที่ยังไม่มีในสารบัญ",
    ["Steal Speed"] = "ความเร็วขโมยไข่",
    ["Halloween Eggs To Steal"] = "ไข่ฮาโลวีนที่จะขโมย",
    ["Halloween Egg Rarities"] = "ระดับความหายากไข่ฮาโลวีน",
    ["Min Value"] = "มูลค่าขั้นต่ำ",
    ["Min Value ($/s)"] = "มูลค่าขั้นต่ำ ($/วินาที)",
    ["Auto Pumpkin Moon"] = "ออโต้กิจกรรมพระจันทร์ฟักทอง",
    ["Auto Buy Halloween Dimension Egg"] = "ออโต้ซื้อไข่จากมิติฮาโลวีน",
    ["Auto Farm Monsters"] = "ออโต้ฟาร์มมอนสเตอร์",
    ["Auto Kill Monsters"] = "ออโต้กำจัดมอนสเตอร์",
    ["Monsters To Kill"] = "มอนสเตอร์ที่จะกำจัด",
    ["Monsters"] = "มอนสเตอร์",
    ["Monster Order"] = "ลำดับการเลือกมอนสเตอร์",
    ["Closest First"] = "ใกล้ที่สุดก่อน",
    ["Most Tokens"] = "ได้โทเคนมากที่สุดก่อน",
    ["Use Weapons"] = "ใช้อาวุธ",
    ["Auto Ghost Dog Quest"] = "ออโต้ทำเควสต์สุนัขผี",
    ["Auto Fishing"] = "ออโต้ตกปลา",
    ["Cast Luck"] = "ตัวคูณโชคในการเหวี่ยงเบ็ด",
    ["x1.5 Perfect"] = "x1.5 สมบูรณ์แบบ",
    ["x1.2"] = "x1.2",
    ["x1.1"] = "x1.1",
    ["x1.0 Fastest"] = "x1.0 เร็วที่สุด",
    ["Quest"] = "เควสต์",
    ["Fish Caught"] = "จำนวนปลาที่จับได้",
    ["Auto Phantom Express"] = "ออโต้รถไฟภูตพราย",
    ["Auto Vacuum Ghouler Boss"] = "ออโต้ดูดบอส Ghouler",
    ["Ghost Target"] = "เป้าหมายผี",
    ["Rarest First"] = "หายากที่สุดก่อน",
    ["Auto Trade Souls"] = "ออโต้แลกวิญญาณ",
    ["Train"] = "รถไฟ",
    ["Souls"] = "วิญญาณ",
    ["Not Here"] = "ยังไม่มา",
    ["Halloween Eggs"] = "ไข่ฮาโลวีน",
    ["Halloween Rarities"] = "ระดับความหายากไข่ฮาโลวีน",
    ["Auto Buy Halloween Egg"] = "ออโต้ซื้อไข่ฮาโลวีน",
    ["Ghost Dog Quest"] = "เควสต์สุนัขผี",
    ["Pumpkin Moon"] = "พระจันทร์ฟักทอง",
    ["Ghost Dog"] = "สุนัขผี",
    ["Fishing"] = "ตกปลา",
}
for english,thai in pairs(ZIGZAG_HALLOWEEN_TRANSLATIONS) do
    if TRANSLATIONS[english] == nil then
        TRANSLATIONS[english] = thai
    end
end

--========================================================
-- ZIGZAG V1.8.5: 2026-10-20 NEW CHILLI / VENYX LABELS
-- From screenshots: Phantom Express wait, fishing spot, Blood Moon.
-- Additive dictionary entries ONLY; do not change UI behavior.
--========================================================
local ZIGZAG_V184_CHILLI_LABELS = {
    ["Halloween & Star"] = "ฮาโลวีนและดาวตก",
    ["Place and hatch missing index eggs"] = "วางและฟักไข่ที่ยังไม่มีในสารบัญ",
    ["Fishing Spot"] = "จุดตกปลา",
    ["Save Spot Here"] = "บันทึกจุดตกปลาที่นี่",
    ["Spot 1"] = "จุด 1",
    ["Spot 2"] = "จุด 2",
    ["Spot 3"] = "จุด 3",
    ["Waiting for the Phantom Express"] = "กำลังรอรถไฟภูตพราย",
    ["Only During Blood Moon"] = "เฉพาะช่วงพระจันทร์สีเลือด",
    ["Fighting Large monster"] = "กำลังต่อสู้กับมอนสเตอร์ขนาดใหญ่",
}
--========================================================
-- ZIGZAG V1.8.5 • NEW CHILLI + VENYX UPDATE (2026-10-21)
-- Translation entries only, from seven screenshots. No gameplay/UI changes.
-- Also embedded in the teleport translator-only copy.
--========================================================
local ZIGZAG_V185_CHILLI_LABELS = {
    ["Waiting: nothing to do"] = "กำลังรอ: ไม่มีงานให้ทำ",
    ["Take Halloween Eggs From Holders"] = "แย่งไข่ฮาโลวีนจากผู้ที่กำลังถือ",
    ["Teleport To Pumpkins"] = "วาร์ปไปหาฟักทอง",
    ["Teleport To Monsters"] = "วาร์ปไปหามอนสเตอร์",
    ["Teleport To Ghosts"] = "วาร์ปไปหาผี",
    ["Farm All Monsters In Blood Moon"] = "ฟาร์มมอนสเตอร์ทั้งหมดช่วงพระจันทร์สีเลือด",
    ["Farm Monsters While Fishing"] = "ฟาร์มมอนสเตอร์ระหว่างตกปลา",
    ["Fishing History"] = "ประวัติการตกปลา",
    ["Catches"] = "จำนวนที่จับได้",
}
for english,thai in pairs(ZIGZAG_V185_CHILLI_LABELS) do
    if TRANSLATIONS[english] == nil then
        TRANSLATIONS[english] = thai
    end
end

--========================================================
-- ZIGZAG V1.8.6 • CHILLI/VENYX V1.2.8 PRIORITY + THE HOLLOW
-- Additive display-only translations, including screenshots 1-7.
-- Present both in main translator and teleport-only continuation.
--========================================================
local ZIGZAG_V186_CHILLI_LABELS = {
    ["Priority Rotation"] = "สลับงานตามลำดับความสำคัญ",
    ["Rotate Fishing And Treadmill"] = "สลับตกปลากับลู่วิ่ง",
    ["Rotation Switch"] = "เงื่อนไขการสลับงาน",
    ["Fishing Minutes"] = "เวลาตกปลา (นาที)",
    ["Treadmill Minutes"] = "เวลาวิ่งลู่ (นาที)",
    ["Timer"] = "ตั้งเวลา",
    ["Every day"] = "ทุกวัน",
    ["Switch"] = "สลับงาน",
    ["The Hollow"] = "เดอะฮอลโลว์",
    ["The Hollow Race"] = "การแข่งขันเดอะฮอลโลว์",
    ["Auto Race The Hollow"] = "แข่งเดอะฮอลโลว์อัตโนมัติ",
    ["Hollow Race Speed"] = "ความเร็วแข่งเดอะฮอลโลว์",
    ["Use Race Power-Ups"] = "ใช้ไอเทมเพิ่มพลังระหว่างแข่ง",
    ["Wins"] = "ชัยชนะ",
    ["NOW"] = "ตอนนี้",
    ["DOING NOW"] = "กำลังทำ",
    ["SWITCH IN"] = "สลับในอีก",
    ["Farm monsters"] = "ฟาร์มมอนสเตอร์",
    ["Farm monsters in Blood Moon"] = "ฟาร์มมอนสเตอร์ช่วงพระจันทร์สีเลือด",
    ["Place eggs"] = "วางไข่",
    ["Mutate eggs"] = "ทำให้ไข่กลายพันธุ์",
    ["Wisp quest"] = "ภารกิจ Wisp",
    ["Riding the Phantom Express"] = "กำลังขึ้นรถไฟภูตพราย",
    ["Fighting Small monster"] = "กำลังต่อสู้กับมอนสเตอร์ขนาดเล็ก",
    ["Top goes first. A task never stops halfway: the next one waits until it finishes. A carried egg is always delivered first."] = "งานลำดับบนสุดทำก่อน งานที่เริ่มแล้วจะทำให้เสร็จก่อนจึงสลับงานถัดไป และจะนำไข่ที่ถืออยู่ไปส่งก่อนเสมอ",
    ["Lower it if laps do not count"] = "ลดความเร็วลงหากระบบไม่นับรอบการแข่งขัน",
}
for english,thai in pairs(ZIGZAG_V186_CHILLI_LABELS) do
    if TRANSLATIONS[english] == nil then
        TRANSLATIONS[english] = thai
    end
end

--========================================================
-- ZIGZAG V1.8.7 • CHILLI AUTO STEAL / SELL / MUTATION / EVENT / VENYX PROMO
-- Display translations from 7 screenshots (2026-10-25).
-- No source gameplay, UI hierarchy, callbacks, or movement edits.
-- Applied in BOTH main and teleport translator-only copies.
--========================================================
local ZIGZAG_V187_CHILLI_LABELS = {
    ["Move To Egg Speed"] = "ความเร็วในการไปหาไข่",
    ["Move to Egg Speed"] = "ความเร็วในการไปหาไข่",
    ["Delivery"] = "วิธีส่งไข่กลับฐาน",
    ["Fast Tween"] = "เคลื่อนที่เร็วแบบ Tween",
    ["Fast Tween Speed"] = "ความเร็วส่งไข่แบบ Tween",
    ["Instant Steps"] = "เคลื่อนที่ทันทีแบบเป็นขั้น",
    ["Leap"] = "กระโดดพุ่ง",
    ["Auto Claim Money"] = "รับเงินอัตโนมัติ",
    ["Auto Claim Cash"] = "รับเงินอัตโนมัติ",
    ["Sell matching eggs once"] = "ขายไข่ที่ตรงเงื่อนไขหนึ่งครั้ง",
    ["Sell matching eggs once."] = "ขายไข่ที่ตรงเงื่อนไขหนึ่งครั้ง",
    ["Sell Egg Rule"] = "กฎการขายไข่",
    ["Egg Max Rarity"] = "ความหายากสูงสุดของไข่ที่จะขาย",
    ["Sell eggs at or below this rarity"] = "ขายไข่ระดับนี้หรือต่ำกว่า",
    ["Sell eggs at or below this rarity."] = "ขายไข่ระดับนี้หรือต่ำกว่า",
    ["Egg Sell Value"] = "มูลค่าไข่ที่จะขาย",
    ["Sell eggs worth less than this (0 = off)"] = "ขายไข่ที่มูลค่าต่ำกว่าที่กำหนด (0 = ปิด)",
    ["Keep Mutated Eggs"] = "เก็บไข่ที่กลายพันธุ์ไว้",
    ["Never sell mutated eggs"] = "ห้ามขายไข่ที่กลายพันธุ์",
    ["Never sell mutated eggs."] = "ห้ามขายไข่ที่กลายพันธุ์",
    ["Blacklist Sell Eggs"] = "รายการไข่ห้ามขาย",
    ["These eggs are never sold"] = "ไข่เหล่านี้จะไม่ถูกขาย",
    ["These eggs are never sold."] = "ไข่เหล่านี้จะไม่ถูกขาย",
    ["Cursed Island Wars"] = "สงครามเกาะต้องสาป",
    ["Waiting for Cursed Island Wars"] = "กำลังรอสงครามเกาะต้องสาป",
    ["Auto Play Cursed Island Wars"] = "เล่นสงครามเกาะต้องสาปอัตโนมัติ",
    ["Island Wars Target"] = "เป้าหมายสงครามเกาะต้องสาป",
    ["Enemies And Base"] = "ศัตรูและฐาน",
    ["Walls And Crystal"] = "กำแพงและคริสตัล",
    ["Smoother, faster and more ways to steal."] = "ลื่นไหลขึ้น เร็วขึ้น พร้อมวิธีขโมยที่หลากหลายกว่าเดิม",
    ["Smoother, faster and more ways to steal"] = "ลื่นไหลขึ้น เร็วขึ้น พร้อมวิธีขโมยที่หลากหลายกว่าเดิม",
    ["Try now"] = "ลองใช้งานเลย",
    ["Try Now"] = "ลองใช้งานเลย",
    ["Smoother & faster"] = "ลื่นไหลและเร็วขึ้น",
    ["Smoother and faster"] = "ลื่นไหลและเร็วขึ้น",
    ["Less lag, quick to load."] = "แลคน้อยลง โหลดเร็วขึ้น",
    ["Less lag, quick to load"] = "แลคน้อยลง โหลดเร็วขึ้น",
    ["More steal methods"] = "มีวิธีขโมยไข่มากขึ้น",
    ["Teleport, Fast tween and more."] = "วาร์ป เคลื่อนที่เร็วแบบ Tween และอีกมากมาย",
    ["Teleport, Fast tween and more"] = "วาร์ป เคลื่อนที่เร็วแบบ Tween และอีกมากมาย",
    ["Teleport, Fast Tween and more."] = "วาร์ป เคลื่อนที่เร็วแบบ Tween และอีกมากมาย",
    ["Steal from players"] = "ขโมยไข่จากผู้เล่น",
    ["Hits whoever takes your egg."] = "โจมตีผู้ที่แย่งไข่ของคุณไป",
    ["Hits whoever takes your egg"] = "โจมตีผู้ที่แย่งไข่ของคุณไป",
    ["Easy setup"] = "ตั้งค่าง่าย",
    ["Bring your Chilli config over."] = "นำคอนฟิกจาก Chilli มาใช้ได้",
    ["Bring your Chilli config over"] = "นำคอนฟิกจาก Chilli มาใช้ได้",
}
for english,thai in pairs(ZIGZAG_V187_CHILLI_LABELS) do
    TRANSLATIONS[english] = thai
end

for english,thai in pairs(ZIGZAG_V184_CHILLI_LABELS) do
    if TRANSLATIONS[english] == nil then
        TRANSLATIONS[english] = thai
    end
end

--========================================================
-- 4. LOOKUP / CACHE  (V1.1 engine preserved)
--========================================================

local LOWER_TRANSLATIONS = {}
local TRANSLATED_OUTPUTS = {}
for english,thai in pairs(TRANSLATIONS) do
    LOWER_TRANSLATIONS[string.lower(english)] = thai
    TRANSLATED_OUTPUTS[thai] = true
end
local STRING_CACHE = {}

--========================================================
-- 5. HELPERS
--========================================================

local function CleanText(text)
    if type(text) ~= "string" then return "" end
    local clean = text:gsub("<[^>]+>", "")
    return clean:match("^%s*(.-)%s*$") or clean
end

local function TranslateState(value)
    local lower = string.lower(value or "")
    if lower == "off" then return "ปิด"
    elseif lower == "on" then return "เปิด"
    elseif lower == "idle" then return "ว่าง"
    elseif lower == "none" then return "ไม่มี"
    elseif lower == "default" then return "ค่าเริ่มต้น" end
    return value
end

--========================================================
-- 6. TRANSLATE
--========================================================

local function TranslateText(text)
    if type(text) ~= "string" or text == "" then return text end
    local cached = STRING_CACHE[text]
    if cached ~= nil then return cached end
    local clean = CleanText(text)
    if clean == "" then
        STRING_CACHE[text] = text
        return text
    end

    if TRANSLATED_OUTPUTS[clean] then
        STRING_CACHE[text] = clean
        return clean
    end

    local exact = LOWER_TRANSLATIONS[string.lower(clean)]
    if exact then
        STRING_CACHE[text] = exact
        return exact
    end

    -- V1.8.7 • Mutation capacity (e.g. "20 egg(s) can be mutated")
    local mutatableCount = string.lower(clean):match("^(%d+)%s+egg%(s%)%s+can%s+be%s+mutated%.?$")
        or string.lower(clean):match("^(%d+)%s+eggs?%s+can%s+be%s+mutated%.?$")
    if mutatableCount then
        local result = "มีไข่ที่กลายพันธุ์ได้ " .. mutatableCount .. " ฟอง"
        STRING_CACHE[text] = result
        return result
    end

    -- V1.8.6 • numeric/dynamic event status, no extra UI watchers.
    local hollowState,hollowWins,hollowTotal =
        clean:match("^(%a+)%s*|%s*Wins:%s*(%d+)%s*/%s*(%d+)$")
    if hollowState and (string.lower(hollowState)=="off" or string.lower(hollowState)=="on") then
        local result = TranslateState(hollowState) .. " | ชัยชนะ: " .. hollowWins .. "/" .. hollowTotal
        STRING_CACHE[text] = result
        return result
    end
    local hollowWinsOnly,hollowTotalOnly = clean:match("^Wins:%s*(%d+)%s*/%s*(%d+)$")
    if hollowWinsOnly then
        local result = "ชัยชนะ: " .. hollowWinsOnly .. "/" .. hollowTotalOnly
        STRING_CACHE[text] = result
        return result
    end
    local minutes = clean:match("^(%d+)%s+min$")
    if minutes then
        local result = minutes .. " นาที"
        STRING_CACHE[text] = result
        return result
    end
    local nextTask = clean:match("^NEXT%s+(%d+)$")
    if nextTask then
        local result = "ถัดไป " .. nextTask
        STRING_CACHE[text] = result
        return result
    end


    -- V1.7: Dynamic race countdown (example: Off | Next Racing Event in 17:12)
    -- Exact race labels are mapped above; the rest of the translator is untouched.
    local raceState,raceCountdown =
        clean:match("^(%a+)%s*|%s*Next Racing Event in%s*(.+)$")
    if raceState and raceCountdown then
        local stateLower = string.lower(raceState)
        if stateLower == "off" or stateLower == "on" then
            local result = TranslateState(stateLower)
                .. " | กิจกรรมแข่งวิ่งครั้งถัดไปใน " .. raceCountdown
            STRING_CACHE[text] = result
            return result
        end
    end

    local rarityNumber,rarityName = clean:match("^(%d+)%s*%-%s*(.-)%s*$")
    if rarityNumber and rarityName then
        local rarityThai = LOWER_TRANSLATIONS[string.lower(rarityName)]
        if rarityThai then
            local result = rarityNumber .. " - " .. rarityThai
            STRING_CACHE[text] = result
            return result
        end
    end

    local sortMode = clean:match("^Sort:?%s*(.+)$")
    if sortMode then
        local sortThai = LOWER_TRANSLATIONS[string.lower(CleanText(sortMode))] or sortMode
        local result = "เรียงตาม: " .. sortThai
        STRING_CACHE[text] = result
        return result
    end

    -- V1.2 FIX: Lua patterns do not use (ON|OFF) alternation.
    -- Exact mappings above handle all four ON/OFF UI labels.
    -- This branch remains for dynamic variants of the same statuses.
    local autoStealState = clean:match("^Auto Steal:%s*(%u+)$")
    if autoStealState == "ON" or autoStealState == "OFF" then
        local result = "ออโต้ขโมย: " .. TranslateState(string.lower(autoStealState))
        STRING_CACHE[text] = result
        return result
    end

    local instantStealState = clean:match("^Instant Steal:%s*(%u+)$")
    if instantStealState == "ON" or instantStealState == "OFF" then
        local result = "ขโมยทันที: " .. TranslateState(string.lower(instantStealState))
        STRING_CACHE[text] = result
        return result
    end

    local startupConfig = clean:match("^Startup Config:%s*(.+)$")
    if startupConfig then
        local result = "คอนฟิกเริ่มต้น: " .. TranslateState(startupConfig)
        STRING_CACHE[text] = result
        return result
    end
    local autoSaveConfig = clean:match("^Auto save:%s*(.+)$")
    if autoSaveConfig then
        local result = "บันทึกอัตโนมัติ: " .. TranslateState(autoSaveConfig)
        STRING_CACHE[text] = result
        return result
    end
    local autoLoadConfig = clean:match("^Auto load:%s*(.+)$")
    if autoLoadConfig then
        local result = "โหลดอัตโนมัติ: " .. TranslateState(autoLoadConfig)
        STRING_CACHE[text] = result
        return result
    end
    local saveConfig = clean:match("^Save:%s*(.+)$")
    if saveConfig then
        local result = "บันทึก: " .. TranslateState(saveConfig)
        STRING_CACHE[text] = result
        return result
    end

    local allCount = clean:match("^ALL%s+(%d+)$")
    if allCount then
        local result = "ทั้งหมด " .. allCount
        STRING_CACHE[text] = result
        return result
    end
    local readyCount = clean:match("^READY%s+(%d+)$")
    if readyCount then
        local result = "พร้อม " .. readyCount
        STRING_CACHE[text] = result
        return result
    end
    local growingCount = clean:match("^GROWING%s+(%d+)$")
    if growingCount then
        local result = "กำลังโต " .. growingCount
        STRING_CACHE[text] = result
        return result
    end
    local inBagCount = clean:match("^IN BAG%s+(%d+)$")
    if inBagCount then
        local result = "ในกระเป๋า " .. inBagCount
        STRING_CACHE[text] = result
        return result
    end
    local currentEgg,totalEggsByValue = clean:match("^#(%d+)%s+of%s+(%d+)%s+eggs%s+by%s+value$")
    if currentEgg then
        local result = "#" .. currentEgg .. " จาก " .. totalEggsByValue .. " ไข่ เรียงตามมูลค่า"
        STRING_CACHE[text] = result
        return result
    end
    local a,b = clean:match("^Players%s+(%d+)%/(%d+)$")
    if a then
        local result = "ผู้เล่น " .. a .. "/" .. b
        STRING_CACHE[text] = result
        return result
    end
    local selected = clean:match("^(%d+)%s+selected$")
    if selected then
        local result = "เลือกแล้ว " .. selected .. " รายการ"
        STRING_CACHE[text] = result
        return result
    end
    local quick = clean:match("^Quick Bar%s*(%d+)$")
    if quick then
        local result = "แถบลัด " .. quick
        STRING_CACHE[text] = result
        return result
    end
    local mechPortalTime = clean:match("^Next Mech portal in%s+(.+)$")
    if mechPortalTime then
        local result = "ประตู Mech ครั้งถัดไปใน " .. mechPortalTime
        STRING_CACHE[text] = result
        return result
    end
    local petMatches,petValue = clean:match("^Pet matches%s*%-%s*(%d+)%s+pets?%s+for%s+%$(.+)$")
    if petMatches then
        local result = "สัตว์เลี้ยงที่ตรงเงื่อนไข - " .. petMatches .. " ตัว มูลค่า $" .. petValue
        STRING_CACHE[text] = result
        return result
    end
    local eggMatches,eggMatchValue = clean:match("^Egg matches%s*%-%s*(%d+)%s+eggs?%s+for%s+%$(.+)$")
    if eggMatches then
        local result = "ไข่ที่ตรงเงื่อนไข - " .. eggMatches .. " ฟอง มูลค่า $" .. eggMatchValue
        STRING_CACHE[text] = result
        return result
    end
    local fuseAmount,fuseSpecies,fuseValue = clean:match("^Next fuse%s*%-%s*(%d+)%s+(.+)%s+for%s+%$(.+)$")
    if fuseAmount then
        local result = "การผสมถัดไป - " .. fuseAmount .. " " .. fuseSpecies .. " มูลค่า $" .. fuseValue
        STRING_CACHE[text] = result
        return result
    end
    local favMatches,favToMark,favDone = clean:match("^Favorite matches%s*%-%s*(%d+)%s+pets?,%s*(%d+)%s+to mark%s*|%s*(%d+)%s+favorited$")
    if favMatches then
        local result = "ตรงเงื่อนไข " .. favMatches .. " ตัว | ต้องกด " .. favToMark .. " ตัว | กดถูกใจแล้ว " .. favDone .. " ตัว"
        STRING_CACHE[text] = result
        return result
    end
    local bloomState,bloomLeft = clean:match("^(%a+)%s*|%s*Butterfly Bloom live,%s*(.-)%s+left$")
    if bloomState and (string.lower(bloomState) == "on" or string.lower(bloomState) == "off") then
        local result = TranslateState(bloomState) .. " | กิจกรรมผีเสื้อผลิบานกำลังทำงาน เหลือ " .. bloomLeft
        STRING_CACHE[text] = result
        return result
    end
    local bloomOnly = clean:match("^Butterfly Bloom live,%s*(.-)%s+left$")
    if bloomOnly then
        local result = "กิจกรรมผีเสื้อผลิบานกำลังทำงาน เหลือ " .. bloomOnly
        STRING_CACHE[text] = result
        return result
    end
    local charges,eggsNow,eggsMax,tries,applied = clean:match("^Charges%s+(%d+)%s+Eggs%s+(%d+)%/(%d+)%s+Tries%s+(%d+)%s+Applied%s+(%d+)$")
    if charges then
        local result = "ชาร์จ " .. charges .. " | ไข่ " .. eggsNow .. "/" .. eggsMax .. " | ลอง " .. tries .. " | ใช้แล้ว " .. applied
        STRING_CACHE[text] = result
        return result
    end
    local banner,needed,pity,rerolls,rotateTime = clean:match("^(.-)%s*%-%s*needs%s*(.-)%s*%-%s*pity%s*(.-)%s*%-%s*free rerolls%s*(.-)%s*%-%s*rotates in%s*(.-)$")
    if banner then
        local bannerClean = banner:match("^%s*(.-)%s*$")
        local bannerThai = LOWER_TRANSLATIONS[string.lower(bannerClean)] or bannerClean
        local result = bannerThai .. " - ต้องการ " .. needed .. " - การันตี " .. pity .. " - สุ่มฟรี " .. rerolls .. " - เปลี่ยนใน " .. rotateTime
        STRING_CACHE[text] = result
        return result
    end
    local eggCount,value = clean:match("^Lab egg matches%s*%-%s*(%d+)%s*eggs%s*for%s*%$(.*)$")
    if eggCount then
        local result = "เจอไข่แล็บเข้าเงื่อนไข " .. eggCount .. " ฟอง มูลค่า $" .. value
        STRING_CACHE[text] = result
        return result
    end
    local lastSteal = clean:match("^Last Steal:%s*(.+)$")
    if lastSteal then
        local result = "การขโมยล่าสุด: " .. TranslateState(lastSteal)
        STRING_CACHE[text] = result
        return result
    end
    local lastIssue = clean:match("^Last issue:%s*(.+)$")
    if lastIssue then
        local result = "ปัญหาล่าสุด: " .. TranslateState(lastIssue)
        STRING_CACHE[text] = result
        return result
    end
    local lastSell = clean:match("^Last Sell:%s*(.+)$")
    if lastSell then
        local result = "การขายล่าสุด: " .. TranslateState(lastSell)
        STRING_CACHE[text] = result
        return result
    end
    local lastFuse = clean:match("^Last Fuse:%s*(.+)$")
    if lastFuse then
        local result = "การผสมล่าสุด: " .. TranslateState(lastFuse)
        STRING_CACHE[text] = result
        return result
    end

    -- Safe partial replacements from original engine only.
    local result = clean
    result = result:gsub("UPDATED%s*&%s*WORKING", "อัปเดตแล้วและใช้งานได้")
    result = result:gsub("EXPERIMENTAL%s*/%s*NO UPDATES", "ทดลอง / ไม่มีอัปเดต")
    result = result:gsub("Only for Chase mode", "ใช้เฉพาะโหมดไล่จับ")
    if result ~= clean then
        STRING_CACHE[text] = result
        return result
    end
    STRING_CACHE[text] = text
    return text
end

--========================================================
-- 7-9. TEXT OBJECT / APPLY / DYNAMIC WATCHING
--========================================================

local function IsTextObject(object)
    return object:IsA("TextLabel") or object:IsA("TextButton") or object:IsA("TextBox")
end
local Busy = setmetatable({}, {__mode="k"})
local Watched = setmetatable({}, {__mode="k"})

local function ApplyTranslation(object,shouldWatch)
    if not IsTextObject(object) or Busy[object] then return false end
    Busy[object] = true
    local changed = false
    pcall(function()
        local oldText = object.Text
        local newText = TranslateText(oldText)
        if newText ~= oldText then
            object.Text = newText
            changed = true
        end
    end)
    if object:IsA("TextBox") then
        pcall(function()
            local oldText = object.PlaceholderText
            local newText = TranslateText(oldText)
            if newText ~= oldText then
                object.PlaceholderText = newText
                changed = true
            end
        end)
    end
    Busy[object] = nil
    if shouldWatch and not Watched[object] then
        Watched[object] = true
        Bind(object:GetPropertyChangedSignal("Text"):Connect(function()
            if Busy[object] or not object.Parent then return end
            ApplyTranslation(object,false)
        end))
        if object:IsA("TextBox") then
            Bind(object:GetPropertyChangedSignal("PlaceholderText"):Connect(function()
                if Busy[object] or not object.Parent then return end
                ApplyTranslation(object,false)
            end))
        end
    end
    return changed
end

--========================================================
-- 10-14. ROOTS / DETECTION / CHILLI TRACKER
--========================================================

local UI_ROOTS = {}
local function AddRoot(root)
    if not root then return false end
    for _,existing in ipairs(UI_ROOTS) do
        if existing == root then return false end
    end
    table.insert(UI_ROOTS,root)
    return true
end
AddRoot(PlayerGui)
AddRoot(CoreGui)
if type(gethui) == "function" then
    local ok,hui = pcall(gethui)
    if ok and hui then AddRoot(hui) end
end
local function IsKnownRoot(object)
    for _,root in ipairs(UI_ROOTS) do
        if object == root then return true end
    end
    return false
end
local function IsChilliTitle(object)
    if not IsTextObject(object) then return false end
    local ok,text = pcall(function() return object.Text end)
    if not ok or type(text) ~= "string" then return false end
    return string.lower(text):find("chilli hub",1,true) ~= nil
end
local function FindChilliContainer(object)
    if not object then return nil end
    local current = object
    local fallback = nil
    while current do
        if current:IsA("ScreenGui") then return current end
        if current:IsA("Frame") or current:IsA("CanvasGroup") or current:IsA("ScrollingFrame") then
            fallback = current
        end
        local parent = current.Parent
        if parent and IsKnownRoot(parent) then return current end
        current = parent
    end
    return fallback
end
--========================================================
-- ZIGZAG V1.6 DR-FIX PURPLE / BLACK THEME (THAI ENGINE ISOLATED)
-- Logo asset from ZIGZAG BF: rbxassetid://104570286698558
-- Theme touches visual properties only; new watermark is very translucent.
-- It NEVER modifies .Text / .PlaceholderText / translation caches.
--========================================================

local ZIGZAG_LOGO = "rbxassetid://104570286698558"
local THEME_ORIGINAL = setmetatable({}, {__mode="k"})
local THEME_WATCHED = setmetatable({}, {__mode="k"})
local THEME_WRITING = setmetatable({}, {__mode="k"})
local THEME_PENDING = setmetatable({}, {__mode="k"})
local THEME_LOGOS = {}  -- header icon only; no floating watermark / no ZIndex changes

-- DR-FIX 2: after clicking Chilli recreates/recolors the same UI objects.
-- Prior DR-FIX remembered THEME_STYLED and refused to repaint an object
-- once it had been purple; later source updates could turn its lower border
-- red again. This version re-applies only when a relevant visual property
-- actually changes, instead of repeatedly rescanning the whole UI.
local function IsRedAccent(color)
    if typeof(color) ~= "Color3" then return false end
    local r,g,b = color.R,color.G,color.B
    return r >= 0.43 and r > g * 1.37 and r > b * 1.28
        and (r - math.max(g,b)) > 0.19
end

local function PurpleFromRed(color)
    local _,s,v = Color3.toHSV(color)
    return Color3.fromHSV(0.765, math.clamp(s*0.93,0.48,0.94),
        math.clamp(v*0.96,0.30,1))
end

local function SaveStyle(object,property,newValue)
    local orig = THEME_ORIGINAL[object]
    if not orig then
        orig = {}
        THEME_ORIGINAL[object] = orig
    end
    if orig[property] == nil then
        local ok,value = pcall(function() return object[property] end)
        if not ok then return end
        orig[property] = value
    end
    if THEME_WRITING[object] then return end
    THEME_WRITING[object] = true
    pcall(function() object[property] = newValue end)
    THEME_WRITING[object] = nil
end

local function IsLargeThemeSurface(object)
    if not object or not object:IsA("GuiObject") then return false end
    local ok,w,h = pcall(function()
        local size = object.AbsoluteSize
        return size.X,size.Y
    end)
    if not ok then return false end
    if w < 85 and h < 28 then
        local sx = object.Size
        if sx.X.Offset < 85 and sx.X.Scale < 0.18 then return false end
    end
    return w >= 85 or object.Size.X.Offset >= 85
        or (object.Size.X.Scale >= 0.18 and h >= 27)
end

local function ParentVisualSurface(object)
    if not object then return nil end
    local parent = object.Parent
    if parent and parent:IsA("UIStroke") then parent = parent.Parent end
    return parent
end

local function IsThemeVisual(object)
    if not object then return false end
    if object.Name == "ZIGZAG_ThemeLogo_V14"
        or object.Name == "ZIGZAG_BackgroundWatermark_V15"
        or object.Name == "ZIGZAG_THEME_WALLPAPER" then return false end
    if object:IsA("UIStroke") or object:IsA("UIGradient") then
        return IsLargeThemeSurface(ParentVisualSurface(object))
    end
    return object:IsA("GuiObject") and IsLargeThemeSurface(object)
        and (object:IsA("Frame") or object:IsA("TextButton")
          or object:IsA("ImageButton") or object:IsA("ScrollingFrame")
          or object:IsA("TextLabel") or object:IsA("ImageLabel"))
end

local function RepaintRedProperty(object,property)
    local ok,color=pcall(function() return object[property] end)
    if ok and IsRedAccent(color) then
        SaveStyle(object,property,PurpleFromRed(color))
    end
end

local function RepaintGradient(object)
    local ok,gradient=pcall(function() return object.Color end)
    if not ok or not gradient then return end
    local points,changed={},false
    for _,pt in ipairs(gradient.Keypoints) do
        local color=pt.Value
        if IsRedAccent(color) then
            color=PurpleFromRed(color)
            changed=true
        end
        table.insert(points,ColorSequenceKeypoint.new(pt.Time,color))
    end
    if changed then SaveStyle(object,"Color",ColorSequence.new(points)) end
end

-- One listener per eligible property, no while loop / no RenderStepped.
-- task.defer coalesces successive changes in the same UI update.
local function WatchThemeProperty(object,property)
    local seen=THEME_WATCHED[object]
    if not seen then
        seen={}
        THEME_WATCHED[object]=seen
    end
    if seen[property] then return end
    seen[property]=true
    local ok,conn=pcall(function()
        return object:GetPropertyChangedSignal(property):Connect(function()
            if THEME_WRITING[object] or not object.Parent then return end
            local pending=THEME_PENDING[object]
            if not pending then
                pending={}
                THEME_PENDING[object]=pending
            end
            if pending[property] then return end
            pending[property]=true
            task.defer(function()
                pending[property]=nil
                if not object.Parent or not IsThemeVisual(object) then return end
                if object:IsA("UIGradient") then
                    RepaintGradient(object)
                else
                    RepaintRedProperty(object,property)
                end
            end)
        end)
    end)
    if ok and conn then
        Bind(conn)
    else
        seen[property]=nil
    end
end

local function ThemeObject(object)
    if not object or not object.Parent or not IsThemeVisual(object) then return end
    if object:IsA("UIGradient") then
        RepaintGradient(object)
        WatchThemeProperty(object,"Color")
        return
    end
    if object:IsA("UIStroke") then
        RepaintRedProperty(object,"Color")
        WatchThemeProperty(object,"Color")
        return
    end

    -- Handles Chilli's bottom red strip (Frame.BackgroundColor3),
    -- border outlines and tab-button colors without changing text.
    RepaintRedProperty(object,"BackgroundColor3")
    RepaintRedProperty(object,"BorderColor3")
    WatchThemeProperty(object,"BackgroundColor3")
    WatchThemeProperty(object,"BorderColor3")

    -- Only recolor explicitly red-tinted GUI art, not colored icons.
    if object:IsA("ImageLabel") or object:IsA("ImageButton") then
        RepaintRedProperty(object,"ImageColor3")
        WatchThemeProperty(object,"ImageColor3")
    end

    -- Preserve dark-purple surfaces, but don't force transparency or ZIndex.
    if object:IsA("Frame") or object:IsA("ScrollingFrame") then
        pcall(function()
            if object.BackgroundTransparency >= 0.65 then return end
            local bg=object.BackgroundColor3
            local r,g,b=bg.R,bg.G,bg.B
            local w,h=object.AbsoluteSize.X,object.AbsoluteSize.Y
            if math.abs(r-g)<0.07 and math.abs(r-b)<0.07
                and r<0.19 and w>=180 and h>=65 then
                SaveStyle(object,"BackgroundColor3",Color3.fromRGB(20,12,31))
            end
        end)
    end
end

local function PlaceZigzagLogo(title)
    if not title or not title.Parent then return end
    if not IsChilliTitle(title) then return end
    local host = title.Parent
    if not host:IsA("GuiObject") or host.AbsoluteSize.Y > 145 then
        host = title
    end
    if not host:IsA("GuiObject") then return end
    local existing = host:FindFirstChild("ZIGZAG_ThemeLogo_V14")
    if existing then return end
    local icon = Instance.new("ImageLabel")
    icon.Name = "ZIGZAG_ThemeLogo_V14"
    icon.BackgroundTransparency = 1
    icon.Active = false
    icon.Selectable = false
    icon.ScaleType = Enum.ScaleType.Fit
    icon.Image = ZIGZAG_LOGO
    icon.ImageTransparency = 0.02
    icon.AnchorPoint = Vector2.new(0,0.5)
    icon.Position = UDim2.new(0,12,0.5,0)
    icon.Size = UDim2.new(0,54,0,54)
    icon.ZIndex = title.ZIndex + 1
    icon.Parent = host
    table.insert(THEME_LOGOS,icon)
end

--========================================================
-- V1.5: ONE VERY FAINT ZIGZAG LOGO BEHIND MAIN CONTENT.
-- Adds no translation listeners and NEVER sets Text / PlaceholderText.
-- Does not change green switches or the game's background.
--========================================================
local function PlaceZigzagWatermark(gui)
    -- DR-FIX 1 SAFETY: disabled pending a verified non-interfering parent.
    -- V1.6 previously raised the ZIndex of every descendant of a guessed
    -- content frame. That could alter draw/hit-test order and obscure rows.
    -- Keep header ZIGZAG icon and purple color theme; never mutate layout.
    return
end

local function RestoreZigzagTheme()
    for object,props in pairs(THEME_ORIGINAL) do
        for property,original in pairs(props) do
            pcall(function() object[property] = original end)
        end
    end
    for _,icon in ipairs(THEME_LOGOS) do
        pcall(function() icon:Destroy() end)
    end
    table.clear(THEME_LOGOS)
end

-- Theme and watermark clean up automatically when rerun in the same session.
STATE.RestoreTheme = RestoreZigzagTheme
local DisconnectTranslations = STATE.Disconnect
function STATE.Disconnect()
    DisconnectTranslations()  -- stop theme property signals before restoring
    RestoreZigzagTheme()
end

local MainChilliGui = nil
local ChilliConnections = {}
local function DisconnectChilli()
    for _,connection in ipairs(ChilliConnections) do
        pcall(function() connection:Disconnect() end)
    end
    table.clear(ChilliConnections)
    MainChilliGui = nil
end
local function BindChilli(connection)
    if connection then
        table.insert(ChilliConnections,connection)
        Bind(connection)
    end
    return connection
end
--========================================================
-- DR. SCRAMBLE EMPTY AREA GUARD (iPad / low-lag)
-- Operates only on the Chilli content ScrollingFrame, if one is found.
-- No UI reconstruction, no feature toggles, no Text edits.
--========================================================
local UserInputService = game:GetService("UserInputService")
local DR_TITLES = setmetatable({}, {__mode="k"})
local DR_SCROLLS = setmetatable({}, {__mode="k"})
local DR_PENDING = setmetatable({}, {__mode="k"})
local DR_CLICK_GUARD_BOUND = false
local DR_LAST_TAP = 0

local function IsDrTitle(object)
    if not IsTextObject(object) then return false end
    local ok,label = pcall(function() return object.Text end)
    if not ok or type(label) ~= "string" then return false end
    label = string.lower(CleanText(label))
    return (string.find(label,"scramble",1,true) ~= nil
        and (string.find(label,"dr.",1,true) ~= nil
           or string.find(label,"dr ",1,true) ~= nil))
        and (string.find(label,"ห้องแล็บ",1,true) ~= nil
             or string.find(label,"lab",1,true) ~= nil)
end

local function IsGuiVisible(object)
    local current=object
    while current and current ~= MainChilliGui do
        if current:IsA("GuiObject") and not current.Visible then return false end
        current=current.Parent
    end
    return true
end

local function GetDrScroller(title,gui)
    local current=title and title.Parent
    while current and current~=gui do
        if current:IsA("ScrollingFrame") then return current end
        current=current.Parent
    end
    -- Some Chilli builds position the title beside, not within, the scroller.
    -- Find only a centered, on-screen scroll area below the title.
    if not title or not title.Parent then return nil end
    local center=title.AbsolutePosition.X+title.AbsoluteSize.X*0.5
    local top=title.AbsolutePosition.Y
    local best,bestScore=nil,-math.huge
    for _,item in ipairs(gui:GetDescendants()) do
        if item:IsA("ScrollingFrame") and IsGuiVisible(item) then
            local pos,size=item.AbsolutePosition,item.AbsoluteSize
            local mid=pos.X+size.X*0.5
            if size.X>=220 and size.Y>=110 and math.abs(mid-center)<size.X*0.55
                and pos.Y<top+180 and pos.Y+size.Y>top+100 then
                local score=size.X*size.Y/1000-math.abs(mid-center)
                if score>bestScore then best,bestScore=item,score end
            end
        end
    end
    return best
end

local function GetDirectContentHeight(scroller)
    local height=nil
    for _,child in ipairs(scroller:GetChildren()) do
        if child:IsA("UIListLayout") or child:IsA("UIGridLayout") then
            local ok,content=pcall(function() return child.AbsoluteContentSize.Y end)
            if ok and content and content>0 then height=math.max(height or 0,content) end
        end
    end
    return height
end

local function FixOverscroll(scroller)
    if not scroller or not scroller.Parent then return end
    local ok,err=pcall(function()
        local contentHeight=GetDirectContentHeight(scroller)
        if not contentHeight then return end  -- do not guess canvas height
        local viewHeight=scroller.AbsoluteWindowSize.Y
        if viewHeight<32 then return end
        local padding=22
        local maxY=math.max(0,contentHeight+padding-viewHeight)
        local y=scroller.CanvasPosition.Y
        if y>maxY+8 then
            scroller.CanvasPosition=Vector2.new(scroller.CanvasPosition.X,maxY)
            print("[ZIGZAG DR-FIX] corrected empty scroll region",math.floor(y),"->",math.floor(maxY))
        end
    end)
    if not ok then warn("[ZIGZAG DR-FIX] scroll check:",err) end
end

local function ScheduleDrScrollCheck(scroller)
    if not scroller or not scroller.Parent or DR_PENDING[scroller] then return end
    DR_PENDING[scroller]=true
    task.delay(0.20,function()
        DR_PENDING[scroller]=nil
        if scroller.Parent and MainChilliGui and scroller:IsDescendantOf(MainChilliGui) then
            FixOverscroll(scroller)
        end
    end)
end

local function WatchDrScroll(scroller)
    if not scroller or DR_SCROLLS[scroller] then return end
    DR_SCROLLS[scroller]=true
    -- Property and layout listeners, not a perpetual descendant scan.
    BindChilli(scroller:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
        ScheduleDrScrollCheck(scroller)
    end))
    for _,child in ipairs(scroller:GetChildren()) do
        if child:IsA("UIListLayout") or child:IsA("UIGridLayout") then
            BindChilli(child:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                ScheduleDrScrollCheck(scroller)
            end))
        end
    end
end

local function HandleDrHeaderTap(title)
    local gui=MainChilliGui
    if not gui or not gui.Parent or not title or not title.Parent then return end
    task.delay(0.22,function()
        if MainChilliGui~=gui or not title.Parent then return end
        local scroller=GetDrScroller(title,gui)
        if not scroller then
            warn("[ZIGZAG DR-FIX] Dr title found, no matching ScrollingFrame; original Chilli UI controls the rows")
            return
        end
        WatchDrScroll(scroller)
        FixOverscroll(scroller)
        -- A stale scroll offset can leave the expanded DR section visually empty.
        -- On tap, start at the top of the existing content; never create fake rows.
        if scroller.CanvasPosition.Y>0 then
            scroller.CanvasPosition=Vector2.new(scroller.CanvasPosition.X,0)
        end
    end)
end

local function WatchDrHeader(object)
    if not IsDrTitle(object) then return end
    DR_TITLES[object]=true
    if DR_CLICK_GUARD_BOUND then return end
    DR_CLICK_GUARD_BOUND=true
    Bind(UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType~=Enum.UserInputType.Touch
            and input.UserInputType~=Enum.UserInputType.MouseButton1 then return end
        local pos=input.Position
        for title in pairs(DR_TITLES) do
            if title.Parent and MainChilliGui and title:IsDescendantOf(MainChilliGui)
                and IsGuiVisible(title) then
                local at,size=title.AbsolutePosition,title.AbsoluteSize
                if size.X>20 and size.Y>8 and pos.X>=at.X-48 and pos.X<=at.X+size.X+14
                    and pos.Y>=at.Y-6 and pos.Y<=at.Y+size.Y+6 then
                    local now=os.clock()
                    if now-DR_LAST_TAP>0.15 then
                        DR_LAST_TAP=now
                        HandleDrHeaderTap(title)
                    end
                    break
                end
            end
        end
    end))
end

local function TrackChilli(gui)
    if not gui or not gui.Parent then return end
    if MainChilliGui == gui and gui.Parent then return end
    DisconnectChilli()
    MainChilliGui = gui
    for _,object in ipairs(gui:GetDescendants()) do
        ApplyTranslation(object,true)
        ThemeObject(object)
        WatchDrHeader(object)
        if IsChilliTitle(object) then PlaceZigzagLogo(object) end
    end
    BindChilli(gui.DescendantAdded:Connect(function(object)
        if IsTextObject(object) then
            ApplyTranslation(object,true)
            WatchDrHeader(object)
            if IsChilliTitle(object) then PlaceZigzagLogo(object) end
        end
        ThemeObject(object)
        -- Chilli sometimes parents a border before assigning its size/color.
        -- Recheck this ONE new object, never rescan every descendant.
        if object:IsA("UIStroke") or object:IsA("UIGradient")
            or object:IsA("Frame") or object:IsA("TextButton")
            or object:IsA("ImageButton") or object:IsA("ImageLabel") then
            task.delay(0.18,function()
                if MainChilliGui==gui and object.Parent then ThemeObject(object) end
            end)
        end
        if IsTextObject(object) then
            task.defer(function()
                if MainChilliGui==gui and object.Parent then WatchDrHeader(object) end
            end)
        end
    end))
    -- Old watermark calls are harmless no-ops until a safe UI host is verified.
    task.delay(0.85,function()
        if MainChilliGui == gui and gui.Parent then PlaceZigzagWatermark(gui) end
    end)
    -- Two lightweight one-time passes to catch UI gradients initialized late.
    -- No RenderStepped, Heartbeat, or permanent scanning.
    task.delay(0.7,function()
        if MainChilliGui ~= gui or not gui.Parent then return end
        for _,object in ipairs(gui:GetDescendants()) do
            ThemeObject(object)
            if IsChilliTitle(object) then PlaceZigzagLogo(object) end
        end
        PlaceZigzagWatermark(gui)
    end)
    task.delay(2.0,function()
        if MainChilliGui ~= gui or not gui.Parent then return end
        for _,object in ipairs(gui:GetDescendants()) do
            ThemeObject(object)
        end
        PlaceZigzagWatermark(gui)
    end)
    BindChilli(gui.AncestryChanged:Connect(function()
        if not gui.Parent then DisconnectChilli() end
    end))
    print("✅ ZIGZAG attached to Chilli")
end

--========================================================
-- V1.7.9: SIDEBARS FORCE-PURPLE FIX (LABEL-ANCHORED)
-- V1.7.8 only looked for a TextButton ANCESTOR, but Chilli often
-- builds sidebars as a Frame + TextLabel. It also only recolored
-- red at discovery, so subsequent gradients could remain red.
-- This patch locates the actual sidebar rectangular surfaces and
-- gives THEM an event-driven purple theme even if the source
-- changes its accent after Halloween / color transitions.
-- It does NOT touch Chilli text, layout, panels, character, or
-- gameplay functions. No RenderStepped, while loop, or polling.
--========================================================
local SIDEBAR_NAMES = {
    ["ฟาร์ม"]=true,["Farm"]=true,
    ["ตัวละคร"]=true,["Character"]=true,["Player"]=true,
    ["คาดการณ์"]=true,["Predictor"]=true,
    ["ความคืบหน้า"]=true,["Progress"]=true,
    ["เซิร์ฟเวอร์"]=true,["Server"]=true,
    ["อื่นๆ"]=true,["Misc"]=true,
    ["ออโต้ย้ายเซิร์ฟเวอร์"]=true,["Auto Server Hop"]=true,
    ["กิจกรรมแอดมิน"]=true,["Admin Abuse"]=true,
    ["ดิสคอร์ด"]=true,["Discord"]=true,
    ["คีย์ลัด"]=true,["Quick & Keys"]=true,
    ["การตั้งค่า"]=true,["Settings"]=true,
    ["คอนฟิก"]=true,["Config"]=true,
    -- Special 'Venyx' tab deliberately stays red, as in the
    -- original ZIGZAG purple layout, not in this whitelist.
}
local SIDEBAR_TOP = Color3.fromRGB(206,117,255)
local SIDEBAR_BOTTOM = Color3.fromRGB(144,46,218)
local SIDEBAR_FILL = Color3.fromRGB(168,68,233)
local SIDEBAR_TINT = Color3.fromRGB(184,89,246)
local SIDEBAR_GRADIENT = ColorSequence.new({
    ColorSequenceKeypoint.new(0,SIDEBAR_TOP),
    ColorSequenceKeypoint.new(1,SIDEBAR_BOTTOM),
})
local SIDEBAR_TRACKED = setmetatable({}, {__mode="k"})
local SIDEBAR_BUSY = setmetatable({}, {__mode="k"})
local SIDEBAR_LABEL_WATCHED = setmetatable({}, {__mode="k"})
local SIDEBAR_CHILD_WATCHED = setmetatable({}, {__mode="k"})
local SIDEBAR_GRADIENT_WATCHED = setmetatable({}, {__mode="k"})

local function SidebarShape(obj)
    if not obj or not obj:IsA("GuiObject") then return false end
    if obj:IsA("ScrollingFrame") then return false end
    local ok,w,h=pcall(function()
        return obj.AbsoluteSize.X,obj.AbsoluteSize.Y
    end)
    if not ok then return false end
    return w>=75 and w<=530 and h>=26 and h<=145 and w>=h*1.45
end

local function StyleSidebarGradient(gradient)
    if not gradient or not gradient.Parent or SIDEBAR_BUSY[gradient] then return end
    local ok,value=pcall(function() return gradient.Color end)
    if not ok or value==SIDEBAR_GRADIENT then return end
    SIDEBAR_BUSY[gradient]=true
    SaveStyle(gradient,"Color",SIDEBAR_GRADIENT)
    SIDEBAR_BUSY[gradient]=nil
end

local function WatchSidebarGradient(gradient)
    if not gradient or not gradient:IsA("UIGradient") then return end
    StyleSidebarGradient(gradient)
    if SIDEBAR_GRADIENT_WATCHED[gradient] then return end
    SIDEBAR_GRADIENT_WATCHED[gradient]=true
    Bind(gradient:GetPropertyChangedSignal("Color"):Connect(function()
        -- Synchronous correction, rather than one-frame task.defer flicker.
        if gradient.Parent and not SIDEBAR_BUSY[gradient] then
            StyleSidebarGradient(gradient)
        end
    end))
end

local function ForceSidebarPurple(surface)
    if not surface or not surface.Parent or SIDEBAR_BUSY[surface] then return end
    if not SidebarShape(surface) then return end
    SIDEBAR_BUSY[surface]=true
    pcall(function()
        -- Text labels are usually transparent; never paint their text boxes.
        if not surface:IsA("TextLabel") and not surface:IsA("TextBox") then
            if surface.BackgroundTransparency < 0.96
                and surface.BackgroundColor3 ~= SIDEBAR_FILL then
                SaveStyle(surface,"BackgroundColor3",SIDEBAR_FILL)
            end
            -- A full-sized image-button / image fill can also be the backdrop.
            if (surface:IsA("ImageLabel") or surface:IsA("ImageButton"))
                and surface.ImageTransparency < 0.95
                and surface.ImageColor3 ~= SIDEBAR_TINT then
                SaveStyle(surface,"ImageColor3",SIDEBAR_TINT)
            end
        end
        -- Keep existing black outlines; recolor only red ones.
        for _,child in ipairs(surface:GetChildren()) do
            if child:IsA("UIGradient") then
                WatchSidebarGradient(child)
            elseif child:IsA("UIStroke") then
                RepaintRedProperty(child,"Color")
            end
        end
    end)
    SIDEBAR_BUSY[surface]=nil
end

local function TrackSidebarSurface(surface)
    if not SidebarShape(surface) then return end
    ForceSidebarPurple(surface)
    if SIDEBAR_TRACKED[surface] then return end
    SIDEBAR_TRACKED[surface]=true
    -- Chilli recolors UI when switching tabs or when the map changes.
    -- These signals restore purple immediately without full-UI rescans.
    Bind(surface:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
        if surface.Parent then ForceSidebarPurple(surface) end
    end))
    if surface:IsA("ImageLabel") or surface:IsA("ImageButton") then
        Bind(surface:GetPropertyChangedSignal("ImageColor3"):Connect(function()
            if surface.Parent then ForceSidebarPurple(surface) end
        end))
    end
    if not SIDEBAR_CHILD_WATCHED[surface] then
        SIDEBAR_CHILD_WATCHED[surface]=true
        Bind(surface.ChildAdded:Connect(function(child)
            if child:IsA("UIGradient") then
                WatchSidebarGradient(child)
            elseif child:IsA("UIStroke") then
                RepaintRedProperty(child,"Color")
            elseif child:IsA("Frame") or child:IsA("ImageLabel")
                or child:IsA("ImageButton") or child:IsA("TextButton") then
                -- A new full-size colored backdrop underneath the label.
                task.defer(function()
                    if child.Parent and SidebarShape(child) then
                        TrackSidebarSurface(child)
                    end
                end)
            end
        end))
    end
end

local function StyleSidebarForText(object)
    if not IsTextObject(object) or not object.Parent then return end
    local ok,label=pcall(function() return CleanText(object.Text) end)
    if not ok or not SIDEBAR_NAMES[label] then return end
    local okPos,centerX,screenW=pcall(function()
        local camera=workspace.CurrentCamera
        local width=camera and camera.ViewportSize.X or 0
        return object.AbsolutePosition.X+object.AbsoluteSize.X*0.5,width
    end)
    -- Whitelist only edge-mounted sidebar menus; never color central
    -- settings, egg/pet dropdowns, or full-width UI overlays.
    if okPos and screenW>0 and centerX>screenW*0.36
        and centerX<screenW*0.64 then return end
    local current=object
    for depth=1,6 do
        if not current or current:IsA("ScreenGui") then break end
        if SidebarShape(current) and
            (current:IsA("Frame") or current:IsA("CanvasGroup")
             or current:IsA("TextButton") or current:IsA("ImageButton")
             or current:IsA("ImageLabel")) then
            TrackSidebarSurface(current)
            -- Chilli may use a Frame under a transparent clickable parent.
            -- Detect only siblings with the same size, not the whole menu.
            for _,child in ipairs(current:GetChildren()) do
                if child:IsA("Frame") or child:IsA("ImageLabel")
                    or child:IsA("ImageButton") or child:IsA("TextButton") then
                    if SidebarShape(child) then TrackSidebarSurface(child) end
                end
            end
        end
        current=current.Parent
    end
end

local function WatchSidebarLabel(object)
    if not IsTextObject(object) or SIDEBAR_LABEL_WATCHED[object] then return end
    -- Watch only rectangular edge text widgets. Source often sets .Text
    -- *after* parenting, making a one-time label match unreliable.
    local ok,centerX,w=pcall(function()
        return object.AbsolutePosition.X+object.AbsoluteSize.X*0.5,
            object.AbsoluteSize.X
    end)
    if not ok or w<55 then return end
    local camera=workspace.CurrentCamera
    local viewport=camera and camera.ViewportSize.X or 0
    if viewport>0 and centerX>viewport*0.36
        and centerX<viewport*0.64 then return end
    SIDEBAR_LABEL_WATCHED[object]=true
    Bind(object:GetPropertyChangedSignal("Text"):Connect(function()
        if object.Parent then StyleSidebarForText(object) end
    end))
    StyleSidebarForText(object)
end

local FLOATING_PANEL_ROOTS=setmetatable({},{__mode="k"})
local FLOATING_PANEL_TEXTS=setmetatable({},{__mode="k"})
local function WatchFloatingPanelText(object)
    if not IsTextObject(object) or FLOATING_PANEL_TEXTS[object] then return end
    FLOATING_PANEL_TEXTS[object]=true
    ApplyTranslation(object,true)
    Bind(object:GetPropertyChangedSignal("Text"):Connect(function()
        if object.Parent then ApplyTranslation(object,false) end
    end))
end
local function TrackFloatingPanel(container)
    if not container or FLOATING_PANEL_ROOTS[container] then return end
    FLOATING_PANEL_ROOTS[container]=true
    for _,o in ipairs(container:GetDescendants()) do
        WatchFloatingPanelText(o)
    end
    Bind(container.DescendantAdded:Connect(function(o)
        if o.Parent then WatchFloatingPanelText(o) end
    end))
end
local function IsStealPanelHeading(object)
    if not IsTextObject(object) then return false end
    local ok,t=pcall(function() return string.lower(CleanText(object.Text)) end)
    return ok and (t=="steal panel" or t=="แผงขโมย")
end
local function DetectFloatingPanel(object)
    if not IsStealPanelHeading(object) then return end
    local candidate=object
    for _=1,5 do
        if not candidate or candidate:IsA("ScreenGui") then break end
        if candidate:IsA("Frame") or candidate:IsA("CanvasGroup") then
            local size=candidate.AbsoluteSize
            if size.X>=180 and size.Y>=130 then
                TrackFloatingPanel(candidate)
                return
            end
        end
        candidate=candidate.Parent
    end
end

--========================================================
-- 15. LOOSE TARGET (expanded only for floating steal UI)
--========================================================

local function IsLooseTarget(object)
    if not IsTextObject(object) then return false end
    local ok,text = pcall(function() return object.Text end)
    if not ok or type(text) ~= "string" then return false end
    local lower = string.lower(CleanText(text))
    return lower == "anti guard"
        or lower == "anti guard panel"
        or lower == "steal panel"
        or lower == "auto steal: off"
        or lower == "auto steal: on"
        or lower == "instant steal: off"
        or lower == "instant steal: on"
end

--========================================================
-- 16-17. DISCOVERY / ROOT EVENT WATCHER (NO SCAN LOOP)
--========================================================

local function FindExistingChilli()
    if MainChilliGui and MainChilliGui.Parent then return true end
    for _,root in ipairs(UI_ROOTS) do
        local found = false
        pcall(function()
            for _,object in ipairs(root:GetDescendants()) do
                if IsChilliTitle(object) then
                    local gui = FindChilliContainer(object)
                    if gui then
                        TrackChilli(gui)
                        found = true
                        break
                    end
                end
            end
        end)
        if found then return true end
    end
    return false
end
local WatchedRoots = setmetatable({}, {__mode="k"})
local function WatchRoot(root)
    if not root or WatchedRoots[root] then return end
    WatchedRoots[root] = true
    Bind(root.DescendantAdded:Connect(function(object)
        if not IsTextObject(object) then return end
        task.defer(function()
            if object.Parent then
                WatchSidebarLabel(object)
                DetectFloatingPanel(object)
            end
        end)
        -- Three short initializations only for newly created candidate text.
        -- No endless retries and no recurring scan.
        task.delay(0.35,function()
            if object.Parent then WatchSidebarLabel(object) end
        end)
        if IsChilliTitle(object) then
            local gui = FindChilliContainer(object)
            if gui then TrackChilli(gui) end
            return
        end
        if IsLooseTarget(object) then
            ApplyTranslation(object,true)
            return
        end
        if MainChilliGui and MainChilliGui.Parent then
            local ok,text = pcall(function() return object.Text end)
            if ok and type(text) == "string" and text ~= "" then
                local translated = TranslateText(text)
                if translated ~= text then ApplyTranslation(object,true) end
            end
        end
    end))
end
for _,root in ipairs(UI_ROOTS) do
    WatchRoot(root)
    for _,object in ipairs(root:GetDescendants()) do
        if IsTextObject(object) then
            WatchSidebarLabel(object)
            DetectFloatingPanel(object)
        end
    end
end

-- V1.7.9: limited startup discovery in case Chilli paints text/gradients
-- after parenting. This runs at fixed times; there is no permanent loop.
local function CheckExistingSidebarButtons()
    for _,root in ipairs(UI_ROOTS) do
        if root and root.Parent then
            for _,object in ipairs(root:GetDescendants()) do
                if IsTextObject(object) then WatchSidebarLabel(object) end
            end
        end
    end
end
for _,delaySeconds in ipairs({0.65,1.6,3.8}) do
    task.delay(delaySeconds,CheckExistingSidebarButtons)
end


--========================================================
-- CHILLI MAIN + VENYX THAI / ZIGZAG V1.8.3 POPUP FIX
-- CHILLI remains the ONLY startup game loader.
-- VENYX UI translator is armed without loading its gameplay at startup.
-- Tapping the Chilli-side "Venyx" tab explicitly launches original Venyx
-- once per destination-server session; no automatic/gameplay hop reload.
--========================================================
local ZIGZAG_HYBRID_VENYX_SOURCE=
    "https://raw.githubusercontent.com/tienkhanh1/Venyx/main/VenyxHub"
local ZIGZAG_HYBRID_ENV=(type(getgenv)=="function" and getgenv()) or _G
local ZIGZAG_HYBRID_SESSION=tostring(game.PlaceId)..":"..tostring(game.JobId or "")
local ZIGZAG_HYBRID_VENYX_CORE=[===[
--==============================================================
-- VENYX STEAL AN EGG • THAI UI BY ZIGZAG • V1.9 (V1.8 TELEPORT SAFE + HALLOWEEN UI TRANSLATIONS)
-- Translation overlay only; external Venyx loader kept unchanged.
-- Only updates UI Text/PlaceholderText in detected Venyx/Steal Panel GUI.
-- Does not change steal/farm logic, character movement, or settings.
-- This file DOES NOT contain decrypted/protected Venyx source.
--==============================================================
local ENV = (type(getgenv) == "function" and getgenv()) or _G
local OLD = ENV.__ZIGZAG_VENYX_THAI_STATE
local HAD_LOADER = OLD and OLD.LoaderStarted
if OLD and type(OLD.Stop) == "function" then
    pcall(OLD.Stop)
end

local STATE = {
    Running = true,
    Connections = {},
    Observed = setmetatable({}, {__mode = "k"}),
    Roots = setmetatable({}, {__mode = "k"}),
    Busy = setmetatable({}, {__mode = "k"}),
    LoaderStarted = HAD_LOADER or false,
    Count = 0,
}
ENV.__ZIGZAG_VENYX_THAI_STATE = STATE
local function bind(conn)
    if conn then table.insert(STATE.Connections, conn) end
    return conn
end
function STATE.Stop()
    STATE.Running = false
    for _,conn in ipairs(STATE.Connections) do
        pcall(function() conn:Disconnect() end)
    end
    table.clear(STATE.Connections)
end

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local SOURCE_URL = "https://raw.githubusercontent.com/tienkhanh1/Venyx/main/VenyxHub"

-- Translations below come from all supplied Venyx v1.0.2 screenshots.
-- V1.3 translates visible option names (rarities, zones, racers, shop items)
-- only as GUI text; the game's actual option handlers/data are untouched.
local TH = {
    ["aa"] = "กิจกรรมแอดมิน",
    ["active"] = "กำลังใช้งาน",
    ["admin abuse"] = "กิจกรรมแอดมิน",
    ["after stealing a match"] = "หลังขโมยไข่ที่ตรงเงื่อนไข",
    ["all"] = "ทั้งหมด",
    ["all picked rules"] = "ตรงทุกเงื่อนไขที่เลือก",
    ["always"] = "ตลอดเวลา",
    ["anti guard"] = "หลบหลีกยาม",
    ["any picked rule"] = "ตรงอย่างน้อยหนึ่งเงื่อนไข",
    ["apply"] = "นำไปใช้",
    ["auto"] = "อัตโนมัติ",
    ["auto butterfly"] = "ทำผีเสื้ออัตโนมัติ",
    ["auto buy nitro"] = "ซื้อ Nitro อัตโนมัติ",
    ["auto buy shop"] = "ซื้อของในร้านอัตโนมัติ",
    ["auto buy trails"] = "ซื้อรอยเท้าอัตโนมัติ",
    ["auto catch shooting star"] = "จับดาวตกอัตโนมัติ",
    ["auto claim index rewards"] = "รับรางวัลสมุดอัตโนมัติ",
    ["auto claim offline cash"] = "รับเงินออฟไลน์อัตโนมัติ",
    ["auto claim rewards"] = "รับรางวัลอัตโนมัติ",
    ["auto equip"] = "สวมใส่อัตโนมัติ",
    ["auto equip racer"] = "เลือกตัวแข่งให้อัตโนมัติ",
    ["auto favorite"] = "เพิ่มรายการโปรดอัตโนมัติ",
    ["auto fuse"] = "ผสมอัตโนมัติ",
    ["auto hatch"] = "ฟักไข่อัตโนมัติ",
    ["auto hop"] = "ย้ายเซิร์ฟเวอร์อัตโนมัติ",
    ["auto hop server"] = "ย้ายเซิร์ฟเวอร์อัตโนมัติ",
    ["auto if empty"] = "สร้างชื่ออัตโนมัติหากเว้นว่าง",
    ["auto load"] = "โหลดอัตโนมัติ",
    ["auto load script"] = "โหลดสคริปต์อัตโนมัติ",
    ["auto mutate"] = "กลายพันธุ์อัตโนมัติ",
    ["auto place"] = "วางไข่อัตโนมัติ",
    ["auto race"] = "แข่งวิ่งอัตโนมัติ",
    ["auto save"] = "บันทึกอัตโนมัติ",
    ["auto sell eggs"] = "ขายไข่อัตโนมัติ",
    ["auto sell lab eggs"] = "ขายไข่แล็บอัตโนมัติ",
    ["auto sell pets"] = "ขายสัตว์เลี้ยงอัตโนมัติ",
    ["auto steal"] = "ขโมยไข่อัตโนมัติ",
    ["auto treadmill"] = "วิ่งลู่อัตโนมัติ",
    ["auto upgrade base"] = "อัปเกรดฐานอัตโนมัติ",
    ["auto upgrade treadmill"] = "เพิ่มระดับลู่อัตโนมัติ",
    ["background color"] = "สีพื้นหลัง",
    ["bar size"] = "ขนาดแถบปุ่มลัด",
    ["bases"] = "ฐานผู้เล่น",
    ["best"] = "ดีที่สุด",
    ["best mutation"] = "การกลายพันธุ์ดีที่สุด",
    ["best owned"] = "ตัวที่มีดีที่สุด",
    ["best rarity"] = "หายากที่สุด",
    ["best steal"] = "ไข่ที่ดีที่สุด",
    ["best value"] = "มูลค่าสูงสุด",
    ["biggest"] = "ตัวใหญ่ที่สุด",
    ["butterfly"] = "ผีเสื้อ",
    ["butterfly bloom"] = "ผีเสื้อผลิบาน",
    ["butterfly event"] = "กิจกรรมผีเสื้อ",
    ["butterfly machine"] = "เครื่องผีเสื้อ",
    ["buy"] = "ซื้อ",
    ["calculate mutations"] = "คำนวณผลจากการกลายพันธุ์",
    ["cancel"] = "ยกเลิก",
    ["cancel selection"] = "ยกเลิกการเลือก",
    ["cards show the value with these mutations added"] = "การ์ดแสดงมูลค่าหลังรวมการกลายพันธุ์ที่เลือก",
    ["cash"] = "เงินสด",
    ["catch"] = "จับดาว",
    ["caught"] = "จับได้แล้ว",
    ["change if steal fails"] = "ปรับเมื่อขโมยไม่สำเร็จ",
    ["chilli hub"] = "Chilli Hub",
    ["claim"] = "รับ",
    ["clear"] = "ล้าง",
    ["clear all keybinds"] = "ล้างปุ่มลัดคีย์บอร์ดทั้งหมด",
    ["clear all quick bars"] = "ล้างแถบปุ่มลัดทั้งหมด",
    ["close"] = "ปิด",
    ["closest"] = "ใกล้ที่สุด",
    ["common"] = "ทั่วไป",
    ["config"] = "ตั้งค่าโปรไฟล์",
    ["configuration"] = "การตั้งค่า",
    ["confirm"] = "ยืนยัน",
    ["copy"] = "คัดลอก",
    ["copy invite"] = "คัดลอกลิงก์เชิญ",
    ["copy job id"] = "คัดลอก Job ID",
    ["create"] = "สร้าง",
    ["create config"] = "สร้างโปรไฟล์",
    ["credits"] = "เครดิต",
    ["default"] = "ค่าเริ่มต้น",
    ["default config"] = "โปรไฟล์เริ่มต้น",
    ["delete"] = "ลบ",
    ["delete picked"] = "ลบโปรไฟล์ที่เลือก",
    ["delivering"] = "กำลังนำไข่กลับ",
    ["delivery speed"] = "ความเร็วในการนำไข่กลับ",
    ["delivery speed slider"] = "แถบปรับความเร็วส่งไข่",
    ["deselect all"] = "ยกเลิกทั้งหมด",
    ["dim the game"] = "ลดความสว่างเกม",
    ["disable 3d render"] = "ปิดการแสดงผลภาพ 3 มิติ",
    ["disabled"] = "ปิดการใช้งาน",
    ["discord"] = "ดิสคอร์ด",
    ["discord role id"] = "ID ยศ Discord",
    ["discord user id"] = "ID ผู้ใช้ Discord",
    ["discord webhook"] = "เว็บฮุก Discord",
    ["distance"] = "ระยะทาง",
    ["divine"] = "เทพเจ้า",
    ["doing"] = "กำลังทำ",
    ["done"] = "เสร็จแล้ว",
    ["dr. scramble"] = "Dr. Scramble",
    ["dr. scramble lab"] = "แล็บ Dr. Scramble",
    ["drop eggs at safe zone"] = "วางไข่ในเขตปลอดภัย",
    ["duration"] = "ระยะเวลา",
    ["egg"] = "ไข่",
    ["egg bag"] = "กระเป๋าไข่",
    ["egg predictor"] = "คาดการณ์ไข่",
    ["egg showcase"] = "แสดงรายการไข่",
    ["eggs"] = "ไข่",
    ["eject odd pets"] = "นำสัตว์เลี้ยงที่เกินออก",
    ["enabled"] = "เปิดการใช้งาน",
    ["enchanted"] = "ต้องมนตร์",
    ["enchanted forest"] = "ป่ามนตร์",
    ["epic"] = "มหากาพย์",
    ["equip best pets"] = "ใส่สัตว์เลี้ยงที่ดีที่สุด",
    ["error"] = "ข้อผิดพลาด",
    ["eternal"] = "นิรันดร์",
    ["event"] = "กิจกรรม",
    ["expires in"] = "หมดเวลาในอีก",
    ["export config"] = "ส่งออกโปรไฟล์",
    ["failed"] = "ไม่สำเร็จ",
    ["farm"] = "ฟาร์ม",
    ["fast tween to egg"] = "เคลื่อนที่แบบ Tween ไปหาไข่อย่างรวดเร็ว",
    ["favorite"] = "รายการโปรด",
    ["filter"] = "ตัวกรอง",
    ["find an option"] = "ค้นหาตัวเลือก",
    ["first"] = "อันดับแรก",
    ["first hop after"] = "เริ่มย้ายครั้งแรกหลัง",
    ["fix"] = "แก้ไข",
    ["fixed lag back with the tween delivery method"] = "แก้อาการแลคตอนกลับด้วยวิธีส่งแบบ Tween",
    ["fps cap"] = "จำกัด FPS",
    ["fractured"] = "แตกร้าว",
    ["frame rate"] = "อัตราเฟรม",
    ["fuse"] = "ผสม",
    ["fuse filter"] = "ตัวกรองการผสม",
    ["fuse first"] = "เลือกผสมก่อน",
    ["fuse machine"] = "เครื่องผสม",
    ["fuse predictor"] = "คาดการณ์การผสม",
    ["go to egg"] = "วิธีไปหาไข่",
    ["graphics"] = "กราฟิก",
    ["growing"] = "กำลังเติบโต",
    ["hatched"] = "ฟักแล้ว",
    ["hatching"] = "กำลังฟักไข่",
    ["hide game ui"] = "ซ่อนหน้าต่างของเกม",
    ["hide my pets and eggs"] = "ซ่อนสัตว์เลี้ยงและไข่ของฉัน",
    ["hide other players' pets and eggs"] = "ซ่อนสัตว์เลี้ยงและไข่ของผู้เล่นอื่น",
    ["high"] = "สูง",
    ["highest rarity"] = "หายากที่สุด",
    ["highest value first"] = "มูลค่าสูงสุดก่อน",
    ["home"] = "หน้าแรก",
    ["hop server"] = "ย้ายเซิร์ฟเวอร์",
    ["hop to"] = "ย้ายไปเซิร์ฟเวอร์แบบ",
    ["hop when"] = "เงื่อนไขการย้ายเซิร์ฟเวอร์",
    ["idle"] = "ว่าง",
    ["import"] = "นำเข้า",
    ["import config"] = "นำเข้าโปรไฟล์",
    ["import text"] = "ข้อความสำหรับนำเข้า",
    ["in bag"] = "อยู่ในกระเป๋า",
    ["info"] = "ข้อมูล",
    ["information"] = "ข้อมูล",
    ["interface"] = "หน้าต่างควบคุม",
    ["job id"] = "Job ID",
    ["join"] = "เข้าร่วม",
    ["join and stay"] = "เข้าเซิร์ฟเวอร์ที่กำหนด",
    ["join that server"] = "เข้าร่วมเซิร์ฟเวอร์นี้",
    ["keep eggs"] = "เก็บไข่ไว้",
    ["keep lab eggs"] = "เก็บไข่จากแล็บไว้",
    ["keep mutated"] = "เก็บตัวที่กลายพันธุ์ไว้",
    ["key"] = "คีย์",
    ["keybinds"] = "ปุ่มลัด",
    ["lab"] = "แล็บ",
    ["lab eggs"] = "ไข่แล็บ",
    ["lands in"] = "ตกในอีก",
    ["language"] = "ภาษา",
    ["last egg"] = "ไข่ล่าสุด",
    ["least players"] = "ผู้เล่นน้อยที่สุด",
    ["legendary"] = "ตำนาน",
    ["light dark zone"] = "โซนสว่างและมืด",
    ["load"] = "โหลด",
    ["loading"] = "กำลังโหลด",
    ["low"] = "ต่ำ",
    ["low graphics"] = "ลดคุณภาพกราฟิก",
    ["lower it if wins do not count"] = "ลดค่านี้หากชัยชนะไม่ถูกนับ",
    ["lowest rarity"] = "หายากน้อยที่สุด",
    ["lowest value"] = "มูลค่าต่ำสุด",
    ["lowest value first"] = "มูลค่าต่ำสุดก่อน",
    ["match"] = "เงื่อนไขตรงกัน",
    ["max"] = "สูงสุด",
    ["min"] = "ต่ำสุด",
    ["min value /s"] = "มูลค่าขั้นต่ำ/วินาที",
    ["minimum value/s"] = "มูลค่าขั้นต่ำ/วินาที",
    ["misc"] = "อื่น ๆ",
    ["money/s"] = "เงินต่อวินาที",
    ["mutate"] = "กลายพันธุ์",
    ["mutate filter"] = "ตัวกรองการกลายพันธุ์",
    ["mutate first"] = "เลือกกลายพันธุ์ก่อน",
    ["mutation"] = "การกลายพันธุ์",
    ["mutations"] = "การกลายพันธุ์",
    ["mythic"] = "มายาคติ",
    ["name"] = "ชื่อ",
    ["never"] = "ไม่เลย",
    ["never fuse"] = "ห้ามผสม",
    ["never sell"] = "ห้ามขาย",
    ["new"] = "ใหม่",
    ["new config name"] = "ชื่อโปรไฟล์ใหม่",
    ["next race"] = "แข่งครั้งถัดไป",
    ["night"] = "กลางคืน",
    ["night in"] = "กลางคืนในอีก",
    ["nitro"] = "ไนโตร",
    ["no egg matches your targets"] = "ไม่มีไข่ที่ตรงตามเงื่อนไข",
    ["no eggs found"] = "ไม่พบไข่",
    ["no matching eggs"] = "ไม่มีไข่ที่ตรงเงื่อนไข",
    ["no matching pets"] = "ไม่มีสัตว์เลี้ยงที่ตรงเงื่อนไข",
    ["no pets found"] = "ไม่พบสัตว์เลี้ยง",
    ["no targets"] = "ไม่มีเป้าหมาย",
    ["none"] = "ไม่มี",
    ["notification"] = "การแจ้งเตือน",
    ["notifications"] = "การแจ้งเตือน",
    ["off"] = "ปิด",
    ["on"] = "เปิด",
    ["only below /s"] = "เฉพาะที่มีมูลค่าต่ำกว่า/วินาที",
    ["only mutations"] = "เฉพาะแบบกลายพันธุ์ที่เลือก",
    ["only these eggs"] = "เลือกขโมยเฉพาะไข่เหล่านี้",
    ["only these pets"] = "เฉพาะสัตว์เลี้ยงที่เลือก",
    ["opacity"] = "ความทึบของหน้าต่าง",
    ["open"] = "เปิด",
    ["optimizer"] = "ปรับประสิทธิภาพ",
    ["other"] = "อื่น ๆ",
    ["paste a job id"] = "วาง Job ID",
    ["paste config text"] = "วางข้อความโปรไฟล์",
    ["pause"] = "พัก",
    ["pen"] = "คอกไข่",
    ["pet"] = "สัตว์เลี้ยง",
    ["pet bag"] = "กระเป๋าสัตว์เลี้ยง",
    ["pets"] = "สัตว์เลี้ยง",
    ["pick any"] = "เลือกได้หลายตัวเลือก",
    ["pick one"] = "เลือกหนึ่งตัวเลือก",
    ["pick to delete"] = "เลือกโปรไฟล์ที่จะลบ",
    ["pin"] = "ปักหมุด",
    ["ping everyone"] = "แท็กทุกคน",
    ["ping role id"] = "แท็กยศด้วย ID",
    ["ping user id"] = "แท็กผู้ใช้ด้วย ID",
    ["pinned"] = "ปักหมุดแล้ว",
    ["pins and keybinds"] = "ปักหมุดและปุ่มลัด",
    ["place"] = "วางไข่",
    ["place first"] = "เลือกวางก่อน",
    ["place id"] = "Place ID",
    ["place when"] = "เงื่อนไขการวาง",
    ["placed"] = "วางแล้ว",
    ["placing"] = "กำลังวางไข่",
    ["player"] = "ตัวละคร",
    ["player count"] = "จำนวนผู้เล่น",
    ["post fused eggs"] = "แจ้งไข่ที่ผสมแล้ว",
    ["post stolen eggs"] = "แจ้งไข่ที่ขโมยได้",
    ["post when bag is full"] = "แจ้งเมื่อกระเป๋าเต็ม",
    ["posted"] = "ส่งแล้ว",
    ["preview card"] = "แสดงตัวอย่างการ์ด",
    ["price"] = "ราคา",
    ["priority"] = "ลำดับความสำคัญ",
    ["profiles"] = "โปรไฟล์",
    ["progress"] = "ความคืบหน้า",
    ["quick bar 1"] = "แถบด่วน 1",
    ["quick bar 2"] = "แถบด่วน 2",
    ["quick bars"] = "แถบคำสั่งด่วน",
    ["race"] = "แข่งวิ่ง",
    ["race speed"] = "ความเร็วในการแข่ง",
    ["racer"] = "ตัวแข่ง",
    ["racing event"] = "กิจกรรมแข่งวิ่ง",
    ["rare"] = "หายาก",
    ["rare from"] = "ระดับความหายากตั้งแต่",
    ["rarities"] = "ระดับความหายาก",
    ["rarity"] = "ระดับความหายาก",
    ["ready"] = "พร้อม",
    ["ready now"] = "พร้อมตอนนี้",
    ["ready to place"] = "พร้อมวาง",
    ["refresh"] = "รีเฟรช",
    ["rejoin"] = "เข้าเซิร์ฟใหม่",
    ["rejoin on kick"] = "เข้าเกมใหม่เมื่อถูกเตะ",
    ["rejoin this server"] = "กลับเข้าเซิร์ฟเวอร์นี้",
    ["reset"] = "รีเซ็ต",
    ["reset all"] = "รีเซ็ตทั้งหมด",
    ["reset selection"] = "รีเซ็ตการเลือก",
    ["reset to defaults"] = "คืนค่าเริ่มต้นทั้งหมด",
    ["resetting carry"] = "กำลังรีเซ็ตการถือไข่",
    ["restore deleted"] = "กู้คืนโปรไฟล์ที่ลบ",
    ["resume"] = "ทำต่อ",
    ["rewards"] = "รางวัล",
    ["save"] = "บันทึก",
    ["save changes"] = "บันทึกการเปลี่ยนแปลง",
    ["saved configs"] = "โปรไฟล์ที่บันทึก",
    ["scrambled"] = "ปั่นเปลี่ยนสภาพ",
    ["search"] = "ค้นหา",
    ["search servers"] = "ค้นหาเซิร์ฟเวอร์",
    ["search..."] = "ค้นหา...",
    ["searching"] = "กำลังค้นหา",
    ["secret"] = "ลับ",
    ["select"] = "เลือก",
    ["select all"] = "เลือกทั้งหมด",
    ["sell"] = "ขาย",
    ["sell cheapest egg when bag is full"] = "ขายไข่ราคาต่ำสุดเมื่อกระเป๋าเต็ม",
    ["sell matching eggs now"] = "ขายไข่ที่ตรงเงื่อนไขทันที",
    ["sell matching lab eggs now"] = "ขายไข่แล็บที่ตรงเงื่อนไขทันที",
    ["sell matching pets now"] = "ขายสัตว์เลี้ยงที่ตรงเงื่อนไขทันที",
    ["sell rarities"] = "ระดับที่จะขาย",
    ["send a test post"] = "ส่งข้อความทดสอบ",
    ["server"] = "เซิร์ฟเวอร์",
    ["server hop"] = "ย้ายเซิร์ฟเวอร์",
    ["session"] = "ข้อมูลรอบนี้",
    ["session time"] = "เวลาในรอบนี้",
    ["set active"] = "ตั้งให้ใช้งาน",
    ["set as active config"] = "ตั้งเป็นโปรไฟล์ที่ใช้งาน",
    ["settings"] = "ตั้งค่า",
    ["shooting star"] = "ดาวตก",
    ["shop items"] = "สินค้าในร้าน",
    ["show / hide ui"] = "แสดง / ซ่อนหน้าต่าง",
    ["show fps and ping"] = "แสดง FPS และ Ping",
    ["show quick bars"] = "แสดงแถบปุ่มลัด",
    ["skip eggs with"] = "ข้ามไข่ที่มี",
    ["skip mutated"] = "ข้ามสัตว์เลี้ยงที่กลายพันธุ์แล้ว",
    ["slipped"] = "หลุดมือ",
    ["sort by"] = "เรียงตาม",
    ["sort eggs"] = "เรียงไข่ตาม",
    ["speed boost"] = "เพิ่มความเร็ว",
    ["speed power"] = "พลังความเร็ว",
    ["star"] = "ดาวตก",
    ["star catch"] = "จับดาวตก",
    ["star event"] = "กิจกรรมดาว",
    ["status"] = "สถานะ",
    ["steal"] = "ขโมยไข่",
    ["steal an egg"] = "เกมขโมยไข่",
    ["steal filter eggs"] = "ขโมยไข่ตามตัวกรอง",
    ["steal first"] = "เลือกไข่ที่จะขโมยก่อน",
    ["steal from other players"] = "ขโมยไข่จากผู้เล่นอื่น",
    ["steal lab eggs"] = "ขโมยไข่แล็บ",
    ["steal missing index"] = "ขโมยตัวที่ยังไม่ลงสมุด",
    ["steal missing index eggs"] = "ขโมยไข่ที่ยังไม่มีในสมุดสะสม",
    ["steal wisp eggs"] = "ขโมยไข่ Wisp",
    ["stealing"] = "กำลังขโมย",
    ["stolen"] = "ขโมยแล้ว",
    ["stop"] = "หยุด",
    ["success"] = "สำเร็จ",
    ["support"] = "ฝ่ายช่วยเหลือ",
    ["system"] = "ระบบ",
    ["task order"] = "ลำดับงาน",
    ["teleport"] = "วาร์ป",
    ["teleport to egg"] = "วาร์ปไปหาไข่",
    ["teleport zones"] = "โซนที่วาร์ปได้",
    ["teleporting"] = "กำลังย้ายตำแหน่ง",
    ["test"] = "ทดสอบ",
    ["theme"] = "ธีม",
    ["time"] = "เวลา",
    ["tip: you can also hold any option, or right-click it on pc, to pin it or set a key."] = "เคล็ดลับ: กดตัวเลือกค้างไว้ หรือคลิกขวาบน PC เพื่อปักหมุดหรือตั้งปุ่มลัด",
    ["tone"] = "โทนสี",
    ["top goes first. a carried egg is always delivered first, and before the field opens every task waits in the safe zone."] = "รายการบนสุดทำก่อน • ไข่ที่ถืออยู่จะถูกส่งก่อนเสมอ และจะรอที่เขตปลอดภัยก่อนสนามเปิด",
    ["treadmill"] = "ลู่วิ่ง",
    ["tries"] = "จำนวนครั้ง",
    ["trophies"] = "ถ้วยรางวัล",
    ["turn off"] = "ปิดทั้งหมด",
    ["turn off all toggles"] = "ปิดสวิตช์ทั้งหมด",
    ["tween"] = "เคลื่อนที่แบบ Tween",
    ["tween speed slider"] = "แถบปรับความเร็ว Tween",
    ["ui scale"] = "ขนาดหน้าต่าง",
    ["ui settings"] = "ตั้งค่าหน้าต่าง",
    ["uncommon"] = "ไม่ธรรมดา",
    ["unload hub"] = "ปิดฮับ",
    ["update"] = "อัปเดต",
    ["updates, keys, support"] = "อัปเดต • คีย์ • ช่วยเหลือ",
    ["upgrade"] = "อัปเกรด",
    ["use items"] = "ไอเทมที่ใช้",
    ["use pets"] = "ลำดับใช้สัตว์เลี้ยง",
    ["use power-ups"] = "ใช้ไอเทมเพิ่มพลัง",
    ["value"] = "มูลค่า",
    ["venyx"] = "VENYX",
    ["venyx / steal an egg"] = "Venyx / เกมขโมยไข่",
    ["venyx discord"] = "ดิสคอร์ด Venyx",
    ["version"] = "เวอร์ชัน",
    ["waiting"] = "กำลังรอ",
    ["waiting for server"] = "กำลังรอเซิร์ฟเวอร์",
    ["walk / sprint"] = "เดิน / วิ่งเร็ว",
    ["walk/sprint"] = "เดิน / วิ่งเร็ว",
    ["warning"] = "คำเตือน",
    ["webhook"] = "เว็บฮุก",
    ["webhook url"] = "ลิงก์ Webhook",
    ["welcome back"] = "ยินดีต้อนรับกลับ",
    ["welcome to venyx 1.0.2! join our discord for updates and support"] = "ยินดีต้อนรับสู่ Venyx 1.0.2! เข้าดิสคอร์ดเพื่อรับข่าวสารและความช่วยเหลือ",
    ["welcome to venyx 1.0.2! join our discord for updates and support."] = "ยินดีต้อนรับสู่ Venyx 1.0.2! เข้าดิสคอร์ดเพื่อรับข่าวสารและความช่วยเหลือ",
    ["what to post"] = "ข้อมูลที่จะส่ง",
    ["what's new"] = "มีอะไรใหม่",
    ["white"] = "ขาว",
    ["wins"] = "ชัยชนะ",
    ["wisp"] = "Wisp",
    ["wisp event"] = "กิจกรรม Wisp",
    ["worst"] = "ต่ำที่สุด",
    ["zones"] = "โซน",
    ["anti afk"] = "ป้องกันหลุดเมื่อไม่ขยับ",
    ["anti ragdoll"] = "ป้องกันตัวละครล้มกลิ้ง",
    ["auto banjo cricket"] = "ทำภารกิจจิ้งหรีดแบนโจอัตโนมัติ",
    ["auto butterfly bloom"] = "ทำกิจกรรมผีเสื้อผลิบานอัตโนมัติ",
    ["auto capture event egg"] = "ชิงไข่กิจกรรมอัตโนมัติ",
    ["auto craft essence"] = "สร้างแก่นพลังอัตโนมัติ",
    ["auto hit"] = "โจมตีอัตโนมัติ",
    ["auto reroll recipe"] = "สุ่มสูตรใหม่อัตโนมัติ",
    ["auto steal minigame egg"] = "ขโมยไข่จากมินิเกมอัตโนมัติ",
    ["auto trade in"] = "แลกไข่กับแล็บอัตโนมัติ",
    ["auto trade up"] = "แลกเปลี่ยนเป็นระดับสูงขึ้นอัตโนมัติ",
    ["auto wisp quest"] = "ทำภารกิจวิสป์อัตโนมัติ",
    ["banner"] = "ตู้สุ่ม",
    ["banner chance"] = "โอกาสได้รับจากตู้สุ่ม",
    ["boost speed"] = "เพิ่มความเร็ว",
    ["capture the egg"] = "ชิงไข่กิจกรรม",
    ["catch mode"] = "รูปแบบการจับ",
    ["catch priority"] = "ลำดับความสำคัญในการจับ",
    ["catch speed"] = "ความเร็วในการจับ",
    ["chase"] = "ไล่จับ",
    ["chase speed"] = "ความเร็วไล่ตาม",
    ["chasing butterflies"] = "กำลังไล่จับผีเสื้อ",
    ["chosen player"] = "ผู้เล่นที่เลือก",
    ["combat"] = "ต่อสู้",
    ["complete"] = "สำเร็จ",
    ["delivery method"] = "วิธีนำไข่กลับ",
    ["done, the enchanted tree is open"] = "เสร็จแล้ว ต้นไม้มนตร์เปิดใช้งานแล้ว",
    ["egg esp"] = "แสดงตำแหน่งไข่",
    ["ends in"] = "สิ้นสุดในอีก",
    ["esp size"] = "ขนาดการแสดงตำแหน่ง",
    ["experimental pets"] = "สัตว์เลี้ยงทดลอง",
    ["field eggs"] = "ไข่ในสนาม",
    ["fixed size"] = "ขนาดคงที่",
    ["god mode"] = "โหมดอมตะ",
    ["guard esp"] = "แสดงตำแหน่งยาม",
    ["hide sleeping guards"] = "ซ่อนยามที่กำลังหลับ",
    ["hit aura"] = "โจมตีรอบตัว",
    ["hit who"] = "เลือกผู้ที่จะโจมตี",
    ["hold each"] = "ถืออาวุธแต่ละชิ้นนาน",
    ["hold height"] = "ความสูงขณะถือ",
    ["icon"] = "ไอคอน",
    ["ignore traps"] = "ไม่ติดกับดัก",
    ["infinite jump"] = "กระโดดไม่จำกัด",
    ["instant prompts"] = "โต้ตอบได้ทันที",
    ["instant steal (admin treadmill)"] = "ขโมยทันที (ลู่วิ่งแอดมิน)",
    ["invisible"] = "ล่องหน",
    ["keep away"] = "รักษาระยะห่าง",
    ["lab banners"] = "ตู้สุ่มแล็บ",
    ["lab odds"] = "อัตราโอกาสออกสัตว์เลี้ยงจากแล็บ",
    ["lab stock"] = "สินค้าในแล็บ",
    ["minigame eggs"] = "ไข่จากมินิเกม",
    ["move"] = "เคลื่อนที่",
    ["movement"] = "การเคลื่อนที่",
    ["nearest player"] = "ผู้เล่นที่ใกล้ที่สุด",
    ["next"] = "ถัดไป",
    ["no admin boost right now"] = "ตอนนี้ไม่มีบูสต์แอดมิน",
    ["other pens esp"] = "แสดงตำแหน่งคอกผู้เล่นอื่น",
    ["others"] = "อื่น ๆ",
    ["pen egg esp"] = "แสดงตำแหน่งไข่ในคอก",
    ["place lab reward eggs"] = "วางไข่รางวัลจากแล็บ",
    ["player esp"] = "แสดงตำแหน่งผู้เล่น",
    ["protection"] = "การป้องกัน",
    ["racer selection"] = "เลือกตัวแข่ง",
    ["rarest"] = "หายากที่สุด",
    ["show"] = "แสดง",
    ["skip friends"] = "ไม่โจมตีเพื่อน",
    ["smart trade for essence"] = "แลกอย่างคุ้มค่าเพื่อรับแก่นพลัง",
    ["stage"] = "ด่าน",
    ["take it from the holder"] = "แย่งไข่จากผู้ที่ถืออยู่",
    ["trade"] = "แลก",
    ["tween speed"] = "ความเร็วการเคลื่อนที่แบบ Tween",
    ["upcoming banners"] = "ตู้สุ่มชุดถัดไป",
    ["use admin treadmill"] = "ใช้ลู่วิ่งของแอดมิน",
    ["use weapons"] = "อาวุธที่จะใช้",
    ["waiting for red light green light or t-rex run"] = "กำลังรอมินิเกม Red Light Green Light หรือ T-Rex Run",
    ["weapons"] = "อาวุธ",
    ["wisp companion"] = "คู่หูวิญญาณวิสป์",
    -- V1.3 • คำแปลตัวเลือกและชื่อฟังก์ชันเพิ่มเติมจากภาพชุดล่าสุด
    ["abyss ocean"] = "มหาสมุทรใต้พิภพ",
    ["all 106"] = "ทั้งหมด 106",
    ["all 108"] = "ทั้งหมด 108",
    ["always favorite"] = "ตั้งเป็นรายการโปรดเสมอ",
    ["amethyst"] = "อเมทิสต์",
    ["any"] = "ใดก็ได้",
    ["bird"] = "นก",
    ["cash booster"] = "ตัวคูณเงิน",
    ["celestial sunlion"] = "สิงโตสุริยันสวรรค์",
    ["cheetah"] = "เสือชีตาห์",
    ["cherry blossom"] = "ดอกซากุระ",
    ["cosmic"] = "จักรวาล",
    ["current"] = "ปัจจุบัน",
    ["desert"] = "ทะเลทราย",
    ["emerald"] = "มรกต",
    ["esp"] = "แสดงตำแหน่ง",
    ["essence"] = "แก่นพลัง",
    ["favorite equipped"] = "ตั้งสัตว์เลี้ยงที่สวมใส่เป็นรายการโปรด",
    ["forest"] = "ป่าไม้",
    ["frogfly"] = "กบแมลงวัน",
    ["growing 0"] = "กำลังเติบโต 0",
    ["highest value"] = "มูลค่าสูงสุด",
    ["highest weight"] = "น้ำหนักมากที่สุด",
    ["icon + text"] = "ไอคอนและข้อความ",
    ["in bag 97"] = "ในกระเป๋า 97",
    ["jungle"] = "ป่าดงดิบ",
    ["kitsune"] = "คิทสึเนะ",
    ["lake"] = "ทะเลสาบ",
    ["light dark"] = "สว่างและมืด",
    ["lizard"] = "กิ้งก่า",
    ["lowest weight"] = "น้ำหนักน้อยที่สุด",
    ["most valuable"] = "มูลค่าสูงสุด",
    ["move to egg"] = "วิธีเคลื่อนที่ไปหาไข่",
    ["nearest"] = "ใกล้ที่สุด",
    ["ostrich"] = "นกกระจอกเทศ",
    ["prehistoric"] = "ยุคก่อนประวัติศาสตร์",
    ["preview"] = "ตัวอย่าง",
    ["pure jellyfish"] = "แมงกะพรุนบริสุทธิ์",
    ["racing bat"] = "ไม้ตีสำหรับแข่ง",
    ["radiant"] = "เรืองแสง",
    ["ready 9"] = "พร้อม 9",
    ["sapphire"] = "ไพลิน",
    ["seahorse"] = "ม้าน้ำ",
    ["selected"] = "เลือกแล้ว",
    ["shop"] = "ร้านค้า",
    ["shortest time first"] = "เหลือเวลาน้อยที่สุดก่อน",
    ["showcase"] = "รายการไข่",
    ["skeleton horse"] = "ม้าโครงกระดูก",
    ["snow"] = "ดินแดนหิมะ",
    ["stacked turtle"] = "เต่าซ้อนชั้น",
    ["starry fox"] = "จิ้งจอกดวงดาว",
    ["step"] = "เคลื่อนที่ทีละก้าว",
    ["step to egg"] = "เคลื่อนที่ทีละก้าวไปหาไข่",
    ["text"] = "ข้อความ",
    ["three headed chicken"] = "ไก่สามหัว",
    ["time left"] = "เวลาที่เหลือ",
    ["time remaining"] = "เวลาที่เหลือ",
    ["titan temple"] = "วิหารไททัน",
    ["treadmill boost"] = "ตัวช่วยเร่งลู่วิ่ง",
    ["unfavorite pets not matching"] = "นำสัตว์เลี้ยงที่ไม่ตรงเงื่อนไขออกจากรายการโปรด",
    ["volcano"] = "ภูเขาไฟ",
    ["weight"] = "น้ำหนัก",
    ["weight first"] = "น้ำหนักมากสุดก่อน",
    ["wheel hamster"] = "แฮมสเตอร์ล้อวิ่ง",
    ["zone"] = "โซน",
    -- V1.4 • Additive Thai translations for remaining visible options (ZIGZAG)
    ["auto place eggs"] = "วางไข่อัตโนมัติ",
    ["bloom"] = "เบ่งบาน",
    ["choose what to place first"] = "เลือกวางก่อน",
    ["choose who to hit"] = "เลือกผู้ที่จะโจมตี",
    ["choose who to hit / hit who"] = "เลือกผู้ที่จะโจมตี",
    ["cracked"] = "แตกร้าว",
    ["defaults"] = "ค่าเริ่มต้น",
    ["diamond"] = "เพชร",
    ["egg holders"] = "ผู้ถือไข่",
    ["egg(s) ready to place"] = "ฟองพร้อมวาง",
    ["first hop after slider"] = "แถบปรับเวลาก่อนย้ายเซิร์ฟเวอร์ครั้งแรก",
    ["from chilii"] = "จาก Chilii",
    ["game hud"] = "แผงควบคุมในเกม",
    ["golden"] = "ทอง",
    ["instant steps slider"] = "แถบปรับจำนวนก้าว",
    ["min value /s slider"] = "แถบปรับมูลค่าขั้นต่ำ/วินาที",
    ["only at night"] = "เฉพาะตอนกลางคืน",
    ["parasite"] = "ปรสิต",
    ["place condition"] = "เงื่อนไขการวาง",
    ["rainbow"] = "สายรุ้ง",
    ["right after a steal"] = "ทันทีหลังขโมยไข่",
    ["shapeshift"] = "แปลงร่าง",
    ["silver"] = "เงิน",
    ["smallest"] = "ตัวเล็กที่สุด",
    ["spirit bloom"] = "เบ่งบานแห่งวิญญาณ",
    ["steal is idle"] = "เมื่อระบบขโมยไข่ว่าง",
    ["steal panel button on game hud"] = "แสดงปุ่มแผงขโมยไข่บน HUD",

    -- V1.5 • คำแปลเพิ่มเติมจากภาพ VENYX: แล็บ, ผีเสื้อ, ปักหมุด และตัวเลือกย่อย
    ["no egg matches here"] = "ไม่มีไข่ที่ตรงเงื่อนไขในเซิร์ฟเวอร์นี้",
    ["a rare egg spawned"] = "มีไข่หายากปรากฏแล้ว",
    ["waiting for daytime"] = "กำลังรอเวลากลางวัน",
    ["waiting for the next butterfly bloom"] = "กำลังรอกิจกรรมผีเสื้อผลิบานครั้งถัดไป",
    ["kept eggs are never placed, hatched or sold, in your bag or your pen."] = "ไข่ที่เลือกเก็บจะไม่ถูกนำไปวาง ฟัก หรือขาย ไม่ว่าจะอยู่ในกระเป๋าหรือคอกไข่",
    ["eggs to keep"] = "ไข่ที่จะเก็บไว้",
    ["most copies"] = "มีตัวซ้ำมากที่สุด",
    ["stand"] = "ยืนนิ่ง",
    ["patrol"] = "เดินตรวจตรา",
    ["circle"] = "เคลื่อนที่วนรอบ",
    ["emerald to sapphire"] = "มรกต → ไพลิน",
    ["sapphire to amethyst"] = "ไพลิน → อเมทิสต์",
    ["amethyst to radiant"] = "อเมทิสต์ → เรืองแสง",
    ["biohazard pets"] = "สัตว์เลี้ยงชีวอันตราย",
    ["unstable dna"] = "ดีเอ็นเอไม่เสถียร",
    ["stock lab eggs"] = "สำรองไข่สำหรับแล็บ",
    ["stock for banners"] = "สำรองไข่สำหรับตู้สุ่ม",
    ["biohazard pets eggs"] = "ไข่สัตว์เลี้ยงชีวอันตราย",
    ["experimental pets eggs"] = "ไข่สัตว์เลี้ยงทดลอง",
    ["unstable dna eggs"] = "ไข่ดีเอ็นเอไม่เสถียร",
    ["stock per egg"] = "จำนวนไข่ที่สำรองต่อชนิด",
    ["keeps eggs for recipes that have not shown up yet. % is how often a recipe asks for that egg."] = "สำรองไข่ไว้สำหรับสูตรที่ยังไม่ปรากฏ โดย % บอกความถี่ที่สูตรต้องใช้ไข่ชนิดนั้น",
    ["octophant"] = "อ็อกโทแฟนต์",
    ["slider"] = "แถบปรับค่า",
    ["only below /s slider"] = "แถบปรับมูลค่าสูงสุด/วินาที",
    ["+ pin"] = "+ ปักหมุด",
    ["steal / auto steal"] = "ขโมยไข่ / ขโมยอัตโนมัติ",
    ["steal / auto steal / filter"] = "ขโมยไข่ / อัตโนมัติ / ตัวกรอง",
    ["steal / auto steal / auto hop server"] = "ขโมยไข่ / อัตโนมัติ / ย้ายเซิร์ฟเวอร์",
    ["farm / pen / auto place"] = "ฟาร์ม / คอกไข่ / วางไข่อัตโนมัติ",
    ["farm / pen / auto hatch"] = "ฟาร์ม / คอกไข่ / ฟักไข่อัตโนมัติ",
    ["system / interface / game hud"] = "ระบบ / หน้าต่าง / แผงควบคุมในเกม",
    ["twilight"] = "ยามสนธยา",
    ["aurora"] = "แสงเหนือ",
    ["ocean"] = "มหาสมุทร",
    ["midnight"] = "เที่ยงคืน",
    ["sakura"] = "ซากุระ",
    ["onyx"] = "หินนิล",
    ["black"] = "ดำ",
    ["mono"] = "ขาวดำ",

    -- V1.6 • All circled English labels in the PIN / quick-bar picker.
    -- Only GUI text: these keys do not affect the original Venyx option IDs.
    ["min value /s slider"] = "แถบปรับมูลค่าขั้นต่ำต่อวินาที",
    ["only below /s slider"] = "แถบปรับเกณฑ์มูลค่าต่ำกว่าต่อวินาที",
    ["tween speed slider"] = "แถบปรับความเร็วการเคลื่อนที่",
    ["delivery speed slider"] = "แถบปรับความเร็วส่งไข่",
    ["instant steps slider"] = "แถบปรับจำนวนก้าวแบบทันที",
    ["first hop after slider"] = "แถบปรับเวลาย้ายเซิร์ฟเวอร์ครั้งแรก",
    ["stock per egg slider"] = "แถบปรับจำนวนไข่สำรองต่อชนิด",
    ["upcoming banners button"] = "ปุ่มดูตู้สุ่มชุดถัดไป",
    ["race speed slider"] = "แถบปรับความเร็วแข่งวิ่ง",
    ["catch speed slider"] = "แถบปรับความเร็วในการจับ",
    ["hold height slider"] = "แถบปรับความสูงขณะถือ",
    ["keep away slider"] = "แถบปรับระยะห่าง",
    ["sell matching lab eggs now button"] = "ปุ่มขายไข่แล็บที่ตรงเงื่อนไขทันที",
    ["sell matching pets now button"] = "ปุ่มขายสัตว์เลี้ยงที่ตรงเงื่อนไขทันที",
    -- Additional button/slider variants generated by the same Venyx pin picker.
    ["sell matching eggs now button"] = "ปุ่มขายไข่ที่ตรงเงื่อนไขทันที",
    ["first hop after"] = "เวลาย้ายเซิร์ฟเวอร์ครั้งแรก",
    ["stock per egg"] = "จำนวนไข่สำรองต่อชนิด",
    ["upcoming banners"] = "ตู้สุ่มชุดถัดไป",
    ["race speed"] = "ความเร็วแข่งวิ่ง",
    ["catch speed"] = "ความเร็วในการจับ",
    ["hold height"] = "ความสูงขณะถือ",
    ["keep away"] = "ระยะห่าง",

    -- V1.7 • Steal Panel ด้านขวา (เฉพาะข้อความ UI ไม่แตะข้อมูลตัวละคร/เกม)
    ["steal panel"] = "แผงขโมยไข่",
    ["auto steal on"] = "ขโมยไข่อัตโนมัติ: เปิด",
    ["auto steal off"] = "ขโมยไข่อัตโนมัติ: ปิด",
    ["auto steal: on"] = "ขโมยไข่อัตโนมัติ: เปิด",
    ["auto steal: off"] = "ขโมยไข่อัตโนมัติ: ปิด",
    ["show: all"] = "แสดง: ทั้งหมด",
    ["show: ready"] = "แสดง: พร้อมขโมย",
    ["show: stolen"] = "แสดง: ขโมยแล้ว",
    ["show: available"] = "แสดง: ขโมยได้",
    ["show: none"] = "แสดง: ไม่มี",
    ["show: mine"] = "แสดง: ของฉัน",
    ["show: others"] = "แสดง: ของผู้อื่น",
    ["show: rarity"] = "แสดง: ระดับความหายาก",
    ["show: value"] = "แสดง: มูลค่า",
    -- ชื่อสัตว์ที่เห็นในภาพ: แปลเฉพาะป้ายชื่อที่ปรากฏ ไม่เปลี่ยนข้อมูลสัตว์
    ["gargoyle"] = "การ์กอยล์",
    ["spirit panda"] = "แพนด้าวิญญาณ",
    ["mantaris"] = "แมนทาริส",
    ["astral jackalope"] = "แจ็กคาโลปแห่งดวงดาว",
    ["demon hound"] = "สุนัขล่าเนื้อปีศาจ",

    -- V1.9 • VENYX v1.1.0 HALLOWEEN: เฉพาะคำแปลที่เห็นใน UI
    -- ไม่แก้ไขตัวเลือก / ค่า / remote / gameplay / loader / teleport logic
    ["halloween"] = "ฮาโลวีน",
    ["halloween dimension"] = "มิติฮาโลวีน",
    ["halloween eggs"] = "ไข่ฮาโลวีน",
    ["halloween egg"] = "ไข่ฮาโลวีน",
    ["halloween rarities"] = "ระดับความหายากของไข่ฮาโลวีน",
    ["auto steal halloween eggs"] = "ขโมยไข่ฮาโลวีนอัตโนมัติ",
    ["instant steal halloween eggs"] = "ขโมยไข่ฮาโลวีนทันที",
    ["steal speed"] = "ความเร็วในการขโมยไข่",
    ["auto pumpkin moon"] = "ทำกิจกรรมพระจันทร์ฟักทองอัตโนมัติ",
    ["pumpkin moon"] = "พระจันทร์ฟักทอง",
    ["walk speed"] = "ความเร็วเดิน",
    ["auto buy halloween dimension egg"] = "ซื้อไข่มิติฮาโลวีนอัตโนมัติ",
    ["auto buy halloween dimension eggs"] = "ซื้อไข่มิติฮาโลวีนอัตโนมัติ",
    ["monsters"] = "มอนสเตอร์",
    ["monster"] = "มอนสเตอร์",
    ["auto kill monsters"] = "กำจัดมอนสเตอร์อัตโนมัติ",
    ["monster order"] = "ลำดับเลือกมอนสเตอร์",
    ["most tokens"] = "ได้รับโทเคนมากที่สุด",
    ["phantom express"] = "รถไฟภูตพราย",
    ["train"] = "รถไฟ",
    ["not here"] = "ยังไม่มา",
    ["souls"] = "วิญญาณ",
    ["soul"] = "วิญญาณ",
    ["auto phantom express"] = "ขึ้นรถไฟภูตพรายอัตโนมัติ",
    ["auto vacuum ghouler boss"] = "ดูดบอส Ghouler อัตโนมัติ",
    ["ghouler boss"] = "บอส Ghouler",
    ["ghost target"] = "เป้าหมายผี",
    ["rarest first"] = "หายากที่สุดก่อน",
    ["auto trade souls"] = "แลกวิญญาณอัตโนมัติ",
    ["ghost dog and fishing"] = "เควสต์สุนัขผีและตกปลา",
    ["ghost dog quest"] = "เควสต์สุนัขผี",
    ["quest"] = "เควสต์",
    ["fish caught"] = "ปลาที่จับได้",
    ["auto ghost dog quest"] = "ทำเควสต์สุนัขผีอัตโนมัติ",
    ["auto fishing"] = "ตกปลาอัตโนมัติ",
    ["cast luck"] = "โชคในการเหวี่ยงเบ็ด",
    ["x1.5 perfect"] = "x1.5 สมบูรณ์แบบ",
    -- V1.8.3 • NEW VENYX v1.1.0 SCREENSHOTS (2026-10-19) – exact UI labels only
    -- Cursed Island Wars: event card + target-selector modal + choices
    ["cursed island wars"] = "สงครามเกาะต้องสาป",
    ["waiting for cursed island wars"] = "กำลังรอสงครามเกาะต้องสาป",
    ["auto play cursed island wars"] = "เล่นสงครามเกาะต้องสาปอัตโนมัติ",
    ["island wars target"] = "เป้าหมายสงครามเกาะ",
    ["enemies and base"] = "ศัตรูและฐาน",
    ["walls and crystal"] = "กำแพงและคริสตัล",
    -- Farm > Mutation: status text below the existing automatic mutation card
    ["every egg that fits already has these mutations"] = "ไข่ทุกฟองที่ตรงเงื่อนไขมีการกลายพันธุ์เหล่านี้อยู่แล้ว",
    ["every egg that fits already has these mutations."] = "ไข่ทุกฟองที่ตรงเงื่อนไขมีการกลายพันธุ์เหล่านี้อยู่แล้ว",

    -- HYBRID V1.8.3: video-based UI / pop-up / dropdown labels
    ["quick bar"] = "แถบทางลัด",
    ["favorites"] = "รายการโปรด",
    ["favorite items"] = "ไอเทมโปรด",
    ["options"] = "ตัวเลือก",
    ["select one option"] = "เลือกหนึ่งตัวเลือก",
    ["select an option"] = "เลือกตัวเลือก",
    ["search options"] = "ค้นหาตัวเลือก",
    ["search for option"] = "ค้นหาตัวเลือก",
    ["no options"] = "ไม่มีตัวเลือก",
    ["submit"] = "ส่ง",
    ["back"] = "ย้อนกลับ",
    ["yes"] = "ใช่",
    ["no"] = "ไม่",
    ["auto import"] = "นำเข้าอัตโนมัติ",
    ["no updates available"] = "ไม่มีอัปเดตใหม่",
    ["candy corn"] = "ลูกอมข้าวโพด",
    ["money /s"] = "เงินต่อวินาที",
    ["pinned actions"] = "คำสั่งที่ปักหมุด",
    ["choose an option"] = "เลือกตัวเลือก",
}

-- ZIGZAG V1.8.5: VENYX v1.2.2 / Halloween & Star / fishing popup
-- Lowercase exact UI text only; preserve option IDs, handlers, and loader.
local ZIGZAG_V184_VENYX_LABELS = {
    ["halloween & star"] = "ฮาโลวีนและดาวตก",
    ["place and hatch missing index eggs"] = "วางและฟักไข่ที่ยังไม่มีในสารบัญ",
    ["fishing spot"] = "จุดตกปลา",
    ["save spot here"] = "บันทึกจุดตกปลาที่นี่",
    ["spot 1"] = "จุด 1",
    ["spot 2"] = "จุด 2",
    ["spot 3"] = "จุด 3",
    ["waiting for the phantom express"] = "กำลังรอรถไฟภูตพราย",
    ["only during blood moon"] = "เฉพาะช่วงพระจันทร์สีเลือด",
    ["fighting large monster"] = "กำลังต่อสู้กับมอนสเตอร์ขนาดใหญ่",
}
for english,thai in pairs(ZIGZAG_V184_VENYX_LABELS) do
    if TH[english] == nil then
        TH[english] = thai
    end
end

--========================================================
-- ZIGZAG V1.8.5 • VENYX v1.2.4 BLOOD MOON / FISHING
-- Add-only UI label dictionary. Original popup behavior untouched.
--========================================================
local ZIGZAG_V185_VENYX_LABELS = {
    ["farm all monsters in blood moon"] = "ฟาร์มมอนสเตอร์ทั้งหมดช่วงพระจันทร์สีเลือด",
    ["farm monsters while fishing"] = "ฟาร์มมอนสเตอร์ระหว่างตกปลา",
    ["waiting: nothing to do"] = "กำลังรอ: ไม่มีงานให้ทำ",
    ["take halloween eggs from holders"] = "แย่งไข่ฮาโลวีนจากผู้ที่กำลังถือ",
    ["teleport to pumpkins"] = "วาร์ปไปหาฟักทอง",
    ["teleport to monsters"] = "วาร์ปไปหามอนสเตอร์",
    ["teleport to ghosts"] = "วาร์ปไปหาผี",
    ["fishing history"] = "ประวัติการตกปลา",
    ["catches"] = "จำนวนที่จับได้",
}
for english,thai in pairs(ZIGZAG_V185_VENYX_LABELS) do
    if TH[english] == nil then
        TH[english] = thai
    end
end

--========================================================
-- ZIGZAG V1.8.6 • VENYX v1.2.8 PRIORITY ROTATION/THE HOLLOW
-- UI label translations only. Option IDs & callbacks stay intact.
--========================================================
local ZIGZAG_V186_VENYX_LABELS = {
    ["priority rotation"] = "สลับงานตามลำดับความสำคัญ",
    ["rotate fishing and treadmill"] = "สลับตกปลากับลู่วิ่ง",
    ["rotation switch"] = "เงื่อนไขการสลับงาน",
    ["fishing minutes"] = "เวลาตกปลา (นาที)",
    ["treadmill minutes"] = "เวลาวิ่งลู่ (นาที)",
    ["timer"] = "ตั้งเวลา",
    ["every day"] = "ทุกวัน",
    ["switch"] = "สลับงาน",
    ["the hollow"] = "เดอะฮอลโลว์",
    ["the hollow race"] = "การแข่งขันเดอะฮอลโลว์",
    ["auto race the hollow"] = "แข่งเดอะฮอลโลว์อัตโนมัติ",
    ["hollow race speed"] = "ความเร็วแข่งเดอะฮอลโลว์",
    ["use race power-ups"] = "ใช้ไอเทมเพิ่มพลังระหว่างแข่ง",
    ["wins"] = "ชัยชนะ",
    ["now"] = "ตอนนี้",
    ["doing now"] = "กำลังทำ",
    ["switch in"] = "สลับในอีก",
    ["next 1"] = "ถัดไป 1",
    ["next 2"] = "ถัดไป 2",
    ["next 3"] = "ถัดไป 3",
    ["farm monsters"] = "ฟาร์มมอนสเตอร์",
    ["farm monsters in blood moon"] = "ฟาร์มมอนสเตอร์ช่วงพระจันทร์สีเลือด",
    ["place eggs"] = "วางไข่",
    ["mutate eggs"] = "ทำให้ไข่กลายพันธุ์",
    ["wisp quest"] = "ภารกิจ Wisp",
    ["riding the phantom express"] = "กำลังขึ้นรถไฟภูตพราย",
    ["fighting small monster"] = "กำลังต่อสู้กับมอนสเตอร์ขนาดเล็ก",
    ["top goes first. a task never stops halfway: the next one waits until it finishes. a carried egg is always delivered first."] = "งานลำดับบนสุดทำก่อน งานที่เริ่มแล้วจะทำให้เสร็จก่อนจึงสลับงานถัดไป และจะนำไข่ที่ถืออยู่ไปส่งก่อนเสมอ",
    ["lower it if laps do not count"] = "ลดความเร็วลงหากระบบไม่นับรอบการแข่งขัน",
}
for english,thai in pairs(ZIGZAG_V186_VENYX_LABELS) do
    -- V1.8.6 supersedes older inconsistent translations for exact labels.
    TH[english] = thai
end

--========================================================
-- ZIGZAG V1.8.7 • VENYX LABELS + PROMOTIONAL POP-UPS
-- Covers the corresponding English labels on the native Venyx side.
-- Only visible display text; no option IDs / callbacks / loader edits.
--========================================================
local ZIGZAG_V187_VENYX_LABELS = {
    ["move to egg speed"] = "ความเร็วในการไปหาไข่",
    ["delivery"] = "วิธีส่งไข่กลับฐาน",
    ["fast tween"] = "เคลื่อนที่เร็วแบบ Tween",
    ["fast tween speed"] = "ความเร็วส่งไข่แบบ Tween",
    ["instant steps"] = "เคลื่อนที่ทันทีแบบเป็นขั้น",
    ["leap"] = "กระโดดพุ่ง",
    ["auto claim money"] = "รับเงินอัตโนมัติ",
    ["auto claim cash"] = "รับเงินอัตโนมัติ",
    ["sell matching eggs once"] = "ขายไข่ที่ตรงเงื่อนไขหนึ่งครั้ง",
    ["sell matching eggs once."] = "ขายไข่ที่ตรงเงื่อนไขหนึ่งครั้ง",
    ["sell egg rule"] = "กฎการขายไข่",
    ["egg max rarity"] = "ความหายากสูงสุดของไข่ที่จะขาย",
    ["sell eggs at or below this rarity"] = "ขายไข่ระดับนี้หรือต่ำกว่า",
    ["sell eggs at or below this rarity."] = "ขายไข่ระดับนี้หรือต่ำกว่า",
    ["egg sell value"] = "มูลค่าไข่ที่จะขาย",
    ["sell eggs worth less than this (0 = off)"] = "ขายไข่ที่มูลค่าต่ำกว่าที่กำหนด (0 = ปิด)",
    ["keep mutated eggs"] = "เก็บไข่ที่กลายพันธุ์ไว้",
    ["never sell mutated eggs"] = "ห้ามขายไข่ที่กลายพันธุ์",
    ["never sell mutated eggs."] = "ห้ามขายไข่ที่กลายพันธุ์",
    ["blacklist sell eggs"] = "รายการไข่ห้ามขาย",
    ["these eggs are never sold"] = "ไข่เหล่านี้จะไม่ถูกขาย",
    ["these eggs are never sold."] = "ไข่เหล่านี้จะไม่ถูกขาย",
    ["cursed island wars"] = "สงครามเกาะต้องสาป",
    ["waiting for cursed island wars"] = "กำลังรอสงครามเกาะต้องสาป",
    ["auto play cursed island wars"] = "เล่นสงครามเกาะต้องสาปอัตโนมัติ",
    ["island wars target"] = "เป้าหมายสงครามเกาะต้องสาป",
    ["enemies and base"] = "ศัตรูและฐาน",
    ["walls and crystal"] = "กำแพงและคริสตัล",
    ["smoother, faster and more ways to steal."] = "ลื่นไหลขึ้น เร็วขึ้น พร้อมวิธีขโมยที่หลากหลายกว่าเดิม",
    ["smoother, faster and more ways to steal"] = "ลื่นไหลขึ้น เร็วขึ้น พร้อมวิธีขโมยที่หลากหลายกว่าเดิม",
    ["try now"] = "ลองใช้งานเลย",
    ["smoother & faster"] = "ลื่นไหลและเร็วขึ้น",
    ["smoother and faster"] = "ลื่นไหลและเร็วขึ้น",
    ["less lag, quick to load."] = "แลคน้อยลง โหลดเร็วขึ้น",
    ["less lag, quick to load"] = "แลคน้อยลง โหลดเร็วขึ้น",
    ["more steal methods"] = "มีวิธีขโมยไข่มากขึ้น",
    ["teleport, fast tween and more."] = "วาร์ป เคลื่อนที่เร็วแบบ Tween และอีกมากมาย",
    ["teleport, fast tween and more"] = "วาร์ป เคลื่อนที่เร็วแบบ Tween และอีกมากมาย",
    ["steal from players"] = "ขโมยไข่จากผู้เล่น",
    ["hits whoever takes your egg."] = "โจมตีผู้ที่แย่งไข่ของคุณไป",
    ["hits whoever takes your egg"] = "โจมตีผู้ที่แย่งไข่ของคุณไป",
    ["easy setup"] = "ตั้งค่าง่าย",
    ["bring your chilli config over."] = "นำคอนฟิกจาก Chilli มาใช้ได้",
    ["bring your chilli config over"] = "นำคอนฟิกจาก Chilli มาใช้ได้",
}
for english,thai in pairs(ZIGZAG_V187_VENYX_LABELS) do
    TH[english] = thai
end

local function tidy(text)
    return (text:gsub("^%s+", ""):gsub("%s+$", ""))
end
local function key(text)
    return string.lower(tidy(text))
end

-- Translate count/status labels while preserving user values and item names.
local DYNAMIC = {
    -- V1.8.7 • Alternate mutation-capacity wording on newer builds.
    {"^(%d+) eggs? can be mutated%.?$", function(n)
        return "มีไข่ที่กลายพันธุ์ได้ " .. n .. " ฟอง"
    end},
    {"^(%d+) egg%(s%) can be mutated%.?$", function(n)
        return "มีไข่ที่กลายพันธุ์ได้ " .. n .. " ฟอง"
    end},
    -- V1.8.6 • Variable race wins, minutes, and priority queue indices.
    {"^[Oo][Ff][Ff]%s*|%s*[Ww]ins:%s*(%d+)%s*/%s*(%d+)$", function(wins,total)
        return "ปิด | ชัยชนะ: " .. wins .. "/" .. total
    end},
    {"^[Oo][Nn]%s*|%s*[Ww]ins:%s*(%d+)%s*/%s*(%d+)$", function(wins,total)
        return "เปิด | ชัยชนะ: " .. wins .. "/" .. total
    end},
    {"^[Ww]ins:%s*(%d+)%s*/%s*(%d+)$", function(wins,total)
        return "ชัยชนะ: " .. wins .. "/" .. total
    end},
    {"^[Nn][Ee][Xx][Tt]%s+(%d+)$", function(n)
        return "ถัดไป " .. n
    end},
    {"^(%d+)%s+min$", function(n)
        return n .. " นาที"
    end},

    -- V1.5 • แปลข้อความยาวที่ตัดบรรทัด และอัตราโอกาสการออกสัตว์เลี้ยงจากตู้สุ่ม
    {"^Keeps eggs for recipes that have not shown up yet%.%s*%% is how often a recipe asks for that egg%.$", function()
        return "สำรองไข่ไว้สำหรับสูตรที่ยังไม่ปรากฏ โดย % บอกความถี่ที่สูตรต้องใช้ไข่ชนิดนั้น"
    end},
    {"^(.+) %- 1 in ([%d%.]+) %(pity (%d+)%)$", function(rarity, chance, pity)
        local label = TH[key(rarity)] or rarity
        return label .. " • โอกาส 1 ใน " .. chance .. " (การันตีที่ " .. pity .. " ครั้ง)"
    end},
    {"^(.+) %- 1 in ([%d%.]+)$", function(rarity, chance)
        local label = TH[key(rarity)] or rarity
        return label .. " • โอกาส 1 ใน " .. chance
    end},
    {"^ALL (%d+)$", function(n) return "ทั้งหมด " .. n end},
    {"^READY (%d+)$", function(n) return "พร้อม " .. n end},
    {"^GROWING (%d+)$", function(n) return "กำลังเติบโต " .. n end},
    {"^IN BAG (%d+)$", function(n) return "ในกระเป๋า " .. n end},
    {"^%+?(%d+) hours? ago$", function(n) return n .. " ชั่วโมงก่อน" end},
    {"^(.+), changes in (%d+)m (%d+)s%s*Still needs: (.-)%s*Guaranteed pet in (%d+) trades, (%d+) free rerolls left$", function(name, mins, secs, needed, trades, rerolls)
        return name .. " • เปลี่ยนใน " .. mins .. " นาที " .. secs .. " วินาที\nยังต้องการ: " .. needed .. "\nรับประกันสัตว์เลี้ยงในอีก " .. trades .. " ครั้ง • สุ่มสูตรฟรีคงเหลือ " .. rerolls .. " ครั้ง"
    end},
    {"^(.+), changes in (%d+)m (%d+)s$", function(name, mins, secs)
        return name .. " • เปลี่ยนใน " .. mins .. " นาที " .. secs .. " วินาที"
    end},
    {"^Still needs: (.+)$", function(items)
        return "ยังต้องการ: " .. items
    end},
    {"^Guaranteed pet in (%d+) trades, (%d+) free rerolls left$", function(trades, rerolls)
        return "รับประกันสัตว์เลี้ยงในอีก " .. trades .. " ครั้ง • สุ่มสูตรฟรีคงเหลือ " .. rerolls .. " ครั้ง"
    end},
    {"^Pen (%d+/%d+) %- (%d+) egg%(s%) ready to place$", function(p, n)
        return "คอก " .. p .. " • ไข่พร้อมวาง " .. n .. " ฟอง"
    end},
    {"^(%d+) egg%(s%) can be mutated$", function(n)
        return "มีไข่กลายพันธุ์ได้ " .. n .. " ฟอง"
    end},
    {"^(%d+) pet%(s%) match$", function(n)
        return "พบสัตว์เลี้ยง " .. n .. " ตัว"
    end},
    {"^(%d+) egg%(s%) match$", function(n)
        return "พบไข่ " .. n .. " ฟอง"
    end},
    {"^(%d+) lab egg%(s%) match$", function(n)
        return "พบไข่แล็บ " .. n .. " ฟอง"
    end},
    {"^(%d+) x (.+) ready to fuse$", function(n, name)
        return name .. " พร้อมผสม " .. n .. " ตัว"
    end},
    {"^(%d+) egg%(s%) ready to place$", function(n)
        return "ไข่พร้อมวาง " .. n .. " ฟอง"
    end},
    {"^(%d+) hours? ago$", function(n)
        return n .. " ชั่วโมงก่อน"
    end},
    {"^(%d+) days? ago$", function(n)
        return n .. " วันก่อน"
    end},
    {"^(%d+) minutes? ago$", function(n)
        return n .. " นาทีก่อน"
    end},
    {"^Welcome back[,]?$", function()
        return "ยินดีต้อนรับกลับ"
    end},
}

-- In the pin picker, Venyx can use RichText to render the option name
-- in white and the control type ("slider" / "button") in gray.
-- A raw string like `Min value /s <font ...>slider</font>` did not match
-- the plain-string dictionary in V1.5 and therefore stayed in English.
-- Match by the VISIBLE text only, never edit option IDs/callbacks.
local function pinnedLabelTranslation(text)
    local exact = TH[key(text)]
    if exact then return exact end
    -- Generic fallback for further pinned entries: translate only when
    -- their base name is already known in the UI dictionary.
    local base = text:match("^(.-)%s+slider$")
    if base then
        local baseThai = TH[key(base)]
        if baseThai then return "แถบปรับ" .. baseThai end
    end
    base = text:match("^(.-)%s+button$")
    if base then
        local baseThai = TH[key(base)]
        if baseThai then return "ปุ่ม" .. baseThai end
    end
    base = text:match("^(.-)%s+input$")
    if base then
        local baseThai = TH[key(base)]
        if baseThai then return "ช่องกรอก" .. baseThai end
    end
    return nil
end

local function translate(raw)
    if type(raw) ~= "string" or raw == "" then return raw end
    local normalized = tidy(raw)
    local translated = TH[key(normalized)]
    local richText = false
    if not translated then
        -- A UI-only fix: tolerate styled suffixes and extra whitespace.
        -- Unknown descriptions, account/player names and user inputs
        -- remain unchanged, avoiding accidental alteration of game data.
        richText = normalized:find("<[^>]+>") ~= nil
        local visible = normalized
        if richText then
            visible = visible:gsub("<[^>]+>", "")
            visible = visible:gsub("&nbsp;", " "):gsub("&amp;", "&")
        end
        visible = tidy((visible:gsub("%s+", " ")))
        translated = pinnedLabelTranslation(visible)
    end
    if not translated then
        -- Preserve everything that is not a known UI label, e.g. egg names,
        -- player names, inventory amounts, settings data and custom inputs.
        for _, rule in ipairs(DYNAMIC) do
            local captures = {string.match(normalized, rule[1])}
            if #captures > 0 then
                translated = rule[2](table.unpack(captures))
                break
            end
        end
    end
    if not translated and normalized:find("\n",1,true) then
        -- Pop-up descriptions may render multiple distinct known labels
        -- in ONE TextLabel. Translate lines without touching unknown lines.
        local changed=false
        local lines={}
        for line in (normalized.."\n"):gmatch("(.-)\n") do
            local candidate=translate(line)
            if candidate~=line then changed=true end
            lines[#lines+1]=candidate
        end
        if changed then translated=table.concat(lines,"\n") end
    end
    if not translated or translated == normalized then return raw end
    local pre = raw:match("^(%s*)") or ""
    local post = raw:match("(%s*)$") or ""
    -- For RichText pin labels, return clean Thai text rather than leaving
    -- English in font tags. This only affects those matching known labels.
    return pre .. translated .. post
end

local function isText(obj)
    return obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox")
end

local function translateProperty(obj, property)
    if not STATE.Running or STATE.Busy[obj] then return end
    local ok, current = pcall(function() return obj[property] end)
    if not ok or type(current) ~= "string" then return end
    -- Never replace what the user has typed into search/config text boxes.
    if property == "Text" and obj:IsA("TextBox") then return end
    local updated = translate(current)
    if updated == current then return end
    STATE.Busy[obj] = true
    local success = pcall(function() obj[property] = updated end)
    STATE.Busy[obj] = nil
    if success then STATE.Count = STATE.Count + 1 end
end

local function watchText(obj)
    if not STATE.Running or STATE.Observed[obj] or not isText(obj) then return end
    STATE.Observed[obj] = true
    translateProperty(obj, "Text")
    bind(obj:GetPropertyChangedSignal("Text"):Connect(function()
        translateProperty(obj, "Text")
    end))
    if obj:IsA("TextBox") then
        translateProperty(obj, "PlaceholderText")
        bind(obj:GetPropertyChangedSignal("PlaceholderText"):Connect(function()
            translateProperty(obj, "PlaceholderText")
        end))
    end
end

local function marker(text)
    if type(text) ~= "string" then return false end
    local lower = string.lower(text)
    return lower == "venyx" or lower == "venyx 🇹🇭"
        or lower:find("venyx discord", 1, true) ~= nil
        or lower:find("venyx sae", 1, true) ~= nil
end
-- Distinguish Chilli's *navigation button* from Venyx's full window.
-- IMPORTANT: VENYX Home contains a Chilli Hub/ZIGZAG promotional button.
-- The older "not chilliHeading" test rejected the actual VENYX window!
local function hasVenyxEvidence(root)
    if not root or not root.Parent then return false end
    local name=string.lower(tostring(root.Name or ""))
    if root:IsA("ScreenGui") and name:find("venyx",1,true) then
        return true
    end
    local brand=false
    local context=false
    local proof=false
    local seen=0
    for _,item in ipairs(root:GetDescendants()) do
        if isText(item) then
            local ok, value=pcall(function() return item.Text end)
            if ok and type(value)=="string" then
                local t=key(value:gsub("<[^>]+>",""))
                if t=="venyx" or t=="venyx 🇹🇭" or
                   t=="venyx / steal an egg" then brand=true end
                if t=="steal an egg" or t=="venyx / steal an egg" or
                   t=="venyx discord" then context=true end
                -- Visible controls that a mere Chilli sidebar shortcut
                -- doesn't have. Needed even on non-Home Venyx tabs.
                if t=="venyx discord" or t=="copy invite" or
                   t=="unload hub" or t=="what's new" or
                   t=="go to egg" or t=="delivery speed" or
                   t=="only these eggs" or t=="mutate first" or
                   t=="auto claim index rewards" or
                   t=="auto trade souls" or t=="monster order" or
                   t=="quick bar 1" or t=="pinned" then
                    proof=true
                end
                seen=seen+1
            end
        end
    end
    return brand and context and proof
end
local function isVenyxRoot(gui)
    if not gui or not gui.Parent then return false end
    if isText(gui) then return false end -- no Chilli "Venyx" button
    if not gui:IsA("ScreenGui") and not gui:IsA("Frame") and
       not gui:IsA("CanvasGroup") then return false end
    return hasVenyxEvidence(gui)
end

-- If both hubs share a ScreenGui, locate the actual VENYX window/frame
-- instead of translating every Chilli button or the game's HUD.
local function findVenyxSubwindow(screen)
    local best,bestSize=nil,math.huge
    for _,item in ipairs(screen:GetDescendants()) do
        if isText(item) then
            local ok,title=pcall(function() return item.Text end)
            if ok and type(title)=="string" then
                local t=key(title:gsub("<[^>]+>",""))
                if t=="venyx" or t=="venyx / steal an egg" then
                    local parent=item.Parent
                    while parent and parent~=screen do
                        if (parent:IsA("Frame") or parent:IsA("CanvasGroup")) then
                            local okSize,sz=pcall(function()return parent.AbsoluteSize end)
                            if okSize and sz.X>=330 and sz.Y>=180 and
                               hasVenyxEvidence(parent) then
                                -- Choose the narrowest Venyx subtree, NOT
                                -- the smallest on-screen frame: a Chilli
                                -- container can be smaller in pixel area.
                                local complexity=#parent:GetDescendants()
                                if complexity<bestSize then
                                    best,bestSize=parent,complexity
                                end
                            end
                        end
                        parent=parent.Parent
                    end
                end
            end
        end
    end
    return best
end

local function AddVenyxCredit(root)
    if not root or not root.Parent then return end
    if root:FindFirstChild("ZIGZAG_VENYX_TRANSLATION_CREDIT",true) then return end
    local host = nil
    for _,obj in ipairs(root:GetDescendants()) do
        if isText(obj) then
            local ok,t = pcall(function() return obj.Text end)
            if ok and type(t)=="string" and
                (key(t)=="venyx" or key(t):find("venyx / steal an egg",1,true)) then
                local ancestor = obj.Parent
                while ancestor and ancestor~=root do
                    if ancestor:IsA("GuiObject") and
                       ancestor.AbsoluteSize.X>=300 and
                       ancestor.AbsoluteSize.Y>=200 then
                        host=ancestor
                        break
                    end
                    ancestor=ancestor.Parent
                end
                if host then break end
            end
        end
    end
    if not host then
        for _,obj in ipairs(root:GetChildren()) do
            if obj:IsA("GuiObject") and obj.AbsoluteSize.X>=300 and
               obj.AbsoluteSize.Y>=200 then
                host=obj
                break
            end
        end
    end
    if not host then host=root end
    local label=Instance.new("TextLabel")
    label.Name="ZIGZAG_VENYX_TRANSLATION_CREDIT"
    label.BackgroundTransparency=1
    label.Active=false
    label.Selectable=false
    label.AnchorPoint=Vector2.new(1,1)
    label.Position=UDim2.new(1,-11,1,-6)
    label.Size=UDim2.fromOffset(190,16)
    label.Text="✦ แปลไทยโดย ZIGZAG"
    label.TextSize=12
    label.Font=Enum.Font.GothamBold
    label.TextColor3=Color3.fromRGB(255,138,228)
    label.TextStrokeColor3=Color3.fromRGB(22,7,43)
    label.TextStrokeTransparency=0.18
    label.TextXAlignment=Enum.TextXAlignment.Right
    label.ZIndex=200
    label.Parent=host
    -- Only cosmetic. Never modifies Venyx's control values or callbacks.
end

local function observeRoot(root)
    if not STATE.Running or STATE.Roots[root] then return end
    STATE.Roots[root] = true
    local looksLikeMain=false
    local okMain,isMain=pcall(isVenyxRoot,root)
    if okMain and isMain then looksLikeMain=true end
    if looksLikeMain then
        STATE.MainSeen=true
        pcall(AddVenyxCredit,root)
    end
    for _,obj in ipairs(root:GetDescendants()) do watchText(obj) end
    bind(root.DescendantAdded:Connect(function(obj)
        -- Postpone one frame: Venyx may set new text just after parenting.
        task.defer(function()
            if not STATE.Running then return end
            watchText(obj)
            for _,nested in ipairs(obj:GetDescendants()) do watchText(nested) end
        end)
    end))
    print("[ZIGZAG VENYX THAI] พบ UI Venyx และเปิดตัวแปลไทยแล้ว")
end

local function containers()
    local sources = {CoreGui, PlayerGui}
    if type(gethui) == "function" then
        local ok, hidden = pcall(gethui)
        if ok and typeof(hidden) == "Instance" and hidden ~= CoreGui and hidden ~= PlayerGui then
            table.insert(sources, hidden)
        end
    end
    return sources
end

-- V1.7 • The optional Steal Panel can be a second ScreenGui rather than
-- a child of the Venyx main window. Detect it from its visible header
-- AND its distinct controls, then watch only that panel subtree.
local function isPanelLayoutContainer(instance)
    return instance:IsA("Frame") or instance:IsA("ScrollingFrame")
        or instance:IsA("CanvasGroup")
end

local function isStealPanelHeader(text)
    local name = key(text)
    return name == "steal panel" or name == "แผงขโมยไข่"
end

local function hasStealPanelControls(parent)
    local foundAuto, foundFilter, foundSteal = false, false, false
    for _, descendant in ipairs(parent:GetDescendants()) do
        if isText(descendant) then
            local ok, value = pcall(function() return descendant.Text end)
            if ok and type(value) == "string" then
                local label = key(value)
                if label == "auto steal on" or label == "auto steal off"
                    or label == "ขโมยไข่อัตโนมัติ: เปิด" or label == "ขโมยไข่อัตโนมัติ: ปิด" then
                    foundAuto = true
                elseif label == "show: all" or label == "แสดง: ทั้งหมด"
                    or label:sub(1, 6) == "show: " then
                    foundFilter = true
                elseif label == "steal" or label == "ขโมยไข่" then
                    foundSteal = true
                end
            end
        end
        if foundAuto and (foundFilter or foundSteal) then return true end
    end
    return false
end

local function findStandaloneStealPanel(gui)
    for _, obj in ipairs(gui:GetDescendants()) do
        if isText(obj) then
            local ok, value = pcall(function() return obj.Text end)
            if ok and isStealPanelHeader(value) then
                local parent = obj.Parent
                while parent and parent ~= gui do
                    if isPanelLayoutContainer(parent) and hasStealPanelControls(parent) then
                        return parent
                    end
                    parent = parent.Parent
                end
                -- An independent ScreenGui can be the panel itself.
                if hasStealPanelControls(gui) then return gui end
            end
        end
    end
    return nil
end

local function scan()
    for _,host in ipairs(containers()) do
        local ok, items = pcall(function() return host:GetDescendants() end)
        if ok then
            for _,obj in ipairs(items) do
                if obj:IsA("ScreenGui") then
                    if not STATE.Roots[obj] then
                        local found, answer = pcall(isVenyxRoot, obj)
                        if found and answer then observeRoot(obj) end
                    end
                    -- The Steal Panel may live in a separate game ScreenGui.
                    -- Observe only its own Frame, not all of the game's HUD.
                    if not STATE.Roots[obj] then
                        local okPanel, panel = pcall(findStandaloneStealPanel, obj)
                        if okPanel and panel and not STATE.Roots[panel] then
                            observeRoot(panel)
                        end
                    end
                end
            end
        end
    end
end

-- Hybrid V1.8.1: detect Venyx's UI as it appears without a permanent
-- scan loop. Batch ScreenGui updates to avoid scanning once per label.
local HOST_WATCHED = setmetatable({}, {__mode="k"})
local SCREEN_PENDING = setmetatable({}, {__mode="k"})
local POPUP_UNIQUE={
    ["monster order"]=true,["most tokens"]=true,
    ["ghost target"]=true,["pin options"]=true,
    ["pinned actions"]=true,["selected pinned features"]=true,
    ["smoother & faster"]=true,["more steal methods"]=true,
    ["steal from players"]=true,["easy setup"]=true,
    ["quick bar 1"]=true,["steal rarities"]=true,
    ["which mutations"]=true,["auto vacuum ghouler boss"]=true,
}
local function isVenyxPopup(screen)
    if not STATE.MainSeen then return false end
    local title=false
    local options=0
    local hint=false
    local shortName=string.lower(tostring(screen.Name or ""))
    local popupNamed=shortName:find("popup",1,true) or
        shortName:find("dropdown",1,true) or
        shortName:find("picker",1,true) or
        shortName:find("modal",1,true)
    for _,obj in ipairs(screen:GetDescendants()) do
        if isText(obj) then
            local ok,t=pcall(function()return obj.Text end)
            if ok and type(t)=="string" then
                local k=key(t:gsub("<[^>]+>",""))
                if POPUP_UNIQUE[k] then title=true end
                if k=="search" or k=="select all" or k=="select one option" or
                   k=="select an option" or k=="choose an option" or
                   k=="search options" or k=="options" then hint=true end
                if TH[k] and k~="venyx" and k~="chilli hub" then
                    options=options+1
                end
            end
            if obj:IsA("TextBox") then
                local okPH,p=pcall(function()return obj.PlaceholderText end)
                if okPH and type(p)=="string" then
                    local ph=key(p)
                    if ph:find("search",1,true) or
                       ph:find("ค้นหา",1,true) then hint=true end
                end
            end
        end
    end
    return (title and options>=2) or
        (popupNamed and options>=3 and hint)
end
local function checkScreen(gui)
    if not STATE.Running or not gui or not gui.Parent then return end
    if STATE.Roots[gui] then return end
    local ok, answer=pcall(isVenyxRoot,gui)
    if ok and answer then
        -- Real Venyx Home has a *Chilli Hub shortcut* in its own UI.
        -- This is NOT evidence the whole window belongs to Chilli.
        local chTab=false
        for _,item in ipairs(gui:GetDescendants()) do
            if isText(item) then
                local okText,t=pcall(function()return item.Text end)
                if okText and type(t)=="string" then
                    local k=key(t)
                    if k:find("chilli hub",1,true) then chTab=true end
                end
            end
        end
        local mixed=false
        if chTab then
            -- If Chilli is top-level, isolate a Venyx sub-window; do not
            -- recolor/translate the whole Chilli container by accident.
            local n=string.lower(tostring(gui.Name or ""))
            mixed=n:find("chilli",1,true)~=nil
        end
        if mixed then
            local sub=findVenyxSubwindow(gui)
            if sub then
                observeRoot(sub)
                STATE.MainSeen=true
            end
        else
            observeRoot(gui)
            STATE.MainSeen=true
        end
        return
    end
    -- Venyx may be embedded in the same ScreenGui as Chilli. The
    -- window has its own header and labels: translate JUST that frame.
    local okSub,sub=pcall(findVenyxSubwindow,gui)
    if okSub and sub and not STATE.Roots[sub] then
        observeRoot(sub)
        STATE.MainSeen=true
    end
    local okPanel,panel=pcall(findStandaloneStealPanel,gui)
    if okPanel and panel and not STATE.Roots[panel] then
        observeRoot(panel)
    end
    if not STATE.Roots[gui] then
        local okPopup,popup=pcall(isVenyxPopup,gui)
        if okPopup and popup then observeRoot(gui) end
    end
end
local function scheduleScreen(gui)
    if not STATE.Running or not gui or not gui.Parent or SCREEN_PENDING[gui] then return end
    SCREEN_PENDING[gui]=true
    task.delay(0.16,function()
        SCREEN_PENDING[gui]=nil
        if STATE.Running then pcall(checkScreen,gui) end
    end)
end
local function watchHost(host)
    if not host or HOST_WATCHED[host] or not STATE.Running then return end
    HOST_WATCHED[host]=true
    bind(host.DescendantAdded:Connect(function(obj)
        if not STATE.Running then return end
        if obj:IsA("ScreenGui") then
            scheduleScreen(obj)
        elseif isText(obj) then
            local gui=obj:FindFirstAncestorWhichIsA("ScreenGui")
            if gui and not STATE.Roots[gui] then scheduleScreen(gui) end
        end
    end))
end
local function armVenyxHosts()
    if not STATE.Running then return end
    for _,host in ipairs(containers()) do watchHost(host) end
end
armVenyxHosts()
-- After Venyx has appeared, a click can open a separate pop-up/dropdown
-- not attached under its ScreenGui. Recheck once on touch (debounced),
-- no endless timer and no scanning each frame.
local POPUP_TOUCH_PENDING=false
local okInput,UIS=pcall(function() return game:GetService("UserInputService") end)
if okInput and UIS then
    bind(UIS.InputEnded:Connect(function(input)
        if not STATE.MainSeen or not STATE.Running or POPUP_TOUCH_PENDING then return end
        if input.UserInputType~=Enum.UserInputType.Touch and
           input.UserInputType~=Enum.UserInputType.MouseButton1 then return end
        POPUP_TOUCH_PENDING=true
        task.delay(0.10,function()
            POPUP_TOUCH_PENDING=false
            if STATE.Running then pcall(STATE.Recheck) end
        end)
    end))
end
-- Only a handful of discovery checks during startup. This catches a GUI
-- that was already open before the translator ran, including gethui roots.
for _,s in ipairs({0.1,0.6,1.6,3.2,6.0}) do
    task.delay(s,function()
        if not STATE.Running then return end
        armVenyxHosts()
        pcall(STATE.Recheck)
    end)
end

-- Recheck on demand when Chilli opens Venyx and when a separate pop-up
-- is added by the remote UI. It is bounded and never runs per-frame.
function STATE.Recheck()
    if not STATE.Running then return end
    armVenyxHosts()
    for _,host in ipairs(containers()) do
        local ok,all=pcall(function() return host:GetDescendants() end)
        if ok then
            for _,obj in ipairs(all) do
                if obj:IsA("ScreenGui") then pcall(checkScreen,obj) end
            end
        end
    end
end


]===]

-- Start Venyx translation with its own isolated scope/state. If the user
-- already has Venyx UI open, it is translated in place, not reloaded.
do
    local old=ZIGZAG_HYBRID_ENV.__ZIGZAG_VENYX_THAI_STATE
    if not (ZIGZAG_HYBRID_ENV.__ZIGZAG_HYBRID_VENYX_ARMED==ZIGZAG_HYBRID_SESSION
        and old and old.Running) then
        local f,err=loadstring(ZIGZAG_HYBRID_VENYX_CORE)
        if f then
            local ok,reason=pcall(f)
            if ok then
                ZIGZAG_HYBRID_ENV.__ZIGZAG_HYBRID_VENYX_ARMED=ZIGZAG_HYBRID_SESSION
                print("✅ [ZIGZAG] Venyx THAI V1.9 armed inside Chilli")
            else
                warn("[ZIGZAG HYBRID] Venyx translator runtime:",reason)
            end
        else
            warn("[ZIGZAG HYBRID] Venyx translator syntax:",err)
        end
    end
end

local function ZIGZAG_HybridHasVenyx()
    -- Check for the ACTUAL Venyx main window, not the Chilli promotional tab.
    local roots={CoreGui,PlayerGui}
    if type(gethui)=="function" then
        local ok,hui=pcall(gethui)
        if ok and hui and hui~=CoreGui and hui~=PlayerGui then
            table.insert(roots,hui)
        end
    end
    for _,host in ipairs(roots) do
        local ok,items=pcall(function() return host:GetDescendants() end)
        if ok then
            for _,gui in ipairs(items) do
                if gui:IsA("ScreenGui") then
                    local n=string.lower(tostring(gui.Name or ""))
                    if n:find("venyx",1,true) then return true end
                    local title=false
                    local ident=false
                    local chilli=false
                    local proof=false
                    for _,obj in ipairs(gui:GetDescendants()) do
                        if IsTextObject(obj) then
                            local okText,t=pcall(function() return obj.Text end)
                            if okText and type(t)=="string" then
                                local lower=string.lower(CleanText(t))
                                if lower=="venyx" or
                                   lower:find("venyx / steal an egg",1,true) then title=true end
                                if lower=="steal an egg" or
                                   lower:find("venyx / steal an egg",1,true) or
                                   lower=="venyx discord" then ident=true end
                                if lower=="venyx discord" or lower=="copy invite" or
                                   lower=="unload hub" or lower=="go to egg" or
                                   lower=="delivery speed" or lower=="only these eggs" or
                                   lower=="auto claim index rewards" or
                                   lower=="monster order" then proof=true end
                                if lower=="chilli hub" or
                                   lower:find("chilli hub 🇹🇭",1,true) then chilli=true end
                            end
                        end
                    end
                    if title and ident and proof then return true end
                end
            end
        end
    end
    return false
end

local ZIGZAG_HybridLoadingVenyx=false
local function ZIGZAG_HybridLaunchVenyx()
    if ZIGZAG_HybridLoadingVenyx then return end
    if ZIGZAG_HYBRID_ENV.__ZIGZAG_HYBRID_VENYX_LAUNCH==ZIGZAG_HYBRID_SESSION then
        return
    end
    if ZIGZAG_HybridHasVenyx() then
        ZIGZAG_HYBRID_ENV.__ZIGZAG_HYBRID_VENYX_LAUNCH=ZIGZAG_HYBRID_SESSION
        return
    end
    ZIGZAG_HybridLoadingVenyx=true
    ZIGZAG_HYBRID_ENV.__ZIGZAG_HYBRID_VENYX_LAUNCH=ZIGZAG_HYBRID_SESSION
    task.spawn(function()
        local ok,err=pcall(function()
            local src=game:HttpGet(ZIGZAG_HYBRID_VENYX_SOURCE)
            local fn,compileError=loadstring(src)
            if type(fn)~="function" then error(compileError or "Venyx compile failed") end
            fn()
        end)
        ZIGZAG_HybridLoadingVenyx=false
        if not ok then
            ZIGZAG_HYBRID_ENV.__ZIGZAG_HYBRID_VENYX_LAUNCH=nil
            warn("[ZIGZAG HYBRID] เปิด Venyx ไม่สำเร็จ:",err)
        else
            -- Venyx opens asynchronously; a few bounded checks are safer
            -- than relying only on the time of a single popup creation.
            for _,waitSec in ipairs({0.3,1,2.5,5,8}) do
                task.delay(waitSec,function()
                    local state=ZIGZAG_HYBRID_ENV.__ZIGZAG_VENYX_THAI_STATE
                    if state and type(state.Recheck)=="function" then
                        pcall(state.Recheck)
                    end
                end)
            end
            print("✅ [ZIGZAG HYBRID] Venyx launched ONCE from Chilli; translator refresh armed")
        end
    end)
end

-- The native Chilli Venyx tab is a TextButton on some builds and a
-- Frame+TextLabel on mobile. Use ONE non-invasive touch listener for both.
-- DO NOT change its callback, color (native Venyx tab stays red), or layout.
local ZIGZAG_HybridVenyxTabs=setmetatable({}, {__mode="k"})
local function ZIGZAG_HybridTrackTab(obj)
    if not obj or not IsTextObject(obj) or not obj.Parent then return end
    if not MainChilliGui or not MainChilliGui.Parent or not obj:IsDescendantOf(MainChilliGui) then return end
    local ok,value=pcall(function() return obj.Text end)
    if not ok or type(value)~="string" or
       string.lower(CleanText(value))~="venyx" then return end
    ZIGZAG_HybridVenyxTabs[obj]=true
end
local ZIGZAG_HybridTabInput=Bind(UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType~=Enum.UserInputType.Touch and
       input.UserInputType~=Enum.UserInputType.MouseButton1 then return end
    if not MainChilliGui or not MainChilliGui.Parent then return end
    if MainChilliGui:IsA("ScreenGui") and not MainChilliGui.Enabled then return end
    local pos=input.Position
    for label in pairs(ZIGZAG_HybridVenyxTabs) do
        if label.Parent and label:IsDescendantOf(MainChilliGui) and
           IsGuiVisible(label) then
            local at,size=label.AbsolutePosition,label.AbsoluteSize
            if size.X>=24 and size.Y>=12 and
               pos.X>=at.X-4 and pos.X<=at.X+size.X+4 and
               pos.Y>=at.Y-4 and pos.Y<=at.Y+size.Y+4 then
                task.defer(ZIGZAG_HybridLaunchVenyx)
                -- Even when the *native* Chilli tab opens Venyx itself,
                -- refresh the translator after the tab/popup becomes visible.
                task.delay(0.5,function()
                    local state=ZIGZAG_HYBRID_ENV.__ZIGZAG_VENYX_THAI_STATE
                    if state and type(state.Recheck)=="function" then pcall(state.Recheck) end
                end)
                break
            end
        end
    end
end))

-- Startup tab recognition and event hooks; no per-frame/scan timer.
local ZIGZAG_HybridAddCredit
ZIGZAG_HybridAddCredit=function(gui)
    if not gui or not gui.Parent then return end
    if gui:FindFirstChild("ZIGZAG_CHILLI_TRANSLATION_CREDIT",true) then return end
    local host=nil
    for _,obj in ipairs(gui:GetDescendants()) do
        if IsChilliTitle(obj) then
            local current=obj.Parent
            while current and current~=gui do
                if current:IsA("GuiObject") and
                   current.AbsoluteSize.X>=350 and current.AbsoluteSize.Y>=200 then
                    host=current
                    break
                end
                current=current.Parent
            end
            break
        end
    end
    if not host then host=gui end
    local credit=Instance.new("TextLabel")
    credit.Name="ZIGZAG_CHILLI_TRANSLATION_CREDIT"
    credit.BackgroundTransparency=1
    credit.AnchorPoint=Vector2.new(1,1)
    credit.Position=UDim2.new(1,-10,1,-4)
    credit.Size=UDim2.fromOffset(176,17)
    credit.Text="✦ แปลไทยโดย ZIGZAG"
    credit.TextColor3=Color3.fromRGB(255,166,240)
    credit.TextSize=12
    credit.Font=Enum.Font.GothamBold
    credit.TextXAlignment=Enum.TextXAlignment.Right
    credit.TextStrokeTransparency=0.23
    credit.TextStrokeColor3=Color3.fromRGB(31,5,57)
    credit.ZIndex=1000
    credit.Active=false
    credit.Selectable=false
    credit.Parent=host
    table.insert(THEME_LOGOS,credit)
end
local function ZIGZAG_HybridRegisterChilli()
    if not MainChilliGui or not MainChilliGui.Parent then return end
    for _,obj in ipairs(MainChilliGui:GetDescendants()) do
        if IsTextObject(obj) then ZIGZAG_HybridTrackTab(obj) end
    end
    ZIGZAG_HybridAddCredit(MainChilliGui)
end

-- Hook into the existing Chilli tracking function WITHOUT replacing Chilli's
-- working translator/theme. This wrapper is scoped to this Lua chunk only.
local ZIGZAG_HybridOriginalTrackChilli=TrackChilli
TrackChilli=function(gui)
    ZIGZAG_HybridOriginalTrackChilli(gui)
    ZIGZAG_HybridRegisterChilli()
end
-- If Chilli was already present when this translator was armed, discover it.
if FindExistingChilli() then ZIGZAG_HybridRegisterChilli() end
Bind(PlayerGui.DescendantAdded:Connect(function(obj)
    if MainChilliGui and MainChilliGui.Parent and IsTextObject(obj) then
        task.defer(function()
            if obj.Parent then ZIGZAG_HybridTrackTab(obj) end
        end)
    end
end))
Bind(CoreGui.DescendantAdded:Connect(function(obj)
    if MainChilliGui and MainChilliGui.Parent and IsTextObject(obj) then
        task.defer(function()
            if obj.Parent then ZIGZAG_HybridTrackTab(obj) end
        end)
    end
end))

-- One combined-file shutdown also stops only the embedded Venyx translator.
local ZIGZAG_HybridPreviousDisconnect=STATE.Disconnect
function STATE.Disconnect()
    local v=ZIGZAG_HYBRID_ENV.__ZIGZAG_VENYX_THAI_STATE
    if v and type(v.Stop)=="function" then pcall(v.Stop) end
    ZIGZAG_HybridPreviousDisconnect()
end
print("✅ CHILLI + VENYX THAI ZIGZAG / single entry; click Chilli's Venyx tab")

--========================================================
-- 18-19. TRANSLATOR ARMED + ORIGINAL DIRECT CHILLI LOADER
--========================================================

-- This continuation intentionally does not run SOURCE_URL/Chilli gameplay code.
-- Chilli's own Auto Execute, or any independent loader, remains responsible
-- for loading the actual Chilli UI in the destination server.
local CHILLI_ALREADY_OPEN = FindExistingChilli()
if CHILLI_ALREADY_OPEN then
    print("[ZIGZAG TP] Existing Chilli found; translated/recolored without gameplay reload")
else
    print("[ZIGZAG TP] Watching for Chilli UI; original gameplay loader not duplicated")
end

--========================================================
-- 20-21. STARTUP FALLBACK ONLY, NO PERMANENT FULL SCAN
--========================================================

task.spawn(function()
    task.wait(0.3)
    if FindExistingChilli() then return end
    task.wait(0.6)
    if FindExistingChilli() then return end
    task.wait(1)
    if FindExistingChilli() then return end
    task.wait(2)
    FindExistingChilli()
end)

task.delay(3,function()
    if type(gethui) == "function" then
        local ok,hui = pcall(gethui)
        if ok and hui then
            if AddRoot(hui) then WatchRoot(hui) end
        end
    end
    FindExistingChilli()
end)

--========================================================
-- 22-23. NOTIFICATION / CONSOLE
--========================================================

task.delay(2,function()
    pcall(function()
        StarterGui:SetCore("SendNotification",{
            Title="🌶️ Chilli ZIGZAG",
            Text="V1.8.5 | Halloween, Blood Moon & Fishing",
            Duration=4
        })
    end)
end)
print("==============================================")
print("✅ CHILLI + VENYX THAI - ZIGZAG V1.8.5 BLOOD MOON + FISHING FULL MERGED")
print("✅ FORCE-PURPLE SIDEBARS: FRAME/TEXTLABEL + DYNAMIC GRADIENT")
print("✅ DIRECT ORIGINAL CHILLI SOURCE")
print("✅ LOADER + TRANSLATOR ONE BLOCK")
print("✅ ALL V1.4 TRANSLATIONS PRESERVED + BUTTERFLY BLOOM / WISP")
print("✅ NEW INSTANT STEAL ZONES / TELEPORT TO EGG TRANSLATED")
print("✅ FLOATING STEAL PANEL ON/OFF TRANSLATED")
print("✅ DROP EGGS AT SAFE ZONE TRANSLATED")
print("✅ OVER 100% MAY GLITCH TRANSLATED")
print("✅ CHASE SETTINGS TRANSLATED")
print("✅ DYNAMIC PURPLE BORDERS + SAFE UI ZORDER + DR SCROLL GUARD")
print("✅ PROPERTY EVENT WATCHERS RESTORE PURPLE AFTER CHILLI RECOLORS")
print("✅ V1.7 RACING EVENT / SHOOTING STAR / AUTO MUTATION")
print("✅ V1.7 QUICK BAR NEW LABELS / RACE COUNTDOWN")
print("✅ V1.7.1 ADMIN ABUSE / CAPTURE / MINIGAME TRANSLATIONS")
print("✅ NO TEXT OVERRIDES FROM THEME / NO PERMANENT FULL SCAN")
print("==============================================")
]====]
    local function ZIGZAG_GET_QUEUE()
        if type(queue_on_teleport)=="function" then return queue_on_teleport end
        if type(queueonteleport)=="function" then return queueonteleport end
        if type(syn)=="table" and type(syn.queue_on_teleport)=="function" then
            return syn.queue_on_teleport
        end
        if type(fluxus)=="table" and type(fluxus.queue_on_teleport)=="function" then
            return fluxus.queue_on_teleport
        end
        if type(ENV.queue_on_teleport)=="function" then
            return ENV.queue_on_teleport
        end
        return nil
    end
    local q=ZIGZAG_GET_QUEUE()
    if q then
        local continuation=string.format(ZIGZAG_BOOT_TEMPLATE,
            ZIGZAG_TRANSLATOR_SOURCE,ZIGZAG_BOOT_TEMPLATE)
        local ok,err=pcall(q,continuation)
        if not ok and type(writefile)=="function" and type(readfile)=="function" then
            local path="ZIGZAG_CHILLI_V187_POPUP_AUTO_SELL_TP_CACHE.lua"
            local saved=pcall(writefile,path,continuation)
            if saved then
                local tiny='local f=readfile("ZIGZAG_CHILLI_V187_POPUP_AUTO_SELL_TP_CACHE.lua"); local r=loadstring(f); if r then r() end'
                ok,err=pcall(q,tiny)
            end
        end
        if not ok then
            warn("[ZIGZAG TP] Unable to arm self-contained translator (use Auto Execute):",err)
        else
            print("✅ [ZIGZAG TP] Multi-hop Thai & purple theme queued (gameplay loader excluded)")
        end
    else
        warn("[ZIGZAG TP] This executor has no queue_on_teleport. Enable Auto Execute for V1.8.5 on your executor.")
    end
end

--========================================================
-- 18-19. TRANSLATOR ARMED + ORIGINAL DIRECT CHILLI LOADER
--========================================================

local CHILLI_ALREADY_OPEN = FindExistingChilli()
if not CHILLI_ALREADY_OPEN then
    local ok,source = pcall(function() return game:HttpGet(SOURCE_URL) end)
    if not ok then
        warn("[ZIGZAG] โหลด Chilli ไม่สำเร็จ:",source)
    else
        local runScript,loadError = loadstring(source)
        if not runScript then
            warn("[ZIGZAG] Chilli Load Error:",loadError)
        else
            local success,runError = pcall(runScript)
            if not success then warn("[ZIGZAG] Chilli Runtime Error:",runError) end
        end
    end
end

--========================================================
-- 20-21. STARTUP FALLBACK ONLY, NO PERMANENT FULL SCAN
--========================================================

task.spawn(function()
    task.wait(0.3)
    if FindExistingChilli() then return end
    task.wait(0.6)
    if FindExistingChilli() then return end
    task.wait(1)
    if FindExistingChilli() then return end
    task.wait(2)
    FindExistingChilli()
end)

task.delay(3,function()
    if type(gethui) == "function" then
        local ok,hui = pcall(gethui)
        if ok and hui then
            if AddRoot(hui) then WatchRoot(hui) end
        end
    end
    FindExistingChilli()
end)

--========================================================
-- 22-23. NOTIFICATION / CONSOLE
--========================================================

task.delay(2,function()
    pcall(function()
        StarterGui:SetCore("SendNotification",{
            Title="🌶️ Chilli ZIGZAG",
            Text="V1.8.5 | Halloween, Blood Moon & Fishing",
            Duration=4
        })
    end)
end)
print("==============================================")
print("✅ CHILLI + VENYX THAI - ZIGZAG V1.8.5 BLOOD MOON + FISHING FULL MERGED")
print("✅ FORCE-PURPLE SIDEBARS: FRAME/TEXTLABEL + DYNAMIC GRADIENT")
print("✅ DIRECT ORIGINAL CHILLI SOURCE")
print("✅ LOADER + TRANSLATOR ONE BLOCK")
print("✅ ALL V1.4 TRANSLATIONS PRESERVED + BUTTERFLY BLOOM / WISP")
print("✅ NEW INSTANT STEAL ZONES / TELEPORT TO EGG TRANSLATED")
print("✅ FLOATING STEAL PANEL ON/OFF TRANSLATED")
print("✅ DROP EGGS AT SAFE ZONE TRANSLATED")
print("✅ OVER 100% MAY GLITCH TRANSLATED")
print("✅ CHASE SETTINGS TRANSLATED")
print("✅ DYNAMIC PURPLE BORDERS + SAFE UI ZORDER + DR SCROLL GUARD")
print("✅ PROPERTY EVENT WATCHERS RESTORE PURPLE AFTER CHILLI RECOLORS")
print("✅ V1.7 RACING EVENT / SHOOTING STAR / AUTO MUTATION")
print("✅ V1.7 QUICK BAR NEW LABELS / RACE COUNTDOWN")
print("✅ V1.7.1 ADMIN ABUSE / CAPTURE / MINIGAME TRANSLATIONS")
print("✅ NO TEXT OVERRIDES FROM THEME / NO PERMANENT FULL SCAN")
print("==============================================")
