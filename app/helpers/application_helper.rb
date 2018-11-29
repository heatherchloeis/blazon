module ApplicationHelper

	# Returns the full title on a per-page basis
	def full_title(page_title = '')
		base_title = "Canary"
		if page_title.empty?
			base_title
		else
			page_title + " | " + base_title
		end
	end

	# Styles @mentions when added to chirp content
	def markdown(text)
		renderer = Redcarpet::Render::SmartyHTML.new(filter_html: true,
																								 hard_wrap: true,
																								 prettify: true)
		markdown = Redcarpet::Markdown.new(renderer, markdown_layout)
		markdown. render(sanitize(text)).html_safe
	end

	def markdown_layout
		{ autolink: true, 
			space_after_headers: true,
			no_intra_emphasis: true,
			tables: true,
			strikethrough: true,
			highlight: true,
			underline: true,
			fenced_code_blocks: true,
			disable_indented_code_blocks: true,
			lax_spacing: true
		}
	end
end
