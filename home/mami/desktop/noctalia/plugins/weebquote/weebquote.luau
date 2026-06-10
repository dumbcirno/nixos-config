local scriptPath = noctalia.expandPath("~/.config/noctalia/scripts/weebquote")

local function unescapeJson(value)
  if value == nil then
    return nil
  end
  return value
    :gsub("\\n", "\n")
    :gsub("\\t", "\t")
    :gsub('\\"', '"')
    :gsub("\\\\", "\\")
end

local function parseQuoteJson(line)
  local text = unescapeJson(line:match('"text"%s*:%s*"(.-)"%s*,'))
  local tooltip = unescapeJson(line:match('"tooltip"%s*:%s*"(.-)"'))
  return text, tooltip
end

local function applyQuote(line)
  local text, tooltip = parseQuoteJson(line)
  if text == nil or text == "" then
    return
  end
  barWidget.setText(text)
  barWidget.setTooltip(tooltip or text)
end

local function runQuote(force)
  local cmd = scriptPath
  if force then
    cmd = cmd .. " --force"
  end
  noctalia.runStream(cmd, function(line)
    if line ~= nil and line ~= "" then
      applyQuote(line)
    end
  end)
end

function update()
  noctalia.setUpdateInterval(60000)
  runQuote(false)
end

function onClick()
  runQuote(true)
end
