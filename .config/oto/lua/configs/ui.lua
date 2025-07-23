local M = {}
function M.winhighlight()
	-- `0` significa que o destaque é definido globalmente para todos os buffers e janelas.
	-- Esses serão os "SourceHighlightGroup" que você usará no 'winhighlight'.
	vim.api.nvim_set_hl(0, "MeuNormalFloat", { fg = "#54546D", bg = "#1F1F28", bold = false }) -- Texto branco, fundo escuro
	vim.api.nvim_set_hl(0, "MinhaBordaFloat", { fg = "#2A2A37", bg = "#1F1F28", bold = false }) -- Borda azul clara, negrito
	vim.api.nvim_set_hl(0, "MinhaCursorLineFloat", { bg = "#2A2A37", underline = true }) -- Fundo cinza escuro, sublinhado
	vim.api.nvim_set_hl(0, "MeuLineNrFloat", { fg = "#2D4F67", bg = "#1F1F28", italic = true }) -- Números azuis, itálico
	-- Você pode adicionar mais grupos de destaque aqui conforme a necessidade.
end

--- @brief Aplica uma string de 'winhighlight' a uma janela específica.
-- @param win_id number O ID da janela (obtido de nvim_open_win, por exemplo).
-- @param highlight_string string A string formatada para 'winhighlight' (ex: "Normal:MeuNormalFloat,FloatBorder:MinhaBordaFloat").
function M.aply(win_id, highlight_string)
	-- Verifica se o ID da janela é válido antes de aplicar a opção
	if not vim.api.nvim_win_is_valid(win_id) then
		-- Opcional: Você pode imprimir um aviso se a janela não for encontrada.
		-- print("Aviso: Tentativa de aplicar destaque a um ID de janela inválido: " .. win_id)
		return
	end

	-- Define a opção 'winhighlight' para a janela específica
	-- O terceiro argumento `{ win = win_id }` é crucial para tornar a opção local à janela [conversa anterior].
	vim.api.nvim_set_option_value("winhighlight", highlight_string, { win = win_id })
end

function M.border(glyph, msg_lvl, hl_name)
	return {
		{ glyph, msg_lvl },
		{ "─", hl_name },
		{ "╮", hl_name },
		{ "│", hl_name },
		{ "╯", hl_name },
		{ "─", hl_name },
		{ "╰", hl_name },
		{ "│", hl_name },
	}
end

return M
