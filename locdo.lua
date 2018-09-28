szChungLib = system.GetScriptFolder().."\\LIB\\chung.luac"
IncludeFile(szChungLib)

tbThuocTinh = {
    [43] = 1, -- khong the pha huy
    [58] = 2, -- bo qua ne tranh
    [85] = 200, -- sinh luc (+sinhluc mu dinh quoc cung la 85)
    [89] = 180, -- noi luc
    [93] = 180, -- the luc
    [97] = 17, -- suc manh
    [98] = 17, --than phap
    [99] = 17, -- sinh khi
    [88] = 6, -- phuc hoi sinh luc moi nua giay
    [92] = 6, -- phuc hoi noi luc moi nua giay
    [96] = 8, -- phuc hoi the luc moi nua giay
    [101] = 25, -- khang doc
    [102] = 25, -- khang hoa
    [103] = 30, -- khang loi
    [104] = 25, -- ptvl
    [105] = 25, -- khang bang
    [106] = 40, -- tg lam cham
    [108] = 40, -- tg trung doc
    [110] = 40, -- tg lam choang
    [111] = 40, -- toc do di chuyen
    [113] = 40, -- thoi gian phuc hoi
    [115] = 30, -- toc do danh (ngoai cong)
    [116] = 40, -- toc do danh (noi cong)
    [114] = 17, -- khang tat ca
    [117] = 17, -- phan don can chien
    [135] = 8, -- may man %
    [121] = 50, -- stvl diem (dong an)
    [122] = 100, -- hoa sat ngoai cong
    [123] = 100, -- bang sat ngoai cong
    [124] = 100, -- loi sat sat ngoai cong
    [125] = 50, -- doc sat ngoai cong
    [126] = 95, -- stvl % (dong hien)
    [134] = 13, -- chsttnl
    [136] = 8, -- hut sinh luc
    [137] = 8, -- hut noi
    [139] = 3, -- ky nang cua phai do duoc cong them
    [166] = 500, -- ti le cong kich chinh xac
    [168] = 196, -- stvl noi cong
    [169] = 196, -- bang sat noi cong
    [170] = 196, -- hoa sat noi cong
    [171] = 196, -- loi sat noi cong
    [172] = 45,  -- doc sat noi cong
}

-- Loc do theo SET
gl_LocDoTheoSet = 1
-- Loc do theo che do auto
-- gl_LocDoTheoSet = 0

-- Set Do
tbSetDo[1] = {
    -- set 1
    [85] = 200, -- sinh luc
    [98] = 20, --than phap
    [104] = 25, -- ptvl
    [106] = 40, -- tg lam cham
}
tbSetDo[2] = {
    -- set 2
    [85] = 200, -- sinh luc
    [104] = 25, -- ptvl
    [106] = 40, -- tg lam cham
    [134] = 15, -- chsttnl
}
tbSetDo[3] = {
    -- set 3
    [85] = 200, -- sinh luc
    [134] = 15, -- chsttnl
    [104] = 25, -- ptvl
}
-- Loc do theo che do auto va neu co 4 dong vip tro len thi giu lai
gl_SoDongVip = 4

function NhanDo()
    -- talkNPC()
    useLenhBai()
    clickMenuAll(1,2,0,3)
    nhapso(10) 
    enter()
end

function main()
    writeThuocTinh()
    -- while true do
    --     LocDo()
    --     NhanDo()
    -- end
end