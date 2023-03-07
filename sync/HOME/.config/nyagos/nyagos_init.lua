local M = {}

function M.setup()
  require("zoxide").setup()

  -- nyagos.env.prompt = "$L" .. nyagos.getenv "COMPUTERNAME" .. ":$P$G"
  set {
    PROMPT = "$s$P",
  }

  function nyagos.alias.gg(args)
    local result = nyagos.eval "ghq list -p| fzf --reverse +m"
    if result then
      nyagos.eval("cd " .. result)
    end
  end

  function nyagos.alias.gst(args)
    nyagos.exec "git status"
  end

  local function search_history(this, is_prev)
    -- カーソル位置が一番左の場合は通常のnext/prev
    if this.pos == 1 then
      if is_prev == true then
        this:call "PREVIOUS_HISTORY"
      else
        this:call "NEXT_HISTORY"
      end
      this:call "BEGINNING_OF_LINE"
      return nil
    end

    -- 検索キーワード
    local search_string = this.text:sub(1, this.pos - 1)

    -- 重複を除いたhistoryリストの取得
    local history_uniq = {}
    local is_duplicated = false
    local hist_len = nyagos.gethistory()
    for i = 1, hist_len do
      local history
      -- 新しい履歴がリスト後ろに残るよう末尾からサーチ
      history = nyagos.gethistory(hist_len - i)
      for i, e in ipairs(history_uniq) do
        if history == e or history == search_string then
          is_duplicated = true
        end
      end
      if is_duplicated == false then
        if is_prev == true then
          table.insert(history_uniq, history)
        else
          table.insert(history_uniq, 1, history)
        end
      end
      is_duplicated = false
    end

    -- 入力と完全一致する履歴を探す
    -- 完全一致する履歴を起点にすることで
    -- (見かけ上)インクリメンタルな検索にする
    local hist_pos = 0
    for i, e in ipairs(history_uniq) do
      if e == this.text then
        hist_pos = i
        break
      end
    end

    -- 前方一致する履歴を探す
    local matched_string = nil
    for i = hist_pos + 1, #history_uniq do
      if history_uniq[i]:match("^" .. search_string .. ".*") then
        matched_string = history_uniq[i]
        break
      end
    end

    -- 見つかった履歴を出力
    -- 見つからなければ、検索キーワードを出力
    this:call "KILL_WHOLE_LINE"
    if matched_string ~= nil then
      this:insert(matched_string)
    else
      this:insert(search_string)
    end
    this:call "BEGINNING_OF_LINE"
    for i = 1, this.pos - 1 do
      this:call "FORWARD_CHAR"
    end
  end

  nyagos.bindkey("C_N", function(this)
    search_history(this, false)
  end)

  nyagos.bindkey("C_P", function(this)
    search_history(this, true)
  end)

  function nyagos.alias.pipup(args)
    nyagos.eval "py -m pip install pip --upgerade"
  end

  nyagos.envadd("PATH", "~/.cargo/bin")
  nyagos.envadd("PATH", "~/local/bin")
  nyagos.envadd("PATH", "C:/Python310/Scripts")

  nyagos.complete_for.git = require("completion_git").complete_for

  nyagos.prompt = require("prompt").prompt2
end

return M
