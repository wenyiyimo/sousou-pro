import "utils.CalendarUtil"
calendarUtil = CalendarUtil()
calendars = calendarUtil.getDatas()
calendar = {search_data[2]["标题"], search_data[2]["图片"], {}}
local calendar_num = calendarUtil.getDataNum({search_data[2]["标题"]})
if calendar_num > 0 then
    calendar = calendars[calendar_num]
    local temp = "日程:"
    for k, v in pairs(calendar[3]) do
        temp = temp .. " " .. v
    end
    calendarout.setText(temp)
end

calendar_data = {"周一", "周二", "周三", "周四", "周五", "周六", "周日"}

calendarAdapter = LuaCustRecyclerAdapter(AdapterCreator({

    getItemCount = function()
        return #calendar_data
    end,
    getItemViewType = function(position)
        return 0
    end,
    onCreateViewHolder = function(parent, viewType)
        local views = {}
        holder = LuaCustRecyclerHolder(loadlayout(calendarItem, views))
        holder.view.setTag(views)
        return holder
    end,
    onBindViewHolder = function(holder, position)
        view = holder.view.getTag()
        view.nameout.text = calendar_data[position + 1]
        local flag, num = judgeValueInTable(calendar[3], calendar_data[position + 1])
        if flag then
            view.nameout.textColor = ColorStyles().blue
        else
            view.nameout.textColor = ColorStyles().black
        end

        view.item.onClick = function()
            if flag then
                table.remove(calendar[3], num)

            else
                table.insert(calendar[3], calendar_data[position + 1])
            end
            calendars = calendarUtil.setData(calendar)
            calendarAdapter.notifyDataSetChanged()
        end

    end
}))

function getCalendarDialog(item)
    local dialog = Dialog(activity)

    -- 设置弹窗布局
    dialog.setContentView(loadlayout(item))
    -- 设置弹窗位置
    dialog.getWindow().setGravity(Gravity.CENTER)
    dialog.getWindow().setBackgroundDrawable(ColorDrawable(0xffffffff))
    -- 设置触摸弹窗外部隐藏弹窗

    -- dialog.setCanceledOnTouchOutside(false);
    -- else
    dialog.setCanceledOnTouchOutside(true);
    -- end
    local p = dialog.getWindow().getAttributes()
    p.dimAmount = 0
    local dlna_size = math.min(activity.width * 0.7, activity.height * 0.7)
    p.width = dlna_size
    p.height = -2;
    dialog.getWindow().setAttributes(p);
    -- dialog.getWindow().getDecorView().setPadding(0,0,0,0)
    dialog.getWindow().attributes.systemUiVisibility = View.SYSTEM_UI_FLAG_HIDE_NAVIGATION or
                                                           View.SYSTEM_UI_FLAG_IMMERSIVE
    dialog.show()
    return dialog
end
calendarout.onClick = function()
    if calendarDialog then
        calendarDialog.show()
    else
        calendarDialog = getCalendarDialog(calendarLayout)
        calendarBodyout.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL))
        calendarBodyout.setAdapter(calendarAdapter)
        -- dlnaAdapter.notifyDataSetChanged()
        calendarDialog.onDismiss = function()
            -- body
            -- controlPoint.stop()
            if #calendar[3] > 0 then
                local temp = "日程:"
                for k, v in pairs(calendar[3]) do
                    temp = temp .. " " .. v
                end
                calendarout.setText(temp)
            else
                calendarout.setText("加入日程")
            end
        end
    end

end
