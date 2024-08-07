P = function(v)
  print(vim.inspect(v))
  return v
end

PD = function(v)
  vim.notify(vim.inspect(v))
end

function StartsWith(str, substr)
  return str:sub(1, #substr) == substr
end
