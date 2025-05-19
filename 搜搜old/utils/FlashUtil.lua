function setWave(id, color)
    import "android.content.res.ColorStateList"
    local attrsArray = {android.R.attr.selectableItemBackgroundBorderless}
    local typedArray = activity.obtainStyledAttributes(attrsArray)
    ripple = typedArray.getResourceId(0, 0)
    Pretend = activity.Resources.getDrawable(ripple)
    Pretend.setColor(ColorStateList(int[0].class {int {}}, int {color}))
    id.setBackground(Pretend.setColor(ColorStateList(int[0].class {int {}}, int {color})))
end

function setWater(view, time)
    import "android.animation.ObjectAnimator"
    ObjectAnimator().ofFloat(view, "scaleX", {1.2, .8, 1.1, .9, 1}).setDuration(time).start()
    ObjectAnimator().ofFloat(view, "scaleY", {1.2, .8, 1.1, .9, 1}).setDuration(time).start()
end

-- 清风的进度条
function setProgress(bgcolor)
    local bg4 = LuaDrawable(function(c, p, d)
        import "android.widget.FrameLayout"
        import "android.widget.TextView"
        import "android.R$id"
        import "com.androlua.LuaDrawable"
        import "android.graphics.Color"
        import "android.graphics.DashPathEffect"
        import "android.graphics.RectF"
        import "android.graphics.SweepGradient"
        import "android.R$layout" -- 导入所需类
        p.setColor(Color.parseColor(bgcolor)); -- 单色进度条颜色
        p.setAntiAlias(true); -- 抗锯齿
        p.setStrokeWidth(10); -- 转动条宽度
        local b = d.bounds
        local r = math.min(b.right, b.bottom) / 3
        b = RectF(r / 2, r / 2, r * 2.5, r * 2.5)
        p.setStyle(p.class.Style.STROKE)
        p.setShadowLayer(0, 0, 0, Color.BLACK)
        mShader = SweepGradient(r * 1.5, r * 1.5, int {Color.RED, Color.GREEN, Color.BLUE, Color.RED, Color.GREEN,
                                                       Color.BLUE, Color.RED, Color.GREEN, Color.BLUE}, nil);
        -- p.setShader(mShader);--设置七彩进度条
        effects = DashPathEffect(float {r / 2, r / 3}, 1);
        p.setPathEffect(effects);
        local n = 0
        local m = 0
        local sn = 6
        local sm = 2
        return function(c)
            if n > 360 then
                sm = sm + sn
                sn = 0 - sn
            elseif n < 0 then
                sn = 6
                sm = 2
            end
            n = n + sn
            m = (m + sm) % 360
            c.drawArc(b, m, n, false, p)
            d.invalidateSelf()
        end
    end)
    return bg4
end
-- BackgroundDrawable=绘制进度条("#FF75AC6D");
