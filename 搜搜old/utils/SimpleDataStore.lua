function SimpleDataStore(tableName)
    local self = {

        pr = this.getSharedPreferences(tableName, activity.MODE_PRIVATE)
    }
    -- 获取字符串类型的值
    local function getString(key, value)
        return self.pr.getString(key, value)
    end

    -- 获取整数类型的值
    local function getInt(key, value)
        return self.pr.getInt(key, value)
    end

    -- 获取布尔类型的值
    local function getBoolean(key, value)
        return self.pr.getBoolean(key, value)
    end

    -- 保存字符串类型的值
    local function saveString(key, value)
        editor = self.pr.edit()
        editor.putString(key, value)
        editor.commit()
        return true
    end

    -- 保存字符串类型的值
    local function setString(key, value)
        editor = self.pr.edit()
        editor.putString(key, value)
        editor.commit()
        return true
    end

    -- 保存整数类型的值
    local function saveInt(key, value)
        editor = self.pr.edit()
        editor.putInt(key, value)
        editor.commit()
        return true
    end
    -- 保存整数类型的值
    local function setInt(key, value)
        editor = self.pr.edit()
        editor.putInt(key, value)
        editor.commit()
        return true
    end

    -- 保存布尔类型的值
    local function saveBoolean(key, value)

        editor = self.pr.edit()
        editor.putBoolean(key, value)
        editor.commit()
        return true
    end
    -- 保存布尔类型的值
    local function setBoolean(key, value)

        editor = self.pr.edit()
        editor.putBoolean(key, value)
        editor.commit()
        return true
    end

    -- 删除指定键的值
    local function delete(key)
        editor = self.pr.edit()
        editor.remove(key)
        editor.commit()
        return true
    end

    return {
        saveBoolean = saveBoolean,
        getBoolean = getBoolean,
        saveInt = saveInt,
        saveString = saveString,
        setString = setString,
        setInt = setInt,
        setBoolean = setBoolean,
        delete = delete,
        getString = getString,
        getInt = getInt
    }
end
