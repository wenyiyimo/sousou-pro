require("import");
import("common.BaseActivity");
import "pages.calendar.layout"
import "utils.CalendarUtil"

activity.setContentView(layout);
bodyout.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL))
calendarUtil = CalendarUtil();
calendars = calendarUtil.getWeekDatas()
adapter = LuaCustRecyclerAdapter(AdapterCreator({

    getItemCount = function()
        return #calendars
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

        view.titleout.text = calendars[position + 1][1]

        view.stateout.text = calendars[position + 1][3]

        local url = calendars[position + 1][2]

        glideImg(view.picout, url)

        -- 子项目点击事件

        -- 为Item设置点击事件
        view.singleItem.onClick = function()
            -- setting.saveString("search", cjson.encode(bodyhistorys))
            -- getSameTitle(historys[position + 1]["标题"],historys[position + 1]["地址"])
            activity.newActivity("pages/search/search/search", {calendars[position + 1][1]})
        end;
        view.singleItem.onLongClick = function()
            dialog = AlertDialog.Builder(this) -- .setTitle("提示")
            .setMessage("你想删除此条日程？").setPositiveButton("删除", {
                onClick = function(v)
                    calendarUtil.removeData(table.remove(calendars, position + 1))
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
    .setMessage("确定清空所有日程吗？").setPositiveButton("确定", {
        onClick = function(v)
            calendars = calendarUtil.clearDatas()
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
    calendars = calendarUtil.getWeekDatas()
    adapter.notifyDataSetChanged()
end
