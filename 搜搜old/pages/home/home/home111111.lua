homeRowNum = settingUtil.getSettingKey("homeRowNum", 1)
homeActivesites = siteUtil.getHomeActiveClassSites()

homeSiteUrl = settingUtil.getSettingKey("homeSiteUrl")
homeSiteName = settingUtil.getSettingKey("homeSiteName")

function getHomeSite()

    if length(homeActivesites) > 0 then

        if homeSiteUrl and homeSiteName then

            for k, v in pairs(homeActivesites) do

                if v[1] == homeSiteUrl and v[2] == homeSiteName then
                    return v[3]
                end
            end

            homeSiteUrl = homeActivesites[1][1]
            homeSiteName = homeActivesites[1][2]
            settingUtil.setSetting("homeSiteName", homeSiteName)
            settingUtil.setSetting("homeSiteUrl", homeSiteUrl)
            showToast("未发现设置首页的站源，已自动设置为默认站源！")
            return homeActivesites[1][3]
        else
            homeSiteUrl = homeActivesites[1][1]
            homeSiteName = homeActivesites[1][2]
            settingUtil.setSetting("homeSiteName", homeSiteName)
            settingUtil.setSetting("homeSiteUrl", homeSiteUrl)
            return homeActivesites[1][3]
        end
    else
        showToast("未发现可用的站源，请先添加站源！")
        return false
    end

end

homeSite = getHomeSite()
if homeSite then
    import "pages.home.home.body"
end

-- tv_recycler_out.setLayoutManager(StaggeredGridLayoutManager(homeRowNum, StaggeredGridLayoutManager.HORIZONTAL))
-- mv_recycler_out.setLayoutManager(StaggeredGridLayoutManager(homeRowNum, StaggeredGridLayoutManager.HORIZONTAL))
-- cv_recycler_out.setLayoutManager(StaggeredGridLayoutManager(homeRowNum, StaggeredGridLayoutManager.HORIZONTAL))
-- sv_recycler_out.setLayoutManager(StaggeredGridLayoutManager(homeRowNum, StaggeredGridLayoutManager.HORIZONTAL))

-- function getAdapter(tv_datas, tag, adapter)
--     return LuaCustRecyclerAdapter(AdapterCreator({
--         getItemCount = function()
--             return #tv_datas
--         end,
--         getItemViewType = function(position)
--             return 0
--         end,
--         onCreateViewHolder = function(parent, viewType)
--             local views = {}
--             local holder
--             if isMobile then
--                 holder = LuaCustRecyclerHolder(loadlayout(getVHcomponent(), views))
--             else
--                 holder = LuaCustRecyclerHolder(loadlayout(getHHcomponent(), views))
--             end
--             holder.view.setTag(views)
--             return holder
--         end,
--         onBindViewHolder = function(holder, position)
--             -- print(data[position+1][1])
--             local view = holder.view.getTag()
--             view.title.text = tv_datas[position + 1]['标题']
--             if tv_datas[position + 1]['状态'] and #tv_datas[position + 1]['状态'] > 0 then
--                 view.state.text = tv_datas[position + 1]['状态']
--             else
--                 view.state.setVisibility(View.GONE)
--             end
--             if tv_datas[position + 1]['评分'] and #tv_datas[position + 1]['评分'] > 0 then
--                 view.rate.text = tv_datas[position + 1]['评分']
--             else
--                 view.rate.setVisibility(View.GONE)
--             end
--             view.href.text = tv_datas[position + 1]['地址']

--             local url = tv_datas[position + 1]['图片']
--             glideImg(view.img, url)

--             -- 子项目点击事件
--             -- 为Item设置点击事件
--             view.img.onClick = function()
--                 activity.newActivity("pages/search/search/search", {view.title.text})
--             end;
--             if #tv_datas == position + 1 and #tv_datas ~= 0 then
--                 -- print(11)
--                 -- lunboout.setCurrentItem(0,true)
--                 getHomePage1Datas(tointeger((position + 1) / 10) + 1, tag, tv_datas)
--             end
--         end
--     }))
-- end
-- local home_tv_datas, home_mv_datas, home_cv_datas, home_sv_datas = {}, {}, {}, {}

-- local home_tv_adapter = getAdapter(home_tv_datas, 1, home_tv_adapter)
-- local home_mv_adapter = getAdapter(home_mv_datas, 2, home_mv_adapter)
-- local home_cv_adapter = getAdapter(home_cv_datas, 3, home_cv_adapter)
-- local home_sv_adapter = getAdapter(home_sv_datas, 4, home_sv_adapter)
-- tv_recycler_out.adapter = home_tv_adapter
-- mv_recycler_out.adapter = home_mv_adapter
-- cv_recycler_out.adapter = home_cv_adapter
-- sv_recycler_out.adapter = home_sv_adapter
-- function getHomePage1Datas(page, tag, datas)
--     local hdata = {}
--     hdata.page = page
--     hdata.tag = tag
--     hdata.site = home_douban
--     hdata.callback = function(res)
--         --  print(cjson.encode(d))
--         if res.flag then
--             if #res.datas == 0 then
--                 showToast("没有更多数据了!", 0, activity.height * 0.8)
--                 return
--             end
--             for k, v in pairs(res.datas) do
--                 table.insert(datas, v)
--                 if tag == 1 and home_tv_adapter then
--                     home_tv_adapter.notifyDataSetChanged()
--                 elseif tag == 2 and home_mv_adapter then
--                     home_mv_adapter.notifyDataSetChanged()
--                 elseif tag == 3 and home_cv_adapter then
--                     home_cv_adapter.notifyDataSetChanged()
--                 elseif tag == 4 and home_sv_adapter then
--                     home_sv_adapter.notifyDataSetChanged()
--                 end
--                 -- adapter.notifyDataSetChanged()
--             end
--         end
--     end
--     dataUtil.getClassDatas(hdata)
-- end
-- getHomePage1Datas(1, 1, home_tv_datas)
-- getHomePage1Datas(1, 2, home_mv_datas)
-- getHomePage1Datas(1, 3, home_cv_datas)
-- getHomePage1Datas(1, 4, home_sv_datas)

-- 获取推荐影片结束

home_history_out.onClick = function()
    import "utils.HistoryUtil"
    historyUtil = HistoryUtil()
    historys = historyUtil.getHistorys()
    if #historys == 0 then

        activity.newActivity("pages/history/history").overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out);
    else
        activity.newActivity("pages/play/play", {historys[1]}).overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out);
    end
end

import "pages.home.home.menu"

import "pages.home.home.home_set"

