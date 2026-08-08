-- Display marks in gutter (does more, but I don't use that)
return {
  'chentoast/marks.nvim',
  keys = {
    'm'
  },
  opts = {
    -- mappings = {
    --   {'m,', 'set_next'},               -- Set next available lowercase mark at cursor.
    --   {'m;', 'toggle'},                 -- Toggle next available mark at cursor.
    --   {'dm-', 'delete_line'},            -- Deletes all marks on current line.
    --   {'dm<Space>', 'delete_buf'},             -- Deletes all marks in current buffer.
    --   {'m]', 'next'},                   -- Goes to next mark in buffer.
    --   {'m[', 'prev'},                   -- Goes to previous mark in buffer.
    --   {'m:', 'preview'},                -- Previews mark (will wait for user input). press <cr> to just preview the next mark.
    --   -- {'m', 'set'}                    -- Sets a letter mark (will wait for input).
    --   -- {'', 'delete'}                 -- Delete a letter mark (will wait for input).
    --
    --   -- {'', 'set_bookmark0'}      -- Sets a bookmark from group[0-9].
    --   -- {'', 'delete_bookmark0'}   -- Deletes all bookmarks from group[0-9].
    --   -- {'', 'delete_bookmark'}        -- Deletes the bookmark under the cursor.
    --   -- {'', 'next_bookmark'}          -- Moves to the next bookmark having the same type as the
    --                                 -- bookmark under the cursor.
    --   -- {'', 'prev_bookmark'}          -- Moves to the previous bookmark having the same type as the
    --                                 -- bookmark under the cursor.
    --   -- {'', 'next_bookmark0'}         --Moves to the next bookmark of the same group type. Works by
    --                                 -- first going according to line number, and then according to buffer
    --                                 -- number.
    --   --0 {'', 'prev_bookmark0'}         -- Moves to the previous bookmark of the same group type. Works by
    --                                 -- first going according to line number, and then according to buffer
    --                                 -- number.
    --   -- {'', 'annotate'}               -- Prompts the user for a virtual line annotation that is then placed
    --                             -- above the bookmark. Requires neovim 0.6+ and is not mapped by default.
    -- }
  }
}
