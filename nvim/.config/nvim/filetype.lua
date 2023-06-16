vim.filetype.add({
  filename = {
    ['.env.local'] = "sh",
    ['.env.development'] = "sh",
    ['*.env'] = "sh"
  },
})
