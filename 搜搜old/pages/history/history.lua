require("import");
import("common.BaseActivity");
import "pages.history.layout"
import "utils.HistoryUtil"

import "android.text.Html"
activity.setContentView(layout);
historyUtil = HistoryUtil()
historys = historyUtil.getHistorys()
function dealPlayTime(time)
  if time < 0 then
    return "00:00"
  end

  local miao = tostring(tointeger(time * 0.001 % 60))
  local fen = tostring(tointeger(time * 0.001 / 60))
  if #miao == 1 then
    miao = "0" .. miao
  end
  if #fen == 1 then
    fen = "0" .. fen
  end
  return fen .. ":" .. miao
end
bodyout.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL))
adapter = LuaCustRecyclerAdapter(AdapterCreator({

  getItemCount = function()
    return #historys
  end,

  getItemViewType = function(position)
    return 0
  end,

  onCreateViewHolder = function(parent, viewType)
    local views = {}
    holder = LuaCustRecyclerHolder(loadlayout(itemout, views))
    holder.view.setTag(views)
    return holder
  end,
  onBindViewHolder = function(holder, position)
    -- print(historys[position+1][1])
    view = holder.view.getTag()
    view.nameout.text = "来源：" .. historys[position + 1][1].name
    view.titleout.text = Html.fromHtml(historys[position + 1][2]['标题'])
    -- view.stateout.text = historys[position + 1][2]['状态']


    if historys[position + 1][3]["播放"] and tostring(historys[position + 1][3]["播放"])~="nil" then
     else
      historys[position + 1][3]["播放"] ="未知"
    end


    view.stateout.text = "历史：" .. historys[position + 1][3]['播放'] .. ' ' ..
    dealPlayTime(historys[position + 1][3]['进度'])
    local url = historys[position + 1][2]['图片']

    glideImg(view.picout, url)

    -- 子项目点击事件

    -- 为Item设置点击事件
    view.singleItem.onClick = function()
      -- setting.saveString("search", cjson.encode(bodyhistorys))
      -- getSameTitle(historys[position + 1]["标题"],historys[position + 1]["地址"])
      activity.newActivity("pages/play/play", {historys[position + 1]})
    end;
    view.singleItem.onLongClick = function()

      dialog = AlertDialog.Builder(this) -- .setTitle("提示")
      .setMessage("你想对此条观看记录？").setPositiveButton("删除", {
        onClick = function(v)
          historys = historyUtil.removeHistory(historys[position + 1])

          adapter.notifyDataSetChanged()
        end
      }).setNegativeButton("取消", nil).show()
      dialog.create()

      -- 更改Button颜色
      import "android.graphics.Color"
      dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(ColorStyles().blue)
      dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(ColorStyles().blue)
      dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(ColorStyles().blue)
    end
  end
}))

-- RecyclerView绑定适配器
bodyout.setAdapter(adapter)

clearout.onClick = function()
  dialog = AlertDialog.Builder(this) -- .setTitle("提示")
  .setMessage("确定清空所有收藏记录吗？").setPositiveButton("确定", {
    onClick = function(v)
      historys = historyUtil.clearHistorys()
      adapter.notifyDataSetChanged()
    end
  }) --  .setNeutralButton("取消",nil)
  .setNegativeButton("取消", nil).show()
  dialog.create()

  -- 更改Button颜色
  import "android.graphics.Color"
  dialog.getButton(dialog.BUTTON_POSITIVE).setTextColor(ColorStyles().blue)
  dialog.getButton(dialog.BUTTON_NEGATIVE).setTextColor(ColorStyles().blue)
  dialog.getButton(dialog.BUTTON_NEUTRAL).setTextColor(ColorStyles().blue)

end

function onResume()
  historys = historyUtil.getHistorys()
  adapter.notifyDataSetChanged()
end
