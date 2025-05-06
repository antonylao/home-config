print("/lua/picco/apl-remap.lua loaded")
-- remap all from insert mode, using the prefix key `²`. at the end, remap to <LocalLeader>

-- antony ~ 2025-04-22: mappings from vim-apl, modified for french keyboard


-- let b ='⍺¨¯<≤=≥>≠∨∧×÷ ⍺⌶⍫⍒⍋⌽⍉⊖⍟⍱⍲!⌹'
-- let b.='⋄⍵∊⍴~↑↓⍳○*←→  ⌺⍵⍷⍴⍨↑↓⍸⍥⍣⍞⍬'
-- let b.='?⌈⌊∥∇∆∘⊚⎕⍎⍕⊢ ⍰⌈⌊⍛⍢∆⍤⌸⌷≡≢⊣ '
-- let b.='⊢⊂⊃∩∪⊥⊤|⍝⍀⌿    ⊣⊆⊇∩∪⊥⊤|⍪⍙⍠  '
-- NB: non valid. ⍰ ⍛?
if (false) then
  -- assign
  vim.keymap.set("i", "²[", "←")
  vim.keymap.set("i", "²-", "×")
  vim.keymap.set("i", "²=", "÷")
  -- power
  vim.keymap.set("i", ":-<Tab>", "*")

  -- comment
  vim.keymap.set("i", "²,", "⍝")
end
--alternate keybindings with tab (may slow down insertion of chars because using common chars
if (false) then
  vim.keymap.set("i", "<-<Tab>", "←")
  vim.keymap.set("i", "xx<Tab>", "×")
  vim.keymap.set("i", ":-<Tab>", "÷")
end
