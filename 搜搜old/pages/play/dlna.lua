import "org.cybergarage.upnp.ControlPoint"
import "org.cybergarage.upnp.device.SearchResponseListener"
import "org.cybergarage.upnp.Service"
import "org.cybergarage.upnp.Device"
import "org.cybergarage.upnp.ssdp.SSDPPacket"
import "org.cybergarage.upnp.device.NotifyListener"
import "org.cybergarage.upnp.device.DeviceChangeListener"

deviceLists = {}
dlnaNum = 0
dlnaName = nil
controlPoint = nil
dlnaDialog = nil
dlnaAdapter = LuaCustRecyclerAdapter(AdapterCreator({

    getItemCount = function()
        return #deviceLists
    end,
    getItemViewType = function(position)
        return 0
    end,
    onCreateViewHolder = function(parent, viewType)
        local views = {}
        holder = LuaCustRecyclerHolder(loadlayout(dlnaItem, views))
        holder.view.setTag(views)
        return holder
    end,
    onBindViewHolder = function(holder, position)
        view = holder.view.getTag()
        view.nameout.text = deviceLists[position + 1][1].friendlyName
        if dlnaName and dlnaName == deviceLists[position + 1][1].friendlyName then
            view.nameout.textColor = ColorStyles().blue
        else
            view.nameout.textColor = ColorStyles().black
        end

        view.item.onClick = function()
            dlnaName = deviceLists[position + 1][1].friendlyName
            dlnaAdapter.notifyDataSetChanged()
            dlnaPlay(trueUrl, deviceLists[position + 1])
        end

    end
}))

function removeDevice(device)
    pcall(function()
        Looper.prepare();
    end)
    for k, v in pairs(deviceLists) do
        if v[1] == device then
            table.remove(deviceLists, k)
            return
        end
    end
    activity.runOnUiThread(Runnable {
        run = function()
            -- adpdlna.notifyDataSetChanged()
            dlnaAdapter.notifyDataSetChanged()

        end
    })
end

function dlnaPlay(url, deviceItem)
    -- url="https://v.cdnlz9.com/20240510/24384_098fd77c/index.m3u8"
    instanceID = "0"
    currentURI = url

    device = deviceItem[1]

    service = device.getService(deviceItem[2])

    transportAction = service.getAction("SetAVTransportURI")

    transportAction.setArgumentValue("InstanceID", instanceID);
    transportAction.setArgumentValue("CurrentURI", currentURI);

    if (transportAction.postControlAction()) then
        playAction = service.getAction("Play")
        playAction.setArgumentValue("InstanceID", instanceID);

        --   if (~playAction.postControlAction()) then

        showToast("投屏成功！")
        -- else
        -- print(playAction.getStatus().getDescription())

        --  showToast( transportAction.getStatus().getDescription())
        -- end
    else
        showToast("暂不支持的设备！")
    end
end

function addDevice(device)
    pcall(function()
        Looper.prepare();
    end)
    for k, v in pairs(deviceLists) do
        if v[1] == device[1] then
            return
        end
    end
    table.insert(deviceLists, device)

    activity.runOnUiThread(Runnable {
        run = function()
            dlnaAdapter.notifyDataSetChanged()

            -- dlnaPlay("https://v.cdnlz9.com/20240510/24384_098fd77c/index.m3u8")

        end
    })
end

function searchDlna()
    controlPoint = ControlPoint()
    controlPoint.start()
    controlPoint.search()
    controlPoint.addDeviceChangeListener(DeviceChangeListener {
        deviceRemoved = function(device)
            -- print( device.friendlyName)
            removeDevice(device)
        end,
        deviceAdded = function(device)
            pcall(function()
                Looper.prepare();
            end)
            -- print(device.serviceList.size())
            serviceLists = device.getServiceList()
            -- print(serviceLists)
            for i = 0, device.serviceList.size() - 1 do

                if serviceLists[i] and (serviceLists[i].getServiceType():find("AVTransport")) then
                    addDevice({device, serviceLists[i].getServiceType()})
                    -- print(device.friendlyName)
                end
            end
        end
    })
end

function getDlnaDialog(item)
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
    p.height = dlna_size;
    dialog.getWindow().setAttributes(p);
    -- dialog.getWindow().getDecorView().setPadding(0,0,0,0)
    dialog.getWindow().attributes.systemUiVisibility = View.SYSTEM_UI_FLAG_HIDE_NAVIGATION or
                                                           View.SYSTEM_UI_FLAG_IMMERSIVE
    dialog.show()
    return dialog
end

dlnaout.onClick = function()
    if dlnaDialog then
        dlnaDialog.show()
    else
        dlnaDialog = getDlnaDialog(dlnaLayout)
        dlnaBodyout.setLayoutManager(StaggeredGridLayoutManager(1, StaggeredGridLayoutManager.VERTICAL))
        dlnaBodyout.setAdapter(dlnaAdapter)
        dlnaAdapter.notifyDataSetChanged()
        dlnaDialog.onDismiss = function()
            -- body
            controlPoint.stop()
        end
    end
    searchDlna()

end