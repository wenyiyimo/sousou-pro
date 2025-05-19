require("import");
import("common.BaseActivity");
import "pages.qiyi.layout"

activity.setContentView(layout);

local qiyi_vpg = ArrayList()
qiyi_vpg.add(loadlayout(base_qiyi_out("top1")))
qiyi_vpg.add(loadlayout(base_qiyi_out("top2")))
qiyi_vpg.add(loadlayout(base_qiyi_out("top3")))
qiyi_vpg.add(loadlayout(base_qiyi_out("top4")))
qiyi_vpg.add(loadlayout(base_qiyi_out("top5")))
qiyi_vpg.add(loadlayout(base_qiyi_out("top6")))
qiyi_page.setAdapter(BasePagerAdapter(qiyi_vpg))

top1.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL))

top2.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL))
top3.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL))
top3.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL))
top4.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL))
top5.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL))
top6.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL))

function changeTab(num)
    qiyi_top1.textColor = ColorStyles().black
    qiyi_top2.textColor = ColorStyles().black
    qiyi_top3.textColor = ColorStyles().black
    qiyi_top4.textColor = ColorStyles().black
    qiyi_top5.textColor = ColorStyles().black
    qiyi_top6.textColor = ColorStyles().black
    qiyi_top1.textSize = TextSizes().medium
    qiyi_top2.textSize = TextSizes().medium
    qiyi_top3.textSize = TextSizes().medium
    qiyi_top4.textSize = TextSizes().medium
    qiyi_top5.textSize = TextSizes().medium
    qiyi_top6.textSize = TextSizes().medium
    local button = loadstring("return qiyi_top" .. tostring(num))()
    button.textColor = ColorStyles().blue
    button.textSize = TextSizes().big_little
end

changeTab(1)


qiyi_page.setOnPageChangeListener(ViewPager.OnPageChangeListener {
    onPageSelected = function(a)
        changeTab(a + 1)
    end,
    onPageScrolled = function(a, b, c)
        qiyi_scrollbar.setX(activity.getWidth() / 6 * (b + a) + activity.getWidth() * 0.015)
    end

})
qiyi_top1.onClick = function()
    qiyi_page.setCurrentItem(0)
end
qiyi_top2.onClick = function()
    qiyi_page.setCurrentItem(1)
end
qiyi_top3.onClick = function()
    qiyi_page.setCurrentItem(2)
end
qiyi_top4.onClick = function()
    qiyi_page.setCurrentItem(3)
end
qiyi_top5.onClick = function()
    qiyi_page.setCurrentItem(4)
end
qiyi_top6.onClick = function()
    qiyi_page.setCurrentItem(5)
end
local topUrls =
    {"https://pub.m.iqiyi.com/h5/main/hotList/interRep/?channelId=-1&dim=hour&type=realTime&pageNum=PAGE&len=20",
     "https://pub.m.iqiyi.com/h5/main/hotList/interRep/?channelId=2&dim=hour&type=realTime&pageNum=PAGE&len=20",
     "https://pub.m.iqiyi.com/h5/main/hotList/interRep/?channelId=1&dim=hour&type=realTime&pageNum=PAGE&len=20",
     "https://pub.m.iqiyi.com/h5/main/hotList/interRep/?channelId=4&dim=hour&type=realTime&pageNum=PAGE&len=20",
     "https://pub.m.iqiyi.com/h5/main/hotList/interRep/?channelId=6&dim=hour&type=realTime&pageNum=PAGE&len=20",
     "https://pub.m.iqiyi.com/h5/main/hotList/interRep/?channelId=-1&dim=hour&type=rise&pageNum=PAGE&len=20"}
local top1_datas = {}
local top2_datas = {}
local top3_datas = {}
local top4_datas = {}
local top5_datas = {}
local top6_datas = {}
function getTopAdapter(tv_datas, tag)
    return LuaCustRecyclerAdapter(AdapterCreator({
        getItemCount = function()
            return #tv_datas
        end,
        getItemViewType = function(position)
            return 0
        end,
        onCreateViewHolder = function(parent, viewType)
            local views = {}
            local holder
            if isMobile then
                holder = LuaCustRecyclerHolder(loadlayout(top_item_out, views))
            else
                holder = LuaCustRecyclerHolder(loadlayout(top_hitem_out, views))
            end

            holder.view.setTag(views)
            return holder
        end,
        onBindViewHolder = function(holder, position)
            -- print(data[position+1][1])
            local view = holder.view.getTag()
            view.titleout.text = tv_datas[position + 1]['title']
            view.hotout.text = tv_datas[position + 1]['sortnum']
            view.subtitleout.text = tv_datas[position + 1]['subtitle']
            view.hotnumout.text = tv_datas[position + 1]['hotnum']
            view.stateout.text = tv_datas[position + 1]['state']
            view.sortcolor.cardBackgroundColor = tv_datas[position + 1]['bcolor']
            local url = tv_datas[position + 1]['pic']
            if not startswith(url, 'http') then
                url = 'http:' .. url
            end
            glideImg(view.picout, url)
            view.item.onClick = function()
                activity.newActivity("pages/search/search/search", {tv_datas[position + 1]['title']})
            end

            if #tv_datas == position + 1 and #tv_datas ~= 0 then
                getTopMoreDatas(tointeger((position + 1) / 10) + 1, tag, tv_datas)
            end
        end
    }))
end
local top1_adapter = getTopAdapter(top1_datas, 1)
local top2_adapter = getTopAdapter(top2_datas, 2)
local top3_adapter = getTopAdapter(top3_datas, 3)
local top4_adapter = getTopAdapter(top4_datas, 4)
local top5_adapter = getTopAdapter(top5_datas, 5)
local top6_adapter = getTopAdapter(top6_datas, 6)
top1.setAdapter(top1_adapter)
top2.setAdapter(top2_adapter)
top3.setAdapter(top3_adapter)
top4.setAdapter(top4_adapter)
top5.setAdapter(top5_adapter)
top6.setAdapter(top6_adapter)
function getTopMoreDatas(page, tag, datas)
    httpUtil.request(replace(topUrls[tag], "PAGE", tostring(page)), function(code, content, cookie, header)
        if code == 200 then
            if not content:find("title") then
                showToast("没有更多了")
                return
            end
            local html_datas = cjson.decode(content).data.items
            for k, v in pairs(html_datas) do
                local bcolor = 4287933100
                local title = v.mainTitle
                local pic = v.imageUrl
                local subtitle = v.subtitle
                local state = v.lowerRightCorner
                local hotnum = "热度  " .. v.kvs.hot_idx
                local sortnum = v.kvs.rank
                if tointeger(sortnum) == 1 then
                    bcolor = 4294901760
                elseif tointeger(sortnum) == 2 then
                    bcolor = 4294931076
                elseif tointeger(sortnum) == 3 then
                    bcolor = 4294939459
                end
                table.insert(datas, {
                    bcolor = bcolor,
                    title = title,
                    pic = pic,
                    subtitle = subtitle,
                    state = state,
                    hotnum = hotnum,
                    sortnum = sortnum
                })
            end
            if tag == 1 and top1_adapter then
                top1_adapter.notifyDataSetChanged()
            elseif tag == 2 and top2_adapter then
                top2_adapter.notifyDataSetChanged()
            elseif tag == 3 and top3_adapter then
                top3_adapter.notifyDataSetChanged()
            elseif tag == 4 and top4_adapter then
                top4_adapter.notifyDataSetChanged()
            elseif tag == 5 and top5_adapter then
                top5_adapter.notifyDataSetChanged()
            elseif tag == 6 and top6_adapter then
                top6_adapter.notifyDataSetChanged()
            else
            end
        end
    end)
end
getTopMoreDatas(1, 1, top1_datas)
getTopMoreDatas(1, 2, top2_datas)
getTopMoreDatas(1, 3, top3_datas)
getTopMoreDatas(1, 4, top4_datas)
getTopMoreDatas(1, 5, top5_datas)
getTopMoreDatas(1, 6, top6_datas)
